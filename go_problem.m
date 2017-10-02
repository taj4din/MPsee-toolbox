
%% %%######################################################################
%% %%##################    Define Optimal Control Here       ##############
%% %%######################################################################
%% Uk is the vector of inputs
%% Xk is the vector of states
%%_______________________Vector Field Definition____________________________
%%_________________________in terms of Uk, Xk_______________________________
fxu=[sin(Xk(2))
     U(1)^2];
%%__________________________Constraints Definition__________________________
%%___________________________in terms of Uk, Xk_____________________________
Gxu=[0];                      %% Equality Constraints
Cxu=[Xk(1)-Vmax             %% Inequality Constraints
     Vmin-Xk(1)
     Uk(1)-Umax
     Umin-Uk(1)];
%%_______________________Objective Function Definition____________________
%%___________________________in terms of Uk, Xk __________________________
Lk=0.5*w1*(Xk(1)-Xf)^2+0.5*w2*(Uk(1))^2; %% Tranjectory Cost (Integral Terms)
Lk=Lk+R'*Cxu.^2;            %% Required (Do Not Change!)
Phi=0.5*w3*(Xk(1)-Xf)^2;    %% Terminal Cost
