from essentia.standard import *
import numpy as np 
import csv


def featureExtraction(audio):

	w = Windowing(type = 'hann')
	spectrum = Spectrum() 
	hpcp = HPCP()
	specPeaks = SpectralPeaks()

	mag_peaks = []
	freq_peaks = []
	hpcp_val = []

	for frame in FrameGenerator(audio, frameSize=22050, hopSize=5512, startFromZero=True):
		freq_peaks, mag_peaks = specPeaks(spectrum(w(frame)))
		hpcp_val.append(hpcp(freq_peaks,mag_peaks))



# Concatenate all features
	features = hpcp_val

	return features

filename = 'vocaliseMono.wav'
loader = EqloudLoader(filename=filename)
audio = loader()

features = featureExtraction(audio)
with open('HPCP_vocalise.csv','wb') as f:
	writer = csv.writer(f)
	for line in features: writer.writerow(line)
