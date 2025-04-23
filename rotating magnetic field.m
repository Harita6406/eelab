% Magnetic Field in 3-Phase System
% This script calculates the net magnetic field produced by a three-phase stator.

clear all; close all;

% 1. Set up the basic conditions
bmax = 1;  % Normalize bmax to 1
freq = 100; % frequency in Hz
w = 2 * pi * freq; % angular velocity (rad/s)
t = 0:1/16000:1/60; % Time vector from 0 to 1/60 sec with step size 1/16000
theta_offset = 0; % Angle offset, set to 0 for simplicity

% 2. Define the three-phase component magnetic fields
Baa = sin(w*t) .* (cos(theta_offset) + 1i * sin(theta_offset));
Ebb = sin(w*t - 2*pi/3) .* (cos(2*pi/3) + 1i * sin(2*pi/3));
Ecc = sin(w*t + 2*pi/3) .* (cos(-2*pi/3) + 1i * sin(-2*pi/3));

% 3. Calculate Enet (Resultant magnetic field)
Enet = Baa + Ebb + Ecc;

% 4. Calculate a circle representing the expected maximum value of Enet
circle = 1.5 * (cos(w*t) + 1i * sin(w*t));

% 5. Plot the magnitude and direction of the resulting magnetic field
figure;
for ii = 1:length(t)
    clf;
    hold on;

    % Plot the reference circle
    plot(real(circle), imag(circle), 'k', 'LineWidth', 1);

    % Plot the three-phase magnetic field components
    plot([0 real(Baa(ii))], [0 imag(Baa(ii))], 'k', 'LineWidth', 2); % Black - Phase A
    plot([0 real(Ebb(ii))], [0 imag(Ebb(ii))], 'b', 'LineWidth', 2); % Blue - Phase B
    plot([0 real(Ecc(ii))], [0 imag(Ecc(ii))], 'm', 'LineWidth', 2); % Magenta - Phase C

    % Plot the resultant rotating magnetic field
    plot([0 real(Enet(ii))], [0 imag(Enet(ii))], 'r', 'LineWidth', 3); % Red - Resultant field

    axis square;
    axis([-2 2 -2 2]); % Fixed axis limits
    drawnow;
end
hold off;