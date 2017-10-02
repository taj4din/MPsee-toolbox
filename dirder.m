function z = dirder(x,w,xk,TVP,TVP_f,f0,con)
% This is a modification of a code by C. T. Kelley at:
% https://www.mathworks.com/matlabcentral/fileexchange/2198-iterative-methods-for-linear-and-nonlinear-equations?focused=6124548&tab=function
% Finite difference directional derivative
% Approximate f'(x) w
% C. T. Kelley, November 25, 1993 (modified by S. Tajeddin for use in MPsee toolbox)
% This code comes with no guarantee or warranty of any kind.
% function z = dirder(x,w,xk,TVP,TVP_f,f0,con)
% inputs:
%           x = function point
%           w = directions at point
%           TVP = time-varying parameters
%           TVP_f = frozen time-varying parameters
%           f0 = f evaluated at x
%           con = constraints
% Hardwired difference increment.
epsnew=1.d-4;
%
n=length(x);

%
% scale the step
%
if norm(w) == 0
    z=zeros(n,1);
return
end
del=x+epsnew*w;
if nargin == 7
    f1=FxU(xk,TVP,TVP_f,del,con);
else
    f1=FxU(xk,TVP,TVP_f,del);
end
z = (f1 - f0)/epsnew;