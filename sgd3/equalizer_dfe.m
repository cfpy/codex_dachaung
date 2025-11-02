clear;

symbolRate = 56*1e9;   % symbol rate in Bd
M = 4;            % modulation order
maxErrs = 200;    % target number of errors at each test
maxSymb = 1e7;    % maximum number of symbols at each test
nSymb = 409600;     % number of symbols per vector

% DFE parameters parameters
const = real(pammod(0:M-1,M));    % signal constellation
algType = 'RLS';         % RLS or LMS algorithm
forgetFactor = 0.999999; % parameter of RLS algorithm
nFwdWts = 16;            % number of feedforward weights
%  nFbkWts = 1;            % number of feedback weights

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
eqdfe = comm.DecisionFeedbackEqualizer('Algorithm',algType, ...
    'ForgettingFactor',forgetFactor, ...
    'NumForwardTaps',nFwdWts, ...
    'Constellation',const, ...
    'ReferenceTap',round(nFwdWts/2), ...
    'TrainingFlagInputPort',true);
refTap = eqdfe.ReferenceTap;

% Initialize channel and error collection parameters
chanState = [];
numErrs   = 0;
numBits   = 0;
firstBlk = true;  % RLS for first data block, LMS thereafter
    
while (numErrs < maxErrs && numBits < maxSymb)
    % Generate random data and apply PAM4 modulation
    msg = randi([0 M-1],nSymb,1);
    txSig = real(pammod(msg,M));
    % Pass the signal through the channel
    [filtSig,chanState] = filter(chnl,1,txSig,chanState);
    noisySig = filtSig;
    
    if (strcmp(algType,'LMS'))
        mxStep = maxstep(eqdfe,noisySig);
        if (eqdfe.StepSize > mxStep)
            fprintf('Step size is too big.');
            quit(0,"force");
        end
    end
    if (numErrs < maxErrs)
        trainSig = txSig;
        if (firstBlk)
            [PreD,err] = eqdfe(noisySig,trainSig,true);
        else
            [PreD,err] = eqdfe(noisySig,trainSig,false);
        end
        demodSig = pamdemod(PreD,M);
        
        range1 = 1 : length(msg)-refTap+1;
        range2 = refTap : length(demodSig);
        [currErrs, ratio] = biterr(msg(range1), demodSig(range2));
        if (~firstBlk)
            numErrs = numErrs + currErrs;       % cumulative
            numBits = numBits + length(range1); % cumulative
            BER = numErrs / numBits;
        end
    end
    firstBlk = false;  % done processing first data block
end
fprintf(['Bit error rate of ',ChannelFilename(1:5),' Channel at ', num2str(symbolRate/1e9),'GBd with ', num2str(nFwdWts),' Forward Taps and ' , ' Feedback Taps is ',num2str(BER),'.\n']);
% Reset the equalizer for the next test. 
release(eqdfe)
