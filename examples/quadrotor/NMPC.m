function [dU,U,Control] = NMPC(dU0,U0,x0,TVP,TVP_f)
coder.allowpcode('plain');
Kmax=10;
errtol=1.000000e-02;
dimic=0;
iteration_out=0;
dimu=4;
TVP=TVP';
N=length(TVP);
dt=TVP_f(end);
params=[errtol, Kmax];
f0= FxU(x0, TVP,TVP_f, U0);
dU=fdgmres(f0, x0, TVP,TVP_f, U0, params,dU0);
U=U0+dU;
for rep=1:iteration_out
f0= FxU(x0,TVP,TVP_f,U);
dU=fdgmres(f0,x0,TVP,TVP_f,U,params,dU);
U=U+dU;
end
Control=U(1:dimu);
