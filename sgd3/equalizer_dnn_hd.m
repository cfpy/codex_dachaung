clear;
addpath('hd')

symbolRate = 25*1e9;   % symbol rate in Bd
M = 4;            % modulation order
maxErrs = 200;    % target number of errors at each test
maxSymb = 1e7;    % maximum number of symbols at each test
nSymb = 2048;     % number of symbols per vector

% DNN parameters parameters
inputSize = 10;
refTap = 4;
parallel = 5;
numHiddenUnits = 100;
%numClasses = M;
maxEpochs = 1000;
miniBatchSize = 500; % parallel的整数倍

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
arch = [inputSize,numHiddenUnits,numHiddenUnits,numHiddenUnits,parallel];
nlayer = length(arch);
eta = 1;
lambda = 5;

% Initialize channel and error collection parameters
chanState = [];

%神经网络参数初始化
weight = cell(1,nlayer);
bias = cell(1,nlayer);
nabla_weight = cell(1,nlayer);
nabla_bias = cell(1,nlayer);
a = cell(1,nlayer);
z = cell(1,nlayer);

for in = 2:nlayer
    weight{in} = rand(arch(in),arch(in-1))-0.5;
    bias{in} = rand(arch(in),1)-0.5;
    nabla_weight{in} = rand(arch(in),arch(in-1));
    nabla_bias{in} = rand(arch(in),1);
end
for in = 1:nlayer
    a{in} = zeros(arch(in),miniBatchSize/parallel);
    z{in} = zeros(arch(in),miniBatchSize/parallel);
end
accuracy = zeros(1,maxEpochs);
x_train = zeros(inputSize,miniBatchSize/parallel);
y_train = zeros(parallel,miniBatchSize/parallel);
x_valid = zeros(inputSize,floor((nSymb-inputSize)/parallel)+1);
y_valid = zeros(parallel,floor((nSymb-inputSize)/parallel)+1);

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
            x_train(tap,:) = noisySig(pos*miniBatchSize+tap:parallel:pos*miniBatchSize+tap+miniBatchSize-1);
        end
        y_train = reshape(label(pos*miniBatchSize+refTap:pos*miniBatchSize+refTap+miniBatchSize-1),parallel,[]);

        a{1} = x_train;
        [a,z]=bp_feedforward(@acti_relu,@acti_sigmoid,weight,bias,nlayer,a,z);
        [weight,bias] = bp_backpropagation(@acti_relu_prime,@acti_sigmoid_prime,'quadratic',weight,bias,...
            nabla_weight,nabla_bias,nlayer,miniBatchSize,eta,a,z,y_train,lambda,ntrain);
    end
    
    % Generate random data and apply PAM4 modulation
    msg = randi([0 M-1],nSymb,1);
    txSig = real(pammod(msg,M));
    % Pass the signal through the channel
    [filtSig,chanState] = filter(chnl,1,txSig,chanState);
    noisySig = filtSig';
    label = msg';
    
    for tap = 1:inputSize
        x_valid(tap,:) = noisySig(tap:parallel:end-inputSize+tap);
    end
    for pos = 1:parallel
        y_valid(pos,:) = label(pos+refTap:parallel:end-inputSize+pos+refTap);
    end
    a_v{1} = x_valid;
    [a_v,z]=bp_feedforward(@acti_relu,@acti_sigmoid,weight,bias,nlayer,a_v,z);
    y_out = round(a_v{end});
    [currErrs, accuracy(ip)] = biterr(y_valid, y_out);
    plot(accuracy);
    title(['Accuracy:',num2str(accuracy(ip))]);
    getframe;
end
%yp = [y_valid;yp];
rmpath('hd')