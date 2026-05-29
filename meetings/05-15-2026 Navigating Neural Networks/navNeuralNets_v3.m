%% Navigating Neural Networks
% Jon Moler, Neuroscience Coding Club - 5/15/26
% The purpose of this code is to help bridge the gap between the
% fundamental concepts behind neural networks and how they are built within
% example codes. This is a general concept map of each step of the neural
% network, and what happens to the 'signal' as it travels through the
% neuron-neuron chain of the network.



%% Part 1: The Components of a 'Neuron'

% These represent signals coming into the neuron (Synaptic Input)
% We will assume our neuron is receiving 3 distinct inputs
firstInput = rand(1);
secondInput = rand(1);
thirdInput = rand(1);
initialInputs = [firstInput,secondInput,thirdInput];

% These represents how strong each input is, respectively (Synaptic Strength)
firstWeight = rand(1)*2-1;
secondWeight = rand(1)*2-1;
thirdWeight = rand(1)*2-1;
connectivityWeights = [firstWeight,secondWeight,thirdWeight];

% This represents the end value after combining all the inputs (Dendritic Integration/Summation)
% Remember that each 'input' to the neuron starts as an 'output' from
% another neuron. So we need to adjust that incoming signal based on how
% strong the connection is, then add them together.
adjustedInputs = initialInputs.*connectivityWeights;
summedInputs = sum(adjustedInputs);

% The 'dot' between the inputs and weights in the equation above just means 
% that you do the math at each position between the two vectors being multiplied.
% The first element of initialInputs (0.5) will be multiplied by the first
% element of connectivityWeights (0.8), then repeat for the second element 
% of each, so on and so forth. This means that each vector must be the same 
% size in both dimensions (rows and columns), so keep that in mind.


% Bias: This represents the 'baseline' level for the neuron (Intrinsic Excitability)
% This is added to the input on the neuron, and can be thought of as the
% neuron's natural state. In the absence of all other singals, this value
% will still be present as an input for the Activation Function later.
theBias = rand(1);
biasedInput = summedInputs + theBias;


% Apply your Activation Function (How the neuron 'transforms' the input)

% There are a lot of different Activation Functions, in the same way there
% are a lot of different kinds of neurons with unique responses to signals.
% The choice of what math/equation you use for your Activation Function
% comes down to what role you want your neuron to play in the circuit. 
% For this example, I'm choosing a function that takes the summed/biased 
% input and applies math with a 'Sigmoid' shaped result. Why did I choose
% it? Because it was the second equation that came up when I Googled
% "Activation Function equations". You should probably put more thought
% into this than I did.

% Example figure for what Activation Function does to the input
figure(1)
set(gcf,'Position',[100 200 1400 760])
clf
subplot(1,2,1)
hold on
% Sigmoid
sigFunction = [];
fakeInputs =  -5:0.1:5;
for inputNum = 1:length(fakeInputs)
    thisInput = fakeInputs(inputNum);
    sigFunction(inputNum) = 1/(1+exp(-thisInput));
end
sigPlot = plot(fakeInputs,sigFunction,'-k','LineWidth',2,'Marker','*');
sigPlot.MarkerSize = 5;
sigPlot.MarkerEdgeColor = 'red';
sigAx = gca;
sigAx.XAxis.FontSize = 20;
sigAx.YAxis.FontSize = 20;
title('Sigmoid','FontSize',40)
xlabel('Summed/Biased Input Values','FontSize',30)
ylabel('Output Values','FontSize',30)

subplot(1,2,2)
hold on
reLuFunction = [];
for inputNum = 1:length(fakeInputs)
    thisInput = fakeInputs(inputNum);
    reLuFunction(inputNum) = max(0,thisInput);
end
reLuPlot = plot(fakeInputs,reLuFunction,'-k','LineWidth',2,'Marker','*');
reLuPlot.MarkerSize = 5;
reLuPlot.MarkerEdgeColor = 'red';
reLuAx = gca;
reLuAx.XAxis.FontSize = 20;
reLuAx.YAxis.FontSize = 20;
title('ReLU','FontSize',30)
xlabel('Summed/Biased Input Values','FontSize',30)
ylabel('Output Values','FontSize',30)
sgtitle('Activation Function Examples','FontSize',40)


% After applying the Activation Function, you have your Output
theOutputSig = 1/(1+exp(-biasedInput));
theOutputReLU = max(0,biasedInput);

subplot(1,2,1)
plot(biasedInput,theOutputSig,'ob','MarkerSize',10,'LineWidth',1)
subplot(1,2,2)
plot(biasedInput,theOutputReLU,'ob','MarkerSize',10,'LineWidth',1)


% Review the steps using example figure
figure(2)
set(gcf,'Position',[100 200 1800 760])
clf
hold on
inputColors = ["-b","-r","-g"];
for inputNum = 1:length(initialInputs)
    firstStep = [initialInputs(inputNum) initialInputs(inputNum)];
    secondStep = [initialInputs(inputNum) adjustedInputs(inputNum)];
    thirdStep = [adjustedInputs(inputNum) summedInputs];
    comboStep = [firstStep, secondStep, thirdStep];
    plot(comboStep,inputColors(inputNum),'LineWidth',3)
end

fourthStep = [summedInputs biasedInput];
fifthStep = [biasedInput theOutputSig];
comboStep = [fourthStep, fifthStep];
plot(6:9,comboStep,'-k','LineWidth',3)
xlim([0 10])
ylim([-2 2])
xticks([2,4,6,8])
xticklabels(["Original Inputs", "Weight Adjustment", "Sum the Inputs", "Apply Activation Function"])
text(1.7,-1.5,'$Input$','FontSize',20, 'Interpreter', 'latex')
text(3.3,-1.5,'$Input*Weight$','FontSize',20, 'Interpreter', 'latex')
text(5.2,-1.5,'$\sum{(Input*Weight)}$','FontSize',20, 'Interpreter', 'latex')
text(7.05,-1.5,'$\frac{1}{1+exp(\sum(Input*Weight))}$','FontSize',23, 'Interpreter', 'latex')
figAx = gca;
figAx.XAxis.FontSize = 20;
figAx.YAxis.FontSize = 20;
title('Signal Path: Input -> Sigmoid Output','FontSize',40)
ylabel('Value of Signal','FontSize',30)
xline([1,3,5,7,9])
yline(0,'--k')


% Same, but for ReLU Activation Function
figure(3)
set(gcf,'Position',[100 200 1800 760])
clf
hold on

inputColors = ["-b","-r","-g"];
for inputNum = 1:length(initialInputs)
    firstStep = [initialInputs(inputNum) initialInputs(inputNum)];
    secondStep = [initialInputs(inputNum) adjustedInputs(inputNum)];
    thirdStep = [adjustedInputs(inputNum) summedInputs];
    comboStep = [firstStep, secondStep, thirdStep];
    plot(comboStep,inputColors(inputNum),'LineWidth',3)
end

fourthStep = [summedInputs biasedInput];
fifthStep = [biasedInput theOutputReLU];
comboStep = [fourthStep, fifthStep];
plot(6:9,comboStep,'-k','LineWidth',3)
xlim([0 10])
ylim([-2 2])
xticks([2,4,6,8])
xticklabels(["Original Inputs", "Weight Adjustment", "Sum the Inputs", "Apply Activation Function"])
text(1.7,-1.5,'$Input$','FontSize',20, 'Interpreter', 'latex')
text(3.3,-1.5,'$Input*Weight$','FontSize',20, 'Interpreter', 'latex')
text(5.2,-1.5,'$\sum{(Input*Weight)}$','FontSize',20, 'Interpreter', 'latex')
text(7.25,-1.2,'$  x>0  f(x) = x$','FontSize',23, 'Interpreter', 'latex')
text(7.4,-1.5,'$ otherwise $','FontSize',23, 'Interpreter', 'latex')
text(7.45,-1.8,'$f(x) = 0$','FontSize',23, 'Interpreter', 'latex')
figAx = gca;
figAx.XAxis.FontSize = 20;
figAx.YAxis.FontSize = 20;
title('Signal Path: Input -> ReLU Output','FontSize',40)
ylabel('Value of Signal','FontSize',30)
xline([1,3,5,7,9])
yline(0,'--k')





%%  Part 2: Follow the logic, create a multi-layered network that takes an input
% We will use the logic above to create 'neurons', which we will assign to
% one of three layers. Each layer will be assigned a number of neurons, and every 
% neuron within a layer will share the same activation function. Weights
% for each neuron will be randomized at the start.
% ** NOTE: This does not work correctly, the backpropagation is probably inefficient,
%          and overall it fails at its job. I am keeping it in because this was meant
%          to show my train of thought as I was trying to learn about how the networks
%          are built. Maybe this could serve as a good tutorial for how to fix poorly
%          implemented neural networks.

%% Prep MNIST input arrays
% Load MNIST dataset from the mnistData folder
convertMNIST
mnist = load('mnist.mat');

% Pick a subset of x# of images for training
numImages = 1000;
randPick = randperm(numImages);
trainImg = mnist.training.images(:,:,randPick);
trainLbl = mnist.training.labels(randPick);

% Convert the 0-9 labels to something called one-hot encoding format
oneHotLabels = zeros(length(trainLbl),10);
for thisLabel = 1:length(trainLbl)
    oneHotLabels(thisLabel,trainLbl(thisLabel)+1) = 1;
end


% Initialize each layer, build el networko
% Decide the number of neurons in each layer
numInputs = prod(size(trainImg,[1,2]));
layerOneNum = 128;
layerTwoNum = 64;
layerThreeNum = 10; % Number of possible values from MNIST

% Reminder: The 'Learning' comes from updating these weights and biases
theWeights{1} = randn(layerOneNum,numInputs)*0.1;
theWeights{2} = randn(layerTwoNum,layerOneNum)*0.1;
theWeights{3} = randn(layerThreeNum,layerTwoNum)*0.1;
theBiases{1} = zeros(layerOneNum,1);
theBiases{2} = zeros(layerTwoNum,1);
theBiases{3} = zeros(layerThreeNum,1);

% Prep the 'Results' structure, iterate the network through the math
learningRate = 0.01;
numIterations = 100;
theResults.loss = zeros(numImages,numIterations);
theResults.correctYesNo = zeros(numImages,numIterations);


theWaiting = waitbar(1/numIterations,'Waiting For Iterations to Complete');
for iterNum = 1:numIterations

    waitbar(iterNum/numIterations)

    for thisImage = 1:length(trainImg)
        flatImage = trainImg(:,:,thisImage);
        flatImage = flatImage(:);
        theOneHot = oneHotLabels(thisImage,:)';

        % Apperantly, the ORDER in which you put these is important. I
        % don't know why, its stupid, I thought math was math, but turns
        % out math is magic. So, the weights need to be first, then
        % multiply them by the flattened image.
        inputToLayer1 = theWeights{1}*flatImage+theBiases{1};
        outputFromLayer1 = max(0,inputToLayer1); % Activation Function: ReLU

        inputToLayer2 = theWeights{2}*outputFromLayer1+theBiases{2};
        outputFromLayer2 = max(0,inputToLayer2);

        % This is the 'Output Layer', which we will pull from to gauge the
        % effectiveness of our network
        inputToLayer3 = theWeights{3}*outputFromLayer2+theBiases{3};

        % Softmax, a technique used on the results from the output layer
        % to judge the probability of the results being correct.
        softMaxStep1 = exp(inputToLayer3-max(inputToLayer3));
        % Softmax builds a 'probability distribution', so that the results
        % from the second step represent the percent probability that the
        % image is the class (the number) that the neuron's position represents
        softMaxStep2 = softMaxStep1/sum(softMaxStep1);

        % A 'Loss Function'. Basically, how 'wrong' was our network? This
        % is used to determined how the weights and biases are adjusts for
        % the next iteration. 
        theLoss = -sum(theOneHot.*log(softMaxStep2+1e-8));

        % The backpropagation step. This is where the adjustsments are made to
        % try and improve the performance of the network. This is a
        % reverse-order process that calculates STUFF starting from the
        % last layer and ending in the first layer, then applies the
        % changes before the start of the next full iteration.

        % Output layer backprop
        backPropLayer3 = softMaxStep2-theOneHot;
        backWeight{3} = backPropLayer3*outputFromLayer2';

        % Layer 2 backprop
        backLayer2 = theWeights{3}'*backPropLayer3;
        backPropLayer2 = backLayer2.*(inputToLayer2>0);
        backWeight{2} = backPropLayer2*outputFromLayer1';

        % Layer 1 backprop
        backLayer1 = theWeights{2}'*backPropLayer2;
        backPropLayer1 = backLayer1.*(inputToLayer1>0);
        backWeight{1} = backPropLayer1*flatImage';

        % Update the original structures with the new values
        theWeights{1} = theWeights{1}-learningRate*backWeight{1};
        theBiases{1} = theBiases{1}-learningRate*backPropLayer1;
        theWeights{2} = theWeights{2}-learningRate*backWeight{2};
        theBiases{2} = theBiases{2}-learningRate*backPropLayer2;
        theWeights{3} = theWeights{3}-learningRate*backWeight{3};
        theBiases{3} = theBiases{3}-learningRate*backPropLayer3;

        % Record the loss and see how often the network was correct over iterations 
        theResults.loss(thisImage,iterNum) = theLoss;
        theResults.correctYesNo(thisImage,iterNum) = find(theOneHot==1)==find(softMaxStep2==max(softMaxStep2));
    end
    
end

close(theWaiting)



