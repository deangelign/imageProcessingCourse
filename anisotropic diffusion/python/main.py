from modules import imagebase
from modules import anisotropic
from modules import edge_detect
import time
import os.path
from scipy import ndimage
from scipy import misc

'''
Init time
'''
start = time.time()

originalImagePath = 'assets/source.png'
imageGrayPath = 'assets/source_greyscale.png'

print ("reading image...")
imageToProcess = imagebase.readImage(originalImagePath)
if len(imageToProcess.shape)>2 :
	print ("converting image to grayscale...")
	imageToProcess = imagebase.toGray(imageToProcess,imageGrayPath)


print("Values: ")
l = 0.25
k = 50
maxIteration = 25
erro = 1
print 'Lambida\t= '+str(l)
print 'k\t= '+str(k)
print 'i\t= '+str(maxIteration)
print("processing image ...")

#gaussian = ndimage.filters.gaussian_filter(imageToProcess, 5.0)
#misc.imsave('outputs/gaussian.png', gaussian)

edge_detect.roberts_cross( originalImagePath, 'outputs/prewit1.png')

imageToProcess = imagebase.readImage(originalImagePath)

imageAfter = anisotropic.anisotropic(imageToProcess,k,l,erro,maxIteration,1,'outputs/imgout.png')

edge_detect.roberts_cross( 'outputs/imgout.png', 'outputs/prewit2.png')

'''
End Time
'''
end = time.time()
elapsed = end - start
print 'Time\t= ' + str(round(elapsed,2))+'s'
