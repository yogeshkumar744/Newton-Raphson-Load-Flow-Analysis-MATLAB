function [Iij, Iji, Sij, Sji] = calcLineFlow(linedata, V, delta)

nLine = size(linedata,1);

% Complex bus voltages
Vc = V .* exp(1j*delta);

% Initialize variables
Iij = zeros(nLine,1);
Iji = zeros(nLine,1);
Sij = zeros(nLine,1);
Sji = zeros(nLine,1);

for k = 1:nLine

    from = linedata(k,1);
    to   = linedata(k,2);

    R = linedata(k,3);
    X = linedata(k,4);

    Z = R + 1j*X;
    Y = 1/Z;

    % Line currents
    Iij(k) = (Vc(from) - Vc(to)) * Y;
    Iji(k) = (Vc(to) - Vc(from)) * Y;

    % Complex power flow
    Sij(k) = Vc(from) * conj(Iij(k));
    Sji(k) = Vc(to) * conj(Iji(k));

end

end