from __future__ import division
from scipy import misc
import numpy as np
from modules import imagebase

def anisotropic(img,k,l,erro,maxIteration,option,path):
	# initialize output array
	img = img.astype('float32')
	imgout = img.copy()

    # initialize some internal variables
	deltaS = np.zeros_like(imgout)
	deltaE = deltaS.copy()
	NS = deltaS.copy()
	EW = deltaS.copy()
	gS = np.ones_like(imgout)
	gE = gS.copy()
	diff = 999
	i = 0
	limit = 1000
	#while diff > erro:
	for i in range(maxIteration):
		#delta
		#old = imgout.copy()
		deltaS[:-1,: ] = np.diff(imgout,axis=0)
		deltaE[: ,:-1] = np.diff(imgout,axis=1)

		#gradient
		if option == 1:
			gS = np.exp(-(deltaS/k)**2.)
			gE = np.exp(-(deltaE/k)**2.)
		elif option == 2:
			gS = 1./(1.+(deltaS/k)**2.)
			gE = 1./(1.+(deltaE/k)**2.)

        # update matrices
		S = gS*deltaS
		E = gE*deltaE
        # subtract a copy that has been shifted 'North/West' by one pixel
		NS[:] = S
		EW[:] = E
		NS[1:,:] -= S[:-1,:]
		EW[:,1:] -= E[:,:-1]

        # update the image
		imgout += l*(NS+EW)
		#diff =  np.sum((imgout-old)**2.)
		#i += 1
		#if i == 3*limit:
		#	erro += 0.01
		#	limit += 1000
		#print np.sum((imgout-old)**2.)
	#misc.imsave('outputs/deltaNS.png', deltaS)
	#misc.imsave('outputs/deltaEW.png', deltaE)
	misc.imsave('outputs/imgout.png', imgout)
	return imgout

