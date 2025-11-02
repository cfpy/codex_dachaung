function [error,yp,a] = evaluatemnist(hidenActiFcn,outputActiFcn,x_valid,y_valid,weight,bias,nlayer)

num = numel(y_valid);
a = x_valid;
for in = 2:nlayer-1
    w = weight{in};
    b = bias{in};
    z = bsxfun(@plus,w*a,b);
    a = hidenActiFcn(z);
end

w = weight{nlayer};
b = bias{nlayer};

z = bsxfun(@plus,w*a,b);
a = outputActiFcn(z);

% [~,yp] = max(a);
% yp = yp-1;
% error = sum(yp==y_valid)/num;
yp = a;
yp(a < 1/6) = 0;
yp(a >= 1/6 & a < 1/2) = 1;
yp(a >= 1/2 & a < 5/6) = 2;
yp(a >= 5/6) = 3;
error = sum(sum(yp==y_valid))/num;
end

