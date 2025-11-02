function [z,da] = kerr(a,dz)
%KERR NONLINEAR n2/n0*abs2(a)
%
if nargin == 1
    dz = zeros(size(a));
end

n2 = 2e-6; % Kerr coefficient
f = conj(a).*a;
z = a.*exp(1i*n2*f);
da = dz.*exp(-1i*n2*f);
da = da+2*n2*a.*imag(conj(a).*da);
end

