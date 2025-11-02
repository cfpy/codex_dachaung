clear;

symbolRate = 25*1e9;   % symbol rate in Bd
M = 4;            % modulation order
maxErrs = 200;    % target number of errors at each test
maxSymb = 1e7;    % maximum number of symbols at each test
nSymb = 4096;     % number of symbols per vector

% DNN parameters parameters
inputSize = 21;
refTap = 4;
numHiddenUnits = 200;
numClasses = M;
maxEpochs = 100;
miniBatchSize = 100;

% Channel
ChannelFilename = '042mm.s4p'; %Specify channel S-parameter
imPFilename = ['impulseResponse_',ChannelFilename(1:5),'_',num2str(symbolRate/1e9),'GBd.mat'];
if ~exist(imPFilename,'file')
    ConvertSParameterToImpulseResponse;
else
    load(imPFilename);
end
chnl = chnlImP';  % channel impulse response [0.227 0.460 0.688 0.460 0.227]'
fprintf(['Impulse response of ',ChannelFilename(1:5),' Channel at ', num2str(symbolRate/1e9),'GBd is \n [',num2str(chnlImP),'].\n']);

% Equalizer
layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest', ...
    'Shuffle','never', ...
    'Verbose',0, ...
    'Plots','training-progress');

% Initialize channel
chanState = [];
xTrain = cell(nSymb-inputSize,1);
xTest = cell(nSymb-inputSize,1);
label = zeros(nSymb-inputSize,1);

% Generate random data and apply PAM4 modulation
msg = randi([0 M-1],nSymb,1);
txSig = real(pammod(msg,M));
% Pass the signal through the channel
[filtSig,chanState] = filter(chnl,1,txSig,chanState);
noisySig = filtSig;

for pos = 1:nSymb-inputSize
    xTrain{pos} = noisySig(pos:pos+inputSize-1);
    label(pos) = msg(pos+refTap-1);
end
yTrain = categorical(label);

net = trainNetwork(xTrain,yTrain,layers,options);

% Initialize channel and error collection parameters
numErrs   = 0;
numBits   = 0;
while (numErrs < maxErrs && numBits < maxSymb)
    % Generate random data and apply PAM4 modulation
    msg = randi([0 M-1],nSymb,1);
    txSig = real(pammod(msg,M));
    % Pass the signal through the channel
    [filtSig,chanState] = filter(chnl,1,txSig,chanState);
    noisySig = filtSig;
    for pos = 1:nSymb-inputSize
        xTest{pos} = noisySig(pos:pos+inputSize-1);
        label(pos) = msg(pos+refTap-1);
    end
    yTest = categorical(label);
    
    if (numErrs < maxErrs)
        yPred = classify(net,xTest, ...
            'MiniBatchSize',miniBatchSize, ...
            'SequenceLength','longest');
        
        currErrs = sum(yPred ~= yTest);
        numErrs = numErrs + currErrs;       % cumulative
        numBits = numBits + numel(yTest); % cumulative
        BER = numErrs / numBits;
    end
end
