function [z,da] = sqrmax(a,dz)
%SOFTMAX abs2(z)/sum(abs2(z))
%   
if nargin == 1
    dz = zeros(size(a));
end

f = conj(a).*a;
s = sum(f,1);
z = f./s;
da=a.*(dz-sum(z.*dz,1))./s;
end

