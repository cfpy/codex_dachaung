clear;
addpath('complexbp_v2.0')

symbolRate = 25*1e9;   % symbol rate in Bd
M = 4;            % modulation order
maxErrs = 200;    % target number of errors at each test
maxSymb = 1e7;    % maximum number of symbols at each test
nSymb = 2048;     % number of symbols per vector

% DNN parameters parameters
inputSize = 15;
refTap = 8;
numHiddenUnits = 100;
numClasses = M;
maxEpochs = 1000;
miniBatchSize = 200;

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
ntrain = nSymb;
arch = [inputSize,numHiddenUnits,numHiddenUnits,numClasses];
nlayer = length(arch);
eta = 1;
lambda = 5;

output_active = @sqrmax;
hidden_active = @satabsorb; %@satabsorb
cost_fun = 'quadratic';

% Initialize channel and error collection parameters
chanState = [];

%神经网络参数初始化
weight = cell(1,nlayer);
bias = cell(1,nlayer);
nabla_weight = cell(1,nlayer);
nabla_bias = cell(1,nlayer);
a = cell(1,nlayer);
z = cell(1,nlayer);

for in = 1:nlayer-1
    weight{in} = complex_weight(arch(in+1),arch(in));
    bias{in} = (rand(arch(in),1)-0.5)*2i*pi;
end
%weight{1} = complex_weight(arch(2),arch(1),'slab');
for in = 1:nlayer
    a{in} = zeros(arch(in),miniBatchSize);
    z{in} = zeros(arch(in),miniBatchSize);
end
accuracy = zeros(1,maxEpochs);
x_train = zeros(inputSize,miniBatchSize);
y_train = zeros(numClasses,miniBatchSize);
x_valid = zeros(inputSize,nSymb-inputSize+1);
y_valid = zeros(numClasses,nSymb-inputSize+1);

for ip = 1:maxEpochs
    % Generate random data and apply PAM4 modulation
    msg = randi([0 M-1],nSymb,1);
    txSig = real(pammod(msg,M));
    % Pass the signal through the channel
    [filtSig,chanState] = filter(chnl,1,txSig,chanState);
    noisySig = filtSig';
    label = msg';
    
    for pos = 0:floor(nSymb/miniBatchSize)-1
        for tap = 1:inputSize
            x_train(tap,:) = noisySig(pos*miniBatchSize+tap:pos*miniBatchSize+tap+miniBatchSize-1);
        end
        for class = 1:numClasses
            y_train(class,:) = (label(pos*miniBatchSize+refTap:pos*miniBatchSize+refTap+miniBatchSize-1) == class-1);
        end

        a{1} = x_train;
        [a,ys]=bp_feedforward(hidden_active,output_active,weight,bias,nlayer,a);
        [weight,bias] = bp_backpropagation(hidden_active,output_active,cost_fun,weight,bias,...
            nlayer,miniBatchSize,eta,a,ys,y_train,lambda,ntrain);
    end
    % Generate random data and apply PAM4 modulation
    msg = randi([0 M-1],nSymb,1);
    txSig = real(pammod(msg,M));
    % Pass the signal through the channel
    [filtSig,chanState] = filter(chnl,1,txSig,chanState);
    noisySig = filtSig';
    label = msg';
    
    for tap = 1:inputSize
        x_valid(tap,:) = noisySig(tap:end-inputSize+tap);
    end
    y_valid = label(refTap:end-inputSize+refTap);
    
    [accuracy(ip),yp] = evaluatemnist(hidden_active,output_active,x_valid,y_valid,weight,bias,nlayer);
    plot(accuracy);
    title(['Accuracy:',num2str(accuracy(ip))]);
    getframe;
end
%yp = [y_valid;yp];
rmpath('complexbp_v2.0')