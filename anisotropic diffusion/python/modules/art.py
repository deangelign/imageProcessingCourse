"""
	Creating art with input image
"""
from __future__ import division
from scipy import misc
import numpy as np
from myclass.cell import Cell
import sys


def getLevel(level, variation):
	# 0- 255
	level = (level / 256) * variation
	abs(level)
	#print level
	return level

def toLines(image,imageColor, saveToPath,thickness,distance,variation):
	#inicialize array of cels affected
	#celsAffected saves position x,y

	maxHeight = len(image)
	maxWidth = len(image[0])

	celsAffected = np.zeros(image.shape[0])
	rowCount = 0
	mask = 0
	art = np.zeros((image.shape[0], image.shape[1])) # init art that will be generate
	for rownum in range(maxHeight):
		if mask <= thickness:
			art[rownum] = image[rownum]
			celsAffected[rowCount] = rownum
			rowCount += 1
		if mask == distance:
			mask = 0
		mask +=1

	#making curves
	artCurvesGray = np.zeros((image.shape[0], image.shape[1]))
	artCurvesNoColor = np.zeros((image.shape[0], image.shape[1]))
	artCurveColorBackground = np.zeros((image.shape[0], image.shape[1], 3))
	level = 0
	for c in range(len(celsAffected)):
		for col in range(maxWidth):
			level = getLevel(art[celsAffected[c]][col],variation)
			level = round(level)
			if celsAffected[c] + level >= maxHeight:
				level = 0
			artCurvesGray[celsAffected[c] + level][col] = art[celsAffected[c]][col]
	misc.imsave(saveToPath, artCurvesGray)
	return misc.imread(saveToPath)

def orgImage(image,imageColor, saveToPath):
	maxHeight = len(image)
	maxWidth = len(image[0])
	art = np.zeros((imageColor.shape[0], imageColor.shape[1], imageColor.shape[2]))
	for row in range(maxHeight):
		for col in range(maxWidth):
				for colc in range(maxWidth-1):
					if image[row][colc] > image[row][colc+1]:
						aux = image[row][colc]
						image[row][colc] = image[row][colc+1]
						image[row][colc+1] = aux
						aux2 = imageColor[row][colc]
						imageColor[row][colc] = imageColor[row][colc+1]
						imageColor[row][colc+1] = aux2
	misc.imsave(saveToPath, imageColor)
	return misc.imread(saveToPath)

def fractal(image,saveToPath):
	HEIGHT = len(image[0])
	WIDTH = len(image)
	#maxIt = 256
	maxIt = WIDTH
	xa = -2.0
	xb = 1.0
	ya = -1.5
	yb = 1.5
	art = np.zeros((image.shape[0], image.shape[1], image.shape[2]))
	fractal = np.zeros((image.shape[0], image.shape[1], image.shape[2]))
	for ky in range(HEIGHT):
		for kx in range(WIDTH):
			c = complex(xa + (xb - xa) * kx / WIDTH, ya + (yb - ya) * ky / HEIGHT)
			z = complex(0.0, 0.0)
			for i in range(maxIt):
				z = z * z + c
				if abs(z) >= 2.0:
					break
				art[kx][ky] = image[kx][i]
				fractal[kx][ky][0] = i%4 *64
				fractal[kx][ky][1] = i%8 *32
				fractal[kx][ky][2] = i%16 *16
	misc.imsave('outputs/fractal.png', fractal)
	misc.imsave(saveToPath, art)
	return misc.imread(saveToPath)