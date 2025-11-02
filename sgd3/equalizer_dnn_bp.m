clear;
addpath('bp')
%​系统参数与信道模型初始化​​
symbolRate = 56*1e9;   % symbol rate in Bd  符号率56GBd 14 28
M = 4;            % modulation order  PAM调制阶数
maxErrs = 200;    % target number of errors at each test  最大允许误码率
maxSymb = 1e7;    % maximum number of symbols at each test  单次测试最大符号数，是积累量
nSymb = 409600;     % number of symbols per vector  每批次处理的符号数

% DNN parameters parameters

%抽头（Tap）的本质​​
%抽头是数字滤波器中带权重的延迟单元，每个抽头对应一个符号周期（1 UI）的延迟。
%其作用是捕获信号在不同时间点的幅值

% refTap = 4;
preTap = 15;  %均衡器前向抽头数
posTap = 49;  %后向抽头数
numHiddenUnits = 74;  %隐藏层神经元数
parallel = 64;  %并行输出维度
maxEpochs = 1000;  %最大训练轮次（防止过拟合）
miniBatchSize = 1500;  %小批量样本数
inputSize =preTap+posTap+parallel;  %输入层节点数128=15+49+64
%将时间窗口（preTap + posTap）与并行输出（parallel=64）结合，
%构建时空联合输入特征（128维），使DNN能同时学习信道记忆效应和符号间关联性

%  figure(1);
%  plot(x,1-y,'r*-');
% Channel  信道模型加载与预处理
ChannelFilename = '042mm.s4p'; %Specify channel S-parameter  信道S参数文件
imPFilename = ['impulseResponse_',ChannelFilename(1:5),'_',num2str(symbolRate/1e9),'GBd.mat'];
if ~exist(imPFilename,'file')  %检查冲激相应文件是否存在
    ConvertSParameterToImpulseResponse;  %若不存在，调用S参数转冲激相应函数
else
    load(imPFilename);  %加载预计算的冲激相应数据
end
chnl = chnlImP';  % channel impulse response [0.227 0.460 0.688 0.460 0.227]'  转置冲激相应向量
fprintf(['Impulse response of ',ChannelFilename(1:5),' Channel at ', num2str(symbolRate/1e9),'GBd is \n [',num2str(chnlImP),'].\n']);
% 打印信道特征
% Equalizer  神经网络初始化
ntrain = nSymb;
arch = [inputSize,numHiddenUnits,parallel];  %网络架构 128->74->64
nlayer = length(arch);  %网络层数
eta = 0.1;  %学习率（控制权重更新幅度）
lambda = 0.6;  %L2正则化系数（抑制权重过大）

% Initialize channel and error collection parameters
chanState = [];

%network?  初始化权重和偏重
weight = cell(1,nlayer);
bias = cell(1,nlayer);
nabla_weight = cell(1,nlayer);  %权重矩阵的梯度
nabla_bias = cell(1,nlayer);  %偏执向量的梯度
a = cell(1,nlayer);  %存储各层的激活值
z = cell(1,nlayer);  %存储各层的加权输入

for in = 2:nlayer  %从第二层开始初始化（输入层无权重）
    %rand(m,n) 生成维度为 m×n 的矩阵，元素值服从 ​​[0,1] 均匀分布
    weight{in} = rand(arch(in),arch(in-1))-0.5;  %[-0.5,0.5]
    bias{in} = rand(arch(in),1)-0.5;
    nabla_weight{in} = rand(arch(in),arch(in-1));
    nabla_bias{in} = rand(arch(in),1);
end
for in = 1:nlayer
    a{in} = zeros(arch(in),miniBatchSize);
    z{in} = zeros(arch(in),miniBatchSize);
end

%训练集像​​日常学习​​（学习知识）；
%验证集像​​模拟考试​​（检测学习效果，调整学习方法）；
%测试集像​​高考​​（最终能力评估，仅用一次）
accuracy = zeros(1,maxEpochs);  %记录1000轮次的准确率
x_train = zeros(inputSize,miniBatchSize);  %训练输入数据
y_train = zeros(parallel,miniBatchSize);  %训练标签数据
x_valid = zeros(inputSize,floor((nSymb-inputSize)/parallel)+1);  %验证集输入特征
y_valid = zeros(parallel,floor((nSymb-inputSize)/parallel)+1);  %验证集标签
%  figure;  训练主循环
for ip = 1:maxEpochs  %轮次循环
    % Generate random data and apply PAM4 modulation
    msg = randi([0 M-1],nSymb,1);  %生成随机消息
    txSig = real(pammod(msg,M));  %PAM4调制（实部映射[-3,-1,1,3]）默认输出复数，real()提取实部
    % Pass the signal through the channel
     [filtSig,chanState] = filter(chnl,1,txSig,chanState);  %信道滤波（模拟失真）
    %filtSig：经信道失真后的信号。
    %chanState：更新后的滤波器状态，供下一批次使用（确保连续滤波状态一致）
    noisySig = filtSig';  %转置为行向量
    
    %数据，散点图

     label = msg';  %标签转置，作为监督学习的目标标签
    %小批量训练
    for pos = 0:floor((nSymb-inputSize+parallel)/miniBatchSize)-parallel  
        for tap = 1:inputSize  %构造输入矩阵，tap时间抽头索引
            x_train(tap,:) = noisySig(pos*miniBatchSize+tap:parallel:pos*miniBatchSize+tap+(miniBatchSize-1)*parallel);
        end  %起始点：步长：终点
        for class = 1:parallel  %构造标签矩阵  标签化归为[0,1] PAM4电平0->0，3->1
            y_train(class,:) = (label(pos*miniBatchSize+class+preTap:parallel:pos*miniBatchSize+class+preTap+(miniBatchSize-1)*parallel)/3 );
        end

    %hidden: sigmoid, output: sigmoid, cost: 'quadratic'@acti_relu  前向传播
    a{1} = x_train;  %输入层激活值=输入数据
    
    [a,z]=bp_feedforward(@acti_relu,@acti_sigmoid,weight,bias,nlayer,a,z);  
    %隐藏层：ReLU激活  输出层：Sigmoid激活
    %反向传播
    [weight,bias] = bp_backpropagation(@acti_relu_prime,@acti_sigmoid_prime,'quadratic',weight,bias,...
        nabla_weight,nabla_bias,nlayer,miniBatchSize,eta,a,z,y_train,lambda,ntrain);  %损失函数，梯度更新
    end  
    
    % Generate random data and apply PAM4 modulation  生成验证集
    msg = randi([0 M-1],nSymb,1);  %独立于训练集的消息
    txSig = real(pammod(msg,M));
    % Pass the signal through the channel
     [filtSig,chanState] = filter(chnl,1,txSig,chanState);
    noisySig = filtSig';
     label = msg';
    %组织验证数据
    for tap = 1:inputSize
        x_valid(tap,:) = noisySig(tap:parallel:end-inputSize+tap);  %滑窗采样
    end
    for pos = 1:parallel
     y_valid(pos,:) = label(pos+preTap:parallel:pos+end-inputSize+preTap);  %对齐标签
    end
    %评估准确率
    [accuracy(ip),yp] = evaluatemnist(@acti_relu,@acti_sigmoid,x_valid,y_valid,weight,bias,nlayer);
    plot(accuracy);  %绘制准确率曲线
    title(['Accuracy:',num2str(accuracy(ip),'%.15f')]);  %动态更新标题
    getframe;  %刷新图形窗口
end
% end
%yp = [y_valid;yp];
rmpath('bp')

%二进制数据转化
%前向传播Verilog，让Verilog跑起来，包括testbench
%GitHub上反向传播代码，二进制转化也有人写
%先不搞训练（反向传播）
%可能需要对前向的代码进行改动，如sigmoid函数重新实现
%testbench从单个文件开始写
%相关数据从小到大进行实现，先从一个小的数据集开始

%目的：降低误码率