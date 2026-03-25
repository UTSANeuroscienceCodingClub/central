


% The purpose of this script is to load a sample dataset and run some basic FFT-based filtering.
% Ideally, this should mirror the process seen in the Matlab version of this script.

%% Step 1: Prompt to select a data file to analyze, look at its structure
[theName,theFolder] = uigetfile('*.h5');
disp(['Selected: ' theName])
dataInfo = h5info(theName);
dataPath = [dataInfo.Groups.Name '/'];
numChans = length(dataInfo.Groups.Datasets);
sampRate = 25000;
sampPerMs = sampRate/10^3;

%% Step 2: Load each channel of the dataset
theTraces = [];
for chanNum = 1:numChans
    chanName = dataInfo.Groups.Datasets(chanNum).Name;
    % Chop off the last sample cause I saved this .h5 file with one extra sample by accident
    theData = h5read(theName, [dataPath chanName]);
    theTraces(:,chanNum) = theData(1:end-1);
end

numSamps = length(theTraces(:,1));
recDur = numSamps/sampRate;

%% Step 3: Quick plotting check to see if our data is the same

% Pick any channel of interest, between 1 to 20 (For the 20 channels in the sample data)
whatChannel = 1;

traceCheck = theTraces(:,whatChannel);
traceMin = min(traceCheck);
traceMax = max(traceCheck);

figure(1)
set(gcf,'Units','inch','Position',[4 4 18 8])
plot((1:numSamps)/sampRate,traceCheck)
xlim([1 numSamps/sampRate])
ylim([traceMin*1.1 traceMax*1.1])
yticks(round(traceMin:10:traceMax))
ylabel('Voltage (uV)')
xlabel('Time (sec)')
title('Matlab: Raw Trace')
grid on
figTarget = getframe(gcf);
figToImage = frame2im(figTarget);
imwrite(figToImage,'RawTraceCheckMatlab.jpg');
close()


%% Step 4 - Perform FFT on the raw data, get features, store spike times
% Setting parameters for the FFT-based filtering
dTime = 1./sampRate;
dFreq = 1/recDur;
nyqFreq = 1/(2*dTime);
freqRange1 = (0:dFreq:nyqFreq-dFreq)';
freqRange2 = (-nyqFreq+dFreq:dFreq:0)';
freqD = [freqRange1; freqRange2];

% Bounds for the filter in Hertz
highPass = 300; 
lowPass = 4000;
wideBand = [0.1 150];
filtLogicSpike = (abs(freqD)<highPass | abs(freqD)>lowPass);
filtLogicLFP = (abs(freqD)<wideBand(1) | abs(freqD)>wideBand(2));

% The actual FFT-based filtering, by channel
tic()
disp('Starting FFT-based filtering of data')
filtTraces = [];
filtTracesLFP = [];
for chanNum = 1:numChans
    % Spike Bandpass on the data
    dataFilt = fft(theTraces(:,chanNum));
    % Set all frequencies outside of bandpass parameters to 0
    dataFilt(filtLogicSpike) = 0;
    % Use inverse FFT to return filtered data to time domain
    dataFilt = ifft(dataFilt,"symmetric");
    filtTraces(:,chanNum) = dataFilt;

    % LFP Bandpass on the data
    dataLFP = fft(theTraces(:,chanNum));
    % Set all frequencies outside of bandpass parameters to 0
    dataLFP(filtLogicLFP) = 0;
    % Use inverse FFT to return filtered data to time domain
    dataLFP = ifft(dataLFP,"symmetric");
    filtTracesLFP(:,chanNum) = dataLFP;
end

disp('FFT Filtering complete')
filtTime = toc();
disp(['Processing took ' num2str(round(filtTime,3)),' seconds'])

%% Step 5: Quick plotting check to see if our filtered data is the same

% Pick any channel of interest, between 1 to 20 (For the 20 channels in the sample data)
whatChannel = 1;

% Spike filter
filtCheck = filtTraces(:,whatChannel);
filtMin = min(filtCheck);
filtMax = max(filtCheck);

figure(1)
set(gcf,'Units','inch','Position',[4 4 18 8])
plot((1:numSamps)/sampRate,filtCheck)
xlim([1 numSamps/sampRate])
ylim([filtMin*1.1 filtMax*1.1])
yticks(round(filtMin:10:filtMax))
ylabel('Voltage (uV)')
xlabel('Time (sec)')
title('Matlab: Filtered Trace')
grid on
figTarget = getframe(gcf);
figToImage = frame2im(figTarget);
imwrite(figToImage,'FiltTraceCheckMatlab.jpg');
close()

% LFP filter
filtCheck = filtTracesLFP(:,whatChannel);
filtMin = min(filtCheck);
filtMax = max(filtCheck);

figure(1)
set(gcf,'Units','inch','Position',[4 4 18 8])
plot((1:numSamps)/sampRate,filtCheck)
xlim([1 numSamps/sampRate])
ylim([filtMin*1.1 filtMax*1.1])
yticks(round(filtMin:10:filtMax))
ylabel('Voltage (uV)')
xlabel('Time (sec)')
title('Matlab: LFP Trace')
grid on
figTarget = getframe(gcf);
figToImage = frame2im(figTarget);
imwrite(figToImage,'FiltTraceLFPCheckMatlab.jpg');
close()

