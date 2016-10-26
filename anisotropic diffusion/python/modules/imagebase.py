from scipy import misc
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np
import Image

'''
	read image from pathname
'''
def readImage(path):
	return misc.imread(path)

'''
	Show image in window
'''
def showImage(image):
	imgplot = plt.imshow(image, cmap = cm.Greys_r)
	plt.show()
	pass

'''
	Convert image into grayscale
'''
def toGray(image,path):
	grey = np.zeros((image.shape[0], image.shape[1])) # init 2D numpy array
	for rownum in range(len(image)):
   		for colnum in range(len(image[rownum])):
   			grey[rownum][colnum] = image[rownum][colnum][0]*0.2126 + image[rownum][colnum][1]*0.7152 + image[rownum][colnum][2]*0.0722
   	misc.imsave(path, grey)
	return misc.imread(path)
