% Torque-Speed Characteristics of Induction Motor with varying Rotor Resistance
% Based on Chapman, Example 7-5

clear; clc; close all;

% Constants (from Example 7-5)
f = 60;                 % Hz
p = 4;                  % Number of poles
ns = 120*f/p;           % Synchronous speed in RPM
ws = 2*pi*ns/60;        % Synchronous speed in rad/s

V_th = 231;             % Thevenin voltage (V)
R_th = 0.5;             % Thevenin resistance (Ohms)
X_th = 0.9;             % Thevenin reactance (Ohms)
X_R = 0.4;              % Rotor reactance (Ohms)
R_R = 0.3;              % Rotor resistance (Ohms)

% Rotor resistance values to consider
R_values = [0.5*R_R, R_R, 2*R_R];

% Slip range
s = linspace(0.001, 1, 1000);  % Avoid s=0 to prevent division by zero

% Preallocate torque matrix
torque = zeros(length(R_values), length(s));

% Compute torque for each rotor resistance
for k = 1:length(R_values)
    Rr = R_values(k);
    torque(k, :) = (3 * V_th^2 * Rr ./ s) ./ ...
                   (ws * ((R_th + Rr./s).^2 + (X_th + X_R)^2));
end

% Convert slip to speed
n = (1 - s) * ns;

% Plotting
figure;
plot(n, torque(1,:), 'r', 'LineWidth', 1.5); hold on;
plot(n, torque(2,:), 'g', 'LineWidth', 1.5);
plot(n, torque(3,:), 'b', 'LineWidth', 1.5);

xlabel('Speed (RPM)');
ylabel('Torque (Nm)');
title('Torque-Speed Characteristics of Induction Motor');
legend('R_R/2', 'R_R', '2R_R', 'Location', 'Best');
grid on;
xlim([0 ns]);