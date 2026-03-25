import numpy as np
from scipy.fft import rfft, irfft, rfftfreq
import matplotlib.pyplot as plop
import h5py
import tkinter as tk
from tkinter import filedialog
import os
import time


# The purpose of this script is to load a sample dataset and run some basic FFT-based filtering.
# Ideally, this should mirror the process seen in the Matlab version of this script.

## Step 1: Prompt to select a data file to analyze, look at its structure
# Define function for selecting the file
def selectFile():
    # Create a hidden window thing. 
    root = tk.Tk()
    root.withdraw()
    # Open GUI prompt to select file of interest
    filePath = filedialog.askopenfilename(title="Select a file",
        filetypes=[("All Files", "*.*"), ("Text Files", "*.txt")])
    # Root window has done its job, 'destroy' deletes it from the workspace
    root.destroy()
    # Pull the name of the file, and I HAVE to use 'os' to do that for some reason
    fileName = os.path.basename(filePath)
    folderName = os.path.dirname(filePath)

    return filePath,fileName,folderName
# Call the above function
thePath,theName,theFolder = selectFile()
print("Selected:", theName)

# Target the file, extract traces, extract necessary metadata
theFile = h5py.File(thePath,'r')
dataPath = list(theFile.keys())[0] + '/'
numChans = len(theFile[dataPath])
sampRate = np.float32(25000)
sampPerMs = sampRate/10**3

## Step 2: Load each channel of the dataset
chanNameList = list(theFile[dataPath].keys())
theTraces = []
for chanNum in np.arange(0,numChans,1):
    chanName = chanNameList[chanNum]
    theData = theFile[dataPath + chanName]
    # Chop off the last sample cause I saved this .h5 file with one extra sample by accident
    theTraces.append(theData[0][:-1])

numSamps = len(theTraces[0])
recDur = numSamps/sampRate

## Step 3: Quick plotting check to see if our data is the same

# Pick any channel of interest, between 0 to 19. (For the 20 channels in the sample data)
whatChannel = 0

traceCheck = theTraces[whatChannel]
traceMin = np.min(traceCheck)
traceMax = np.max(traceCheck)

plop.figure(figsize=(18,8))
plop.plot(np.arange(0,numSamps,1)/sampRate,traceCheck)
plop.xlim(0,numSamps/sampRate)
plop.ylim(traceMin*1.1,traceMax*1.1)
plop.yticks(np.arange(np.round(traceMin),np.round(traceMax)+1,10))
plop.ylabel('Voltage (uV)')
plop.xlabel('Time (sec)')
plop.title('Python: Raw Trace')
plop.grid(True)
plop.savefig(os.path.join(theFolder,'RawTraceCheckPython.jpg'),bbox_inches='tight')
plop.close()


## Step 4 - Perform FFT on the raw data, get features, store spike times
# Setting parameters for the FFT-based filtering. Because I'm looking at a "real" signal, I only need one side of the frequency spectrum
dTime = 1/sampRate 
dFreq = 1/recDur
nyqFreq = 1/(dTime*2)
posFreqD = np.arange(0,nyqFreq,dFreq)
freqD = np.append(posFreqD,posFreqD[-1]+dFreq)

# Bounds for the filter in Hertz
highPass = 300
lowPass = 4000
wideBand = [0.1,150]
filtLogicSpike = (np.abs(freqD)<highPass) | (np.abs(freqD)>lowPass)
filtLogicLFP = (np.abs(freqD)<wideBand[0]) | (np.abs(freqD)>wideBand[1])

# The actual FFT-based filtering, by channel
startTime = time.perf_counter()
print('Starting FFT-based filtering of data')

filtTraces = []
filtTracesLFP = []
for chanNum in np.arange(0,numChans,1):
    # Spike bandpass on the data
    dataFilt = rfft(theTraces[chanNum],axis=0)
    # Set all frequencies outside of bandpass parameters to 0
    dataFilt[filtLogicSpike] = 0
    # Use inverse FFT to return filtered data to time domain
    filtTraces.append(irfft(dataFilt,axis=0))

    # LFPSpike bandpass on the data
    dataLFP = rfft(theTraces[chanNum])
    # Set all frequencies outside of bandpass parameters to 0
    dataLFP[filtLogicLFP] = 0
    # Use inverse FFT to return filtered data to time domain
    filtTracesLFP.append(irfft(dataLFP))

print('FFT Filtering complete')
endTime = time.perf_counter()
filtTime = endTime-startTime
print('')
print('Processing took',round(filtTime,3),'seconds')


## Step 5: Quick plotting check to see if our filtered data is the same

# Pick any channel of interest, between 0 to 19. (For the 20 channels in the sample data)
whatChannel = 0

filtCheck = filtTraces[whatChannel]
filtMin = np.min(filtCheck)
filtMax = np.max(filtCheck)

# Spike filter
plop.figure(figsize=(18,8))
plop.plot(np.arange(0,numSamps,1)/sampRate,filtCheck)
plop.xlim(0,numSamps/sampRate)
plop.ylim(filtMin*1.1,filtMax*1.1)
plop.yticks(np.arange(np.round(filtMin),np.round(filtMax)+1,10))
plop.ylabel('Voltage (uV)')
plop.xlabel('Time (sec)')
plop.title('Python: Filtered Trace')
plop.grid(True)
plop.savefig(os.path.join(theFolder,'FiltTraceCheckPython.jpg'),bbox_inches='tight')
plop.close()

# LFP filter
filtCheck = filtTracesLFP[whatChannel]
filtMin = np.min(filtCheck)
filtMax = np.max(filtCheck)

plop.figure(figsize=(18,8))
plop.plot(np.arange(0,numSamps,1)/sampRate,filtCheck)
plop.xlim(0,numSamps/sampRate)
plop.ylim(filtMin*1.1,filtMax*1.1)
plop.yticks(np.arange(np.round(filtMin),np.round(filtMax)+1,10))
plop.ylabel('Voltage (uV)')
plop.xlabel('Time (sec)')
plop.title('Python: LFP Trace')
plop.grid(True)
plop.savefig(os.path.join(theFolder,'FiltTraceLFPCheckPython.jpg'),bbox_inches='tight')
plop.close()