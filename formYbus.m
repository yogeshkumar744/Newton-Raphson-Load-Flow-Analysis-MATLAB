function Ybus = formYbus(linedata)

nBus = max(max(linedata(:,1:2)));

Ybus = zeros(nBus);

% Paste your existing Y-Bus formation code here
nbus = max(max(linedata(:,1:2)));

Ybus = zeros(nbus,nbus);

for k = 1:size(linedata,1)

    from = linedata(k,1);
    to   = linedata(k,2);

    R = linedata(k,3);
    X = linedata(k,4);

    Z = R + 1i*X;
    Y = 1/Z;

    Ybus(from,to) = Ybus(from,to) - Y;
    Ybus(to,from) = Ybus(to,from) - Y;

    Ybus(from,from) = Ybus(from,from) + Y;
    Ybus(to,to) = Ybus(to,to) + Y;

end

% disp('Y-Bus Matrix')
% disp(Ybus)
end