
'''
	TP1 - Grupo 4
	Histogram Matching
'''

from modules import imagebase
from modules import histogram
import os.path

targetPath = 'assets/target.png'
sourcePath = 'assets/source.png'
outputImagePath = 'outputs/output.png'

print ("reading image...")
source = imagebase.readImage(sourcePath)
target = imagebase.readImage(targetPath)

if len(source.shape) >= 3:
	source = imagebase.toGray(source, sourcePath)

if len(target.shape) >= 3:
	target = imagebase.toGray(target, targetPath)

print("processing image...")
histogram.matching(source, target, outputImagePath)

result = imagebase.readImage(outputImagePath)
imagebase.plotHistogram(result,'Result','outputs/hist_result.png')
