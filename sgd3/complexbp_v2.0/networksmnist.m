% A BP phase shift network for MNIST data
% 均方误差代价函数+L2规则化+非线性

% Author: jift
% Version 1.5
% date: 2019-10-6

%数据准备
%clear;
loadMnistDataScript;
%loadMnistFashionDataScript;
%loadCifarDataScript;

%神经网络的层次
arch = [length(x_train(:,1)),100,100,10];
%output: softmax, cost: 'quadratic'
output_active = @sqrmax;
hidden_active = @satabsorb; %@satabsorb
cost_fun = 'quadratic';

%神经网络超参设置
mini_batch_size = 100;
max_iteration = 10000;
eta = 3;
lambda = 1;
% mini = 20, eta = 6 eps= 5000. 可以达到0.946

%神经网络参数初始化
ntrain = length(y_train);
nlayer = length(arch);
weight = cell(1,nlayer-1);
bias = cell(1,nlayer-1);
a = cell(1,nlayer);
rstep = 100;

for in = 1:nlayer-1
    weight{in} = complex_weight(arch(in+1),arch(in));
    bias{in} = (rand(arch(in),1)-0.5)*2i*pi;
end
%weight{1} = complex_weight(arch(2),arch(1),'slab');

for in = 1:nlayer
    a{in} = zeros(arch(in),mini_batch_size);
end
accuracy = zeros(1,ceil(max_iteration/rstep));

iaa = 0;
figure;
for ip = 1:max_iteration
    pos = randperm(ntrain,mini_batch_size);
    x = x_train(:,pos);
    y = y_train(:,pos);

    a{1} = x;
    [a,ys]=bp_feedforward(hidden_active,output_active,weight,bias,nlayer,a);
    [weight,bias] = bp_backpropagation(hidden_active,output_active,cost_fun,weight,bias,...
        nlayer,mini_batch_size,eta,a,ys,y,lambda,ntrain);
    if mod(ip,rstep) == 0
        iaa = iaa+1;
        accuracy(iaa) = evaluatemnist(hidden_active,output_active,x_valid,y_valid,weight,bias,nlayer);
        plot(accuracy);
        title(['Accuracy:',num2str(accuracy(iaa))]);
        getframe;
    end
end
figure
plot(accuracy,'r','linewidth',2);
ylim([0.95,0.99])
legend(num2str(arch))
title(['Sig+Sig+Quad: ',num2str(max(accuracy)*100),'%'])
[accuracy_test,y_out] = evaluatemnist(hidden_active,output_active,x_test,y_test,weight,bias,nlayer);
disp(['test_data: ',num2str(accuracy_test*100),'%']);
Y = tsne(x_test','Algorithm','exact','NumPCAComponents',50,'Distance','cosine');
figure;rng default;gscatter(Y(:,1),Y(:,2),y_out'); title('Learning Result')
figure;rng default;gscatter(Y(:,1),Y(:,2),y_test'); title('Expecting Result')
I = find(y_out'-y_test'~=0);
figure;rng default;gscatter(Y(I,1),Y(I,2),y_out'); title('Recognising Fault')
hold on;rng default;gscatter(Y(I,1),Y(I,2),y_test','o');