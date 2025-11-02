function [a,ys] = bp_feedforward(hiddenActiFcn,outputActiFcn,weight,bias,nlayer,a)
%BP_FEEDFORWARD 此处显示有关此函数的摘要
%   此处显示详细说明
for in = 1:nlayer-1
    w = weight{in};
    b = bias{in};
    z = hiddenActiFcn(a{in});
    a{in+1} = w*diag(exp(b))*z;
end

ys = outputActiFcn(a{end});

end

