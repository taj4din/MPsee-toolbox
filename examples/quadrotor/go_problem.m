
%% %%######################################################################
%% %%##################    Define Optimal Control Here       ##############
%% %%######################################################################
%% Uk is the vector of inputs
%% Xk is the vector of states
%%_______________________Vector Field Definition____________________________
%%_________________________in terms of Uk, Xk_______________________________
fxu=[Xk(2)
    (Uk(1)+Uk(2)+Uk(3)+Uk(4))*(sin(Xk(11))*sin(Xk(9))+cos(Xk(9))*sin(Xk(7))*cos(Xk(11)))/(m)
    Xk(4)
    (Uk(1)+Uk(2)+Uk(3)+Uk(4))*(-sin(Xk(9))*cos(Xk(11))+cos(Xk(9))*sin(Xk(7))*sin(Xk(11)))/(m)
    Xk(6)
    (Uk(1)+Uk(2)+Uk(3)+Uk(4))*(cos(Xk(9))*cos(Xk(7)))/m-g
    Xk(8)
    l*(Uk(1)-Uk(2))/Jx
    Xk(10)
    l*(Uk(3)-Uk(4))/Jy
    Xk(12)
    k*(Uk(1)+Uk(2)-Uk(3)-Uk(4))/Jz];
%%__________________________Constraints Definition__________________________
%%___________________________in terms of Uk, Xk_____________________________
Gxu=[0];                      %% Equality Constraints
Cxu=[0];             %% Inequality Constraints
%%_______________________Objective Function Definition____________________
%%___________________________in terms of Uk, Xk __________________________
Lk=0.5*(Xk-Xf)'*diag(Q)*(Xk-Xf)+0.5*Uk'*diag(W)*Uk; %% Tranjectory Cost (Integral Terms)
Lk=Lk+R'*Cxu.^2;            %% Required (Do Not Change!)
Phi=0;    %% Terminal Cost
