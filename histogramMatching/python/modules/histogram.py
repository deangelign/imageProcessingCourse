from scipy import misc
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np
from modules import imagebase
from numpy.linalg import inv

def matching(source,target, pathToSave):

	#grayscale 0 - 255
	nbr_bins=255

	imhist,bins = np.histogram(source.flatten(),nbr_bins+1,normed=True)
	tinthist,bins = np.histogram(target.flatten(),nbr_bins+1,normed=True)


	imagebase.plotHistogram(target,'target','outputs/hist_target.png')
	imagebase.plotHistogram(source,'source','outputs/hist_source.png')

	cdfsrc = imhist.cumsum() #fdc
	cdfsrc = (255 * cdfsrc / cdfsrc[-1]).astype(np.uint8) #normalize
	imagebase.plotSource(cdfsrc,'G1(z)','outputs/fdc_source.png')

	cdftint = tinthist.cumsum() #fdc
	cdftint = (255 * cdftint / cdftint[-1]).astype(np.uint8) #normalize
	imagebase.plotSource(cdftint,'G2(z)','outputs/fdc_target.png')
 	
 	#Cria a inversa da fdc do target
 	anterior = 0
	inverse = np.zeros(nbr_bins+1)
 	for x in range(len(inverse)):
 		distance = cdftint[x] - anterior
 		if distance > 1 :
 			#interpola com o ultimo valor
 			for y in xrange(anterior+1,cdftint[x]):
 				inverse[y] = inverse[anterior]
 		inverse[cdftint[x]] = x
 		anterior = cdftint[x]

	imagebase.plotSource(inverse,'G2(z)-1','outputs/inverse_target.png')

	t = np.zeros(nbr_bins+1)
	for x in range(len(t)):
		t[x] = inverse[cdfsrc[x]]

	imagebase.plotSource(t,'G2(G1(z))-1','outputs/transformation_target.png')
		
	result = np.zeros((source.shape[0], source.shape[1])) # init art that will be generate
	for row in range(len(source)):
		for col in range(len(source[row])):
			result[row][col] = t[source[row][col]]
	misc.imsave(pathToSave, result)
	pass
