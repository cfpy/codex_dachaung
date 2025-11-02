function [weight,bias] = bp_backpropagation(hiddenActiFcn,outputActiFcn,outputFcnType,weight,bias,nlayer,mini_batch_size,eta,a,ys,y,lambda,n)
%BP_BACKPROPAGATION 此处显示有关此函数的摘要
%   此处显示详细说明
%   默认采用均方插目标函数

switch outputFcnType
    case 'quadratic'
        delta_z = ys-y;
    case 'x_entropy'
        delta_z = ys-y;
    otherwise
        delta_z = ys-y;
end
[~,delta_a] = outputActiFcn(a{end},delta_z);

for in = nlayer-1:-1:1
    labda_weight = (delta_a*a{in}'*diag(exp(bias{in}')))/mini_batch_size;
    delta_z = diag(exp(bias{in}'))*weight{in}'*delta_a;
    [~,delta_a] = hiddenActiFcn(a{in},delta_z);
    bias{in} = bias{in} - (eta*mean(conj(a{in}).*delta_a,2));
    weight{in} = (1-eta*lambda/n)*weight{in} - eta*labda_weight;
end

end

