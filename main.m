clc;
clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Newton-Raphson Load Flow Analysis
%
% Developed by : Yogesh Kumar
% Institute    : NIT Srinagar
%
% Description:
% Performs load flow analysis of a 3-bus power system
% using the Newton-Raphson algorithm.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% =========================
%  READ DATA FROM EXCEL
%% =========================

linedata = readmatrix('LineData.csv');
busdata = readmatrix('BusData.csv');

nbus = size(busdata,1);

%% =========================
%  Y-BUS FORMATION
%% =========================

Ybus = formYbus(linedata);
disp('Y-Bus Matrix')
disp(Ybus)

%% =========================
%  EXTRACT BUS DATA
%% =========================

busNo = busdata(:,1);
V = busdata(:,3);
delta = deg2rad(busdata(:,4));

Pg = busdata(:,5);
Qg = busdata(:,6);
Pd = busdata(:,7);
Qd = busdata(:,8);

Pspec = Pg - Pd;
Qspec = Qg - Qd;

disp('Specified Real Power')
disp(Pspec)

disp('Specified Reactive Power')
disp(Qspec)

%% =========================
%  NR SETTINGS
%% =========================

tolerance = 1e-6;
max_iteration = 20;

iteration = 0;

while iteration < max_iteration

    iteration = iteration + 1;
   
%% =========================
%  CALCULATE P AND Q
%% =========================

% Separate Ybus into Conductance (G) and Susceptance (B)
G = real(Ybus);
B = imag(Ybus);

[Pcalc,Qcalc] = calcPower(Ybus,V,delta);

%% =========================
%  POWER MISMATCH
%% =========================

% Calculate mismatch
dP = Pspec - Pcalc;
dQ = Qspec - Qcalc;

%% =========================
%  MISMATCH VECTOR FOR NR
%% =========================

% Ignore Slack Bus
% Ignore Q mismatch for PV Bus

mismatch = [
    dP(2)
    dP(3)
    dQ(3)
];

fprintf('Iteration %2d : Maximum Mismatch = %.8f\n', ...
        iteration, max(abs(mismatch)));

%% =========================
%  JACOBIAN MATRIX
%% =========================

J = buildJacobian(G,B,V,delta,Pcalc,Qcalc);

%% =========================
%  SOLVE FOR CORRECTIONS
%% =========================

% Solve J * dX = mismatch
dX = J \ mismatch;

% Extract corrections

dDelta = dX(1:2);

dV = dX(3);

%% =========================
%  UPDATE VOLTAGES
%% =========================

% Update voltage angles
delta(2) = delta(2) + dDelta(1);
delta(3) = delta(3) + dDelta(2);

% Update voltage magnitude
V(3) = V(3) + dV;


    % Check convergence
    
    if max(abs(mismatch)) < tolerance
        
        fprintf('\nLoad Flow Converged in %d iterations.\n', iteration);
        break
        
    end

end

if iteration == max_iteration
    warning('Load flow did not converge within the maximum iterations.');
end

fprintf('\nConvergence Tolerance : %.1e\n', tolerance);

%% =========================
%  FINAL LOAD FLOW RESULTS
%% =========================

fprintf('\n');
fprintf('=============================================\n');
fprintf('      NEWTON-RAPHSON LOAD FLOW RESULTS\n');
fprintf('=============================================\n');

fprintf('\nNumber of Iterations : %d\n', iteration);

fprintf('\n');
fprintf('---------------------------------------------\n');
fprintf(' Bus     Voltage(p.u.)     Angle(deg)\n');
fprintf('---------------------------------------------\n');

for i = 1:nbus
    fprintf(' %2d        %8.4f        %9.4f\n', ...
        busNo(i), V(i), rad2deg(delta(i)));
end


fprintf('---------------------------------------------\n');
fprintf('\nLoad Flow Analysis Completed Successfully.\n');


%% =========================
%COMPLEX BUS VOLTAGES
%% =========================

Vcomplex = V .* exp(1j * delta);

disp('Complex Bus Voltages')
disp(Vcomplex)

%% =========================
%  LINE CURRENTS & LINE POWER FLOW
%% =========================
[Iij, Iji, Sij, Sji] = calcLineFlow(linedata, V, delta);

Pij = real(Sij);
Qij = imag(Sij);

Pji = real(Sji);
Qji = imag(Sji);

%% =========================
%  LINE LOSSES
%% =========================

[Ploss, Qloss] = calcLosses(Sij, Sji);

%% =========================
% DISPLAY LINE FLOW RESULTS
%% =========================

fprintf('\n');
fprintf('===============================================================\n');
fprintf('              LINE POWER FLOW RESULTS\n');
fprintf('===============================================================\n');

fprintf('\n');
fprintf(' From   To        Pij        Qij        Pji        Qji\n');
fprintf('---------------------------------------------------------------\n');

for k = 1:size(linedata,1)

    fprintf('%4d %5d %10.4f %10.4f %10.4f %10.4f\n',...
        linedata(k,1),linedata(k,2),...
        Pij(k),Qij(k),Pji(k),Qji(k));

end

fprintf('---------------------------------------------------------------\n');

fprintf('\nTotal Real Power Loss     = %.6f p.u.\n', Ploss);
fprintf('Total Reactive Power Loss = %.6f p.u.\n', Qloss);

% Plotting
plotVoltage(V, delta);
