function [error,yp,ys] = evaluatemnist(hiddenActiFcn,outputActiFcn,x_valid,y_valid,weight,bias,nlayer)

num = length(y_valid);
a = x_valid;

for in = 1:nlayer-1
    w = weight{in};
    b = bias{in};
    z = hiddenActiFcn(a);
    a = w*diag(exp(b))*z;
end

ys = outputActiFcn(a);

[~,yp] = max(ys);
yp = yp-1;
error = sum(yp==y_valid)/num;
end

