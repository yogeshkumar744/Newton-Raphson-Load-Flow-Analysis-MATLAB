function plotVoltage(V, delta)
% plotVoltage - Plots bus voltage magnitudes and angles

% Voltage Magnitude Profile
figure;
plot(1:length(V), V, '-o', ...
    'LineWidth', 2, ...
    'MarkerSize', 8);

grid on;
xlabel('Bus Number');
ylabel('Voltage Magnitude (p.u.)');
title('Voltage Magnitude Profile');
xticks(1:length(V));

% Voltage Angle Profile
figure;
plot(1:length(delta), rad2deg(delta), '-s', ...
    'LineWidth', 2, ...
    'MarkerSize', 8);

grid on;
xlabel('Bus Number');
ylabel('Voltage Angle (degrees)');
title('Voltage Angle Profile');
xticks(1:length(delta));

end