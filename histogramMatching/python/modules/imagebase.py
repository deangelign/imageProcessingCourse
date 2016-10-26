from scipy import misc
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np
import Image

def readImage(path):
	return misc.imread(path)

def showImage(image):
	imgplot = plt.imshow(image, cmap = cm.Greys_r)
	plt.show()
	pass

def toGray(image,path):
	grey = np.zeros((image.shape[0], image.shape[1])) # init 2D numpy array
	for rownum in range(len(image)):
   		for colnum in range(len(image[rownum])):
   			grey[rownum][colnum] = image[rownum][colnum][0]*0.2126 + image[rownum][colnum][1]*0.7152 + image[rownum][colnum][2]*0.0722
   	misc.imsave(path, grey)
	return misc.imread(path)

def expand_image(input_image, size):
    '''
    Expand image, copying data from borders.
    '''

    output_image = np.copy(input_image)

    for axis in range(len(input_image.shape)):
        subimage_position = list(output_image.shape)
        subimage_position[axis] = 1
        subimage = np.repeat(output_image[0:subimage_position[0], \
                                          0:subimage_position[1]], \
                            size, axis = axis)
        output_image = np.concatenate((subimage, output_image), axis = axis)

        subimage_position = len(output_image.shape) * [0]
        subimage_position[axis] = output_image.shape[axis] - 1
        subimage = np.repeat(output_image[subimage_position[0]:output_image.shape[0], \
                                          subimage_position[1]:output_image.shape[1]], \
                            size, axis = axis)
        output_image = np.concatenate((output_image, subimage), axis = axis)

    return output_image


def reduce_image(input_image, size):
    '''
    Reduce image, removing data from borders.
    '''

    output_image = np.copy(input_image[size:(input_image.shape[0] - size), \
                                       size:(input_image.shape[1] - size)])

    return output_image

def plotHistogram(source,title,savePath):
  nbr_bins=255
  imhist,bins = np.histogram(source.flatten(),nbr_bins,normed=True)
  plt.bar(bins[:-1], imhist, width = 1)
  plt.title(title) 
  plt.xlim(min(bins), max(bins))
  plt.savefig(savePath)
  plt.close("all")

def plotSource(source,title,path):
  plt.plot(source)
  plt.title(title) 
  plt.savefig(path)
  plt.close("all")
