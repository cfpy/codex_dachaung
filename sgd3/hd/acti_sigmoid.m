function d = acti_sigmoid(z)
% sigmoid¼¤»îº¯Êý
d = z;
d(z<0) = 0;
d(z>3) = 3;
%d = 1./(1+exp(-z));
end

