function d = acti_sigmoid_prime(z)
% sigmoid激活函数的导数
d = zeros(size(z));
d(z>0 & z<3) = 1;

%f = acti_sigmoid(z);
%d = f.*(1-f);
end

