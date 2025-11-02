function weight = complex_weight(n_out,n_in,type)
% paremeters are in unit of um
if nargin == 2
    type = "star";
end
D = 1; % input waveguide interval
d = 1; % output waveguide interval
w = 1; % waveguide width
f = 1000; % field distance
lambda = 1.55/3; % working wavelength

if type == "slab"
    d = D*n_in/n_out;
end
omiga2 = pi/f/lambda; % k/(2f)
q = (2*repmat((1:n_in),[n_out,1])-n_in-1)*D/2;
p = (2*repmat((1:n_out)',[1,n_in])-n_out-1)*d/2;
kapa = 1; % w*exp(2i*f^2)/(1i*lambda*f)

theta = omiga2*w*p;
if type == "slab"
    theta = omiga2*w*(p-q);
end

weight = kapa*sin(theta)./theta.*exp(-2i*omiga2*p.*q);

if type == "slab"
    weight = weight.*exp(1i*omiga2*(p.^2+q.^2));
end