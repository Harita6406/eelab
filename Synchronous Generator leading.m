% terminal_char_leading.m
% Terminal voltage vs line current for LEADING power factors

clear; clc;

% Parameters
e_a = 277.0;              % Internal generated EMF (V)
x_s = 1.0;                % Synchronous reactance (ohm)
i_a = linspace(0, 60, 21); % Armature current (A)
pf_values = [0.8, 0.6, 0.4, 0.2]; % Leading PFs

v_t_lead = zeros(length(pf_values), length(i_a)); % Voltage matrix

% Calculation for leading power factors (negative theta)
for k = 1:length(pf_values)
    theta = -acos(pf_values(k));  % Leading → negative θ
    for ii = 1:length(i_a)
        real_drop = x_s * i_a(ii) * cos(theta);
        imag_drop = x_s * i_a(ii) * sin(theta);
        v_phase = sqrt((e_a - real_drop)^2 + imag_drop^2);
        v_t_lead(k, ii) = v_phase * sqrt(3); % Convert to line voltage
    end
end

% Plotting
figure;
hold on;
colors = lines(4);
for k = 1:length(pf_values)
    plot(i_a, v_t_lead(k, :), 'LineWidth', 2, 'Color', colors(k,:), ...
        'DisplayName', sprintf('PF = %.1f Leading', pf_values(k)));
end
xlabel('Line Current (A)', 'FontWeight', 'bold');
ylabel('Terminal Voltage (V)', 'FontWeight', 'bold');
title('Synchronous Generator – Leading PF', 'FontWeight', 'bold');
legend('Location', 'southeast');
grid on;
axis([0 60 400 550]);
hold off;