function z = C_DIRDER(U,x,W,w,TVP,TVP_f,f0,con)
% This is a modification of a code by C. T. Kelley at:
% https://www.mathworks.com/matlabcentral/fileexchange/2198-iterative-methods-for-linear-and-nonlinear-equations?focused=6124548&tab=function
% Finite difference directional derivative
% Approximate f'(x) w
% C. T. Kelley, November 25, 1993 (modified by S. Tajeddin for use in MPsee toolbox)
% This code comes with no guarantee or warranty of any kind.
% function z = C_DIRDER(U,x,W,w,TVP,con)
% inputs:
%           U, x = function points
%           W, w = directions at points
%           TVP = time-varying parameters
%           TVP_f = frozen time-varying parameters
%           f0 = f evaluated at U, x
%           con = constraints
% Hardwired difference increment.
eps=1.d-4;
%
n=length(U);
%
% scale the step
%
if norm(W) == 0 && norm(w) == 0 %&& norm(l) == 0
    z=zeros(n,1);
return
end

delU=U+eps*W;
delX=x+eps*w;

if nargin == 8
    f1=FxU(delX,TVP,TVP_f,delU,con);
   
else
    f1=FxU(delX,TVP,TVP_f,delU);
    
end

z = (f1 - f0)/eps;