function [z,da] = satabsorb(a,dz)
%KERR NONLINEAR n2/n0*abs2(a)
%
if nargin == 1
    dz = zeros(size(a));
end

alpha = -0; % amplitude absorption coefficient
Is = 500; % saturated intensity

f = conj(a).*a;
loss = alpha*Is./(Is+f);
factor = exp(loss);
z = a.*factor;

da = (dz-2*loss.*a./(Is+f).*real(conj(a).*dz)).*factor;
end

