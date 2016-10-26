##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
import smilPython as sp
import numpy as np
from optparse import OptionParser
import matplotlib.pyplot as plt
from scipy import misc
from skimage import filter, color

##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
def gray_area_filtering(imin,  size):
    """
    Gray level area filtering.
    Only V4 connexity is available.
    """
    imtmp = sp.Image(imin)
    sp.areaClose(imin, size, imtmp)
    sp.areaOpen(imtmp,  size, imin)
    
def my_area_filtering(imin, size):
    """
    Filtering of a gray level or color image.
    Only V4 connexity is available.
    """
    if imin.getTypeAsString() == "RGB":
        im = sp.Image()
        sp.splitChannels(imin, im)
        for i in range(3):
            gray_area_filtering(im.getSlice(i), size)
        sp.mergeChannels(im, imin)
    else:
        gray_area_filtering(imin, size)
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------    
def my_gradient(imin, se, grey=False):
    """
    Returns morphological gradient for grey level images, or the LAB gradient for color images.

    Input:
    imin : grey level or color image
    se : structuring element
    grey (Bool): if set to True, on colour images we compute the morphological gradient on the green channel.

    Output:
    imout : UINT8 image containing the gradient
    """

    if imin.getTypeAsString() == "RGB":
        if grey is True:
            tmpIm = sp.Image()
            imout = sp.Image(tmpIm)
            sp.copyChannel(imin, 1, tmpIm)
            sp.gradient(tmpIm, imout, se)
        else:
            imout = sp.Image(imin)
            gradient_LAB(imin,  imout,  se)
    else:
        imout = sp.Image(imin)
        sp.gradient(imin, imout, se)

    return imout
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
def im_labelled_square_grid_points(size, step, margin=1):
    """
    Creates a regular grid of square cells. 
    Input:
    size : list of 2d dimensions of output image
    step: minimum distance between two cell centers (we suppose that the step is the same in all directions)

    Output:
    imout : UINT16 image containing the labelled grid centers.
    imout2 : UINT16 image containing the labelled cells.
    """  
    imout = sp.Image(size[0], size[1])
    imout2 = sp.Image(imout,"UINT16")
    imout = sp.Image(imout2)
    
    np_im = imout.getNumArray()
    np_im.fill(0)
    cells_im = imout2.getNumArray()
    cells_im.fill(0)
    
    label = 1
    for x in range(size[0]/step+1):
        for y in range(size[1]/step+1):
            center_x = np.min([ x*step + step/2, size[0]-1])
            center_y = np.min([ y*step + step/2, size[1]-1])
            np_im[center_x, center_y] = label
            cells_im[x*step+margin:(x+1)*step-margin, y*step+margin:(y+1)*step-margin] = label
            label += 1

    return (imout, imout2)
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
def one_min_per_grid_cell(im_cells_lbl, blobs, im_labelled_minima, se):
    """
    Enables to select the best marker of each cell of the grid.
    
    Input:
    im_cells_lbl (UINT16): image of labelled cells.
    blobs: definition of each connected component
    im_labelled_minima (UINT16): image of markers candidates labelled with their ranking for some given criterium (e.g. surfacic extinction), i.e. "1" is the best.
    se: structuring element.
    
    """
    ## Selection of the marker with the best ranking in each cell: 
    imtmp = sp.Image(im_cells_lbl)
    sp.test(im_labelled_minima,  im_labelled_minima, 65335,  im_labelled_minima)
    minVals = sp.measMinVals(im_labelled_minima, blobs)
    sp.applyLookup(im_cells_lbl, minVals, imtmp)
    sp.compare(im_labelled_minima, "==", imtmp, im_labelled_minima, 0, im_labelled_minima)
    ## Selection of only one marker if several met the previous requirement in the same cell:
    sp.label(im_labelled_minima, imtmp, se)
    blobs2 = sp.computeBlobs(im_labelled_minima)
    maxVals = sp.measMaxVals(imtmp, blobs)
    sp.applyLookup(im_cells_lbl, maxVals, im_labelled_minima)
    sp.compare(imtmp, "==", im_labelled_minima, imtmp, 0, imtmp)
    sp.test(im_cells_lbl, imtmp, 0, im_labelled_minima) 
    
    return
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
def demo_m_waterpixels(imin,  step,  d_weight, filter_ori):
    """ 
    Compute m-waterpixels, i.e. superpixels based on the watershed transformation. 
    Flooding starts form the best minimum of each cell of a regular grid. 
    The gradient used to be flooded is regularized using the distance function to these minima.
    Cells of the grid are chosen here to be squares.
    
    Input :
    imin (image UINT8): original image, to be segmented into superpixels
    step (UINT8) : grid step, i.e. distance between two cell centers of the grid
    d_weight (UINT8) : constant to be multiplied with function distance before addition to gradient image.
        If d_weight <=0, then only the gradient is taken into account.
    filter_ori (BOOLEAN) : do we filter the input image?

    Output:
    image (UINT16) : labelled superpixels
    image (UINT8) : distance weighted gradient function
    image (UINT16) : minima used in the computation
    """
    ##-----------------------------------------------------------------------------------------
    ##-----------------------------------------------------------------------------------------   
    # Connexity:
    basicse = sp.CrossSE()
    gridse = sp.SquSE()

    # Ori filtering
    if filter_ori is True:
        my_area_filtering(imin, step*step/16)

    # Gradient computation
    im_grad = my_gradient(imin, basicse,  True)

    ## Pool of working images:
    imwrk0 = sp.Image(im_grad)
    imwrk1 = sp.Image(im_grad,  "UINT16")
    imwrk2 = sp.Image(im_grad,  "UINT16")

    # Compute cell centers and cells
    size = imin.getSize()
    im_markers, im_cells = im_labelled_square_grid_points(size, step, step/6) 

    ##-----------------------------------------------------------------------------------------
    ##-----------------------------------------------------------------------------------------
    ## Choice of the markers : one per grid cell
    ##-----------------------------------------------------------------------------------------
    ##-----------------------------------------------------------------------------------------

    # Step 1 : Computation of the minima of the gradient
    im_minima = sp.Image(im_grad)
    sp.minima(im_grad, im_minima, basicse)
    #Step 2 : Imposing minimum distance between minima (= Removing minima candidates which fall on cell margins )
    sp.test(im_cells, im_minima, 0, imwrk0)
    sp.label(imwrk0, imwrk1, basicse)
    #Step 3 : Evaluation of the importance of minima ( = computation of their surfacic extinction)
    im_minima_val = sp.Image(imwrk1)
    sp.watershedExtinction( im_grad, imwrk1, im_minima_val, "a", basicse)
    # Step 4 : Taking back at value 2 the minima of null-volumic extinction 
    sp.test( imwrk0,  2,  0,  imwrk2)
    sp.test( im_minima_val,  im_minima_val, imwrk2, im_minima_val )
    # Step 5 : Coping with the potential absence of minimum in cells (= choosing the minimum value inside this cell as its marker if necessary)
    imwrk00=sp.Image(imwrk0)
    blobs = sp.computeBlobs(im_cells)
    sp.test(im_cells, im_grad, 0, imwrk00)
    minVals = sp.measMinVals(imwrk00, blobs)
    sp.applyLookup(im_cells, minVals, imwrk0)
    sp.test(imwrk00==imwrk0, 1, 0, imwrk1)
    maxVals = sp.measMaxVals(im_minima_val, blobs)
    sp.applyLookup(im_cells, maxVals, imwrk2)
    sp.test(imwrk2, im_minima_val, imwrk1, im_minima_val)
    # Step 6 : Selection of one marker per cell
    one_min_per_grid_cell(im_cells, blobs, im_minima_val, basicse)

    ##-----------------------------------------------------------------------------------------
    ##-----------------------------------------------------------------------------------------
    ## Spatial regularization of the gradient
    ##-----------------------------------------------------------------------------------------
    ##-----------------------------------------------------------------------------------------  
    
    #Step 1 : Computation of the distance function to the markers
    immask = sp.Image(im_markers, "UINT8")
    sp.test(im_minima_val, 0, 1, immask)
    imdist = sp.Image(immask, "UINT8")
    sp.dist(immask, imdist, gridse)
    #Step 2 : Adding the distance function to the gradient
    if d_weight > 0:
        weight = d_weight * float(2)/step
        sp.mul(imdist, weight, imdist)
        sp.add(imdist, im_grad, im_grad)

    ##-----------------------------------------------------------------------------------------
    ##-----------------------------------------------------------------------------------------
    ## Superpixel segmentation : watershed transformation, flooding from selected minima on the regularized gradient
    ##-----------------------------------------------------------------------------------------
    ##----------------------------------------------------------------------------------------- 
    sp.copy(im_minima_val, imwrk1)
    sp.label(imwrk1,  im_minima_val, basicse)
    imout = sp.Image(im_minima_val)
    sp.basins(im_grad, im_minima_val, imout, basicse) 
    ##-----------------------------------------------------------------------------------------
    ##-----------------------------------------------------------------------------------------  
    return imout,  im_grad,  im_minima_val
    
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
##---------------------------------------------------------------------------------------------------------------------------------
if __name__ == "__main__":
    
#    step = 25
#    weight = 8
#    filter_ori = True
#    
#    image_file_name = "montagne.jpg"
#    imin = sp.Image(image_file_name)
#    imout, imgrad, imminima = demo_m_waterpixels(imin, step, weight, filter_ori)
#    imout.showLabel()

    ## Parser options definition:
    description =\
    """
    %prog - Waterpixels demo  with SMIL library.
    Examples of use: 
    in the terminal:
        python demo_waterpixels_smil_with_parser.py -i "montagne.jpg" -s 25 -w 10 --filter_ori
        python demo_waterpixels_smil_with_parser.py -i "montagne.jpg" -s 25 -w 10 --no-filter_ori
    with ipython:
        run demo_waterpixels_smil_with_parser.py -i "montagne.jpg" -s 25 -w 10 --filter_ori
        run demo_waterpixels_smil_with_parser.py -i "montagne.jpg" -s 25 -w 10 --no-filter_ori
    """
    parser = OptionParser(usage="usage: %prog [options]", description=description)
    parser.add_option("-i", "--original_image", dest = "original_image",  default = "resources/coins.JPG", help = "Input image filename.")
    parser.add_option("-s",  "--step",  dest = "step",  type = "int", default = "25", help = "Grid step between two cell centers.(positive integer)" )
    parser.add_option("-w",  "--weight",  dest = "weight",  type = "float", default = "10", help = "Level of regularization (positive value). Weight of the distance function when added to the gradient.")    
    parser.add_option("--filter_ori", dest="filter_ori", action="store_true",   help = " Filtering option on the original image (boolean).")
    parser.add_option("--no-filter_ori", dest="filter_ori", action="store_false",   help = " Filtering option on the original image (boolean).")
    parser.set_defaults(filter_ori = True)
    (options, args) = parser.parse_args()
    
    step = options.step
    weight = options.weight
    filter_ori = options.filter_ori
    image_file_name = options.original_image
    
    imin = sp.Image(image_file_name)
    imout, imgrad, imminima = demo_m_waterpixels(imin, step, weight, filter_ori)
    image = imout.getNumArray()
    image = image.transpose()
    imin = misc.imread(image_file_name)
    edges = filter.sobel(image)
    edges = color.rgb2gray(edges)
    out = edges
    
    limiar = 0
    total_x = len(out)
    total_y = len(out[0])
    
    for x in range(total_x):
        for y in range(total_y):
            if out[x][y] > limiar:
                imin[x][y][0] = 255
                imin[x][y][1] = 0
                imin[x][y][2] = 0
    
    plt.axis("off")
    plt.imshow(imin)
    plt.show()
