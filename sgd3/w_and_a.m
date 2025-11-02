addpath('bp')
% ip=1;
weight{nlayer} = we2*we1;
    bias{nlayer} = we2*ba1+ba2;
[accuracy,yp] = evaluatemnist(@xian,@acti_sigmoid,x_valid,y_valid,weight,bias,nlayer);
    plot(accuracy);
    title(['Accuracy:',num2str(accuracy,'%.15f')]);
    getframe;
    rmpath('bp')