function vrot=givapp(c,s,vin,k)
% This is a modification of a code by C. T. Kelley at:
% https://www.mathworks.com/matlabcentral/fileexchange/2198-iterative-methods-for-linear-and-nonlinear-equations?focused=6124548&tab=function
%  Apply a sequence of k Givens rotations, used within gmres codes
%  C. T. Kelley, July 10, 1994 (modified by S. Tajeddin for use in MPsee toolbox)
% This code comes with no guarantee or warranty of any kind.
%  function vrot=givapp(c, s, vin, k)
%
vrot=vin;
for i=1:k
    w1=c(i)*vrot(i)-s(i)*vrot(i+1);
    w2=s(i)*vrot(i)+conj(c(i))*vrot(i+1);
    vrot(i:i+1)=[w1,w2];
end