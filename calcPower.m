function [Pcalc,Qcalc] = calcPower(Ybus,V,delta)

nbus = length(V);

Pcalc = zeros(nbus,1);
Qcalc = zeros(nbus,1);

for i = 1:nbus
    for j = 1:nbus

        theta = angle(Ybus(i,j));

        Pcalc(i) = Pcalc(i) + ...
            V(i)*V(j)*abs(Ybus(i,j))*cos(theta + delta(j) - delta(i));

        Qcalc(i) = Qcalc(i) - ...
            V(i)*V(j)*abs(Ybus(i,j))*sin(theta + delta(j) - delta(i));

    end
end

end