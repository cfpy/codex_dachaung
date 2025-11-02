load('../data/cifar/data_batch_1.mat');
x_train = double(data);
y_label = double(labels);
load('../data/cifar/data_batch_2.mat');
x_train = [x_train;double(data)];
y_label = [y_label;double(labels)];
load('../data/cifar/data_batch_3.mat');
x_train = [x_train;double(data)];
y_label = [y_label;double(labels)];
load('../data/cifar/data_batch_4.mat');
x_train = [x_train;double(data)];
y_label = [y_label;double(labels)];
load('../data/cifar/data_batch_5.mat');
x_train = [x_train;double(data)];
y_label = [y_label;double(labels)];

x_train = x_train';
y_train = zeros(10,50000);
y_train((1:50000)*10-9+y_label') = 1;

x_valid = double(data');
y_valid = double(labels');

load('../data/cifar/test_batch.mat');
x_test = double(data');
y_test = double(labels');