function J = buildJacobian(G,B,V,delta,Pcalc,Qcalc)

J1 = zeros(2,2);
J2 = zeros(2,1);
J3 = zeros(1,2);
J4 = zeros(1,1);

%% -------------------------
% J1 = dP / dDelta
%% -------------------------

for i = 2:3

    for j = 2:3

        if i == j

            J1(i-1,j-1) = -Qcalc(i) - B(i,i)*V(i)^2;

        else

            theta = delta(i)-delta(j);

            J1(i-1,j-1)=V(i)*V(j)*...
                (G(i,j)*sin(theta)-B(i,j)*cos(theta));

        end

    end

end

%% -------------------------
% J2 = dP / dV
%% -------------------------

for i = 2:3

    j = 3;      % Only Bus 3 voltage is unknown

    if i == j

        J2(i-1,1) = (Pcalc(i)/V(i)) + G(i,i)*V(i);

    else

        theta = delta(i) - delta(j);

        J2(i-1,1) = V(i) * ...
            ( G(i,j)*cos(theta) + ...
              B(i,j)*sin(theta) );

    end

end

%% -------------------------
% J3 = dQ / dDelta
%% -------------------------

i = 3;      % Only PQ bus

for j = 2:3

    if i == j

        J3(1,j-1) = Pcalc(i) - G(i,i)*V(i)^2;

    else

        theta = delta(i) - delta(j);

        J3(1,j-1) = -V(i)*V(j)* ...
            ( G(i,j)*cos(theta) + ...
              B(i,j)*sin(theta) );

    end

end

%% -------------------------
% J4 = dQ / dV
%% -------------------------

i = 3;

J4(1,1) = (Qcalc(i)/V(i)) - B(i,i)*V(i);

%% -------------------------
% Complete Jacobian
%% -------------------------

J = [J1 J2;
     J3 J4];

end