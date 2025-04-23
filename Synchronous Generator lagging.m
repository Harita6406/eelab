% terminal_char_lagging.m
% Terminal voltage vs line current for LAGGING PFs (correct downward trend)

clear; clc;

% Parameters
e_a = 277.0;                 % Internal generated EMF (V)
x_s = 1.0;                   % Synchronous reactance (ohm)
i_a = linspace(0, 60, 21);   % Armature current (A)
pf_values = [0.8, 0.6, 0.4, 0.2]; % Lagging PFs
v_t_lag = zeros(length(pf_values), length(i_a)); % Terminal voltages

for k = 1:length(pf_values)
    theta = acos(pf_values(k));  % Positive angle for lagging PF
    for ii = 1:length(i_a)
        % Voltage drop across synchronous reactance (imaginary)
        jxs_ia = 1j * x_s * i_a(ii) * exp(1j * theta); 
        v_phase = abs(e_a - jxs_ia); 
        v_t_lag(k, ii) = v_phase * sqrt(3); % Convert to line voltage
    end
end

% Plotting
figure;
hold on;
colors = lines(4);
for k = 1:length(pf_values)
    plot(i_a, v_t_lag(k, :), 'LineWidth', 2, 'Color', colors(k,:), ...
        'DisplayName', sprintf('PF = %.1f Lagging', pf_values(k)));
end
xlabel('Line Current (A)', 'FontWeight', 'bold');
ylabel('Terminal Voltage (V)', 'FontWeight', 'bold');
title('Synchronous Generator – Lagging PF', 'FontWeight', 'bold');
legend('Location', 'southwest');
grid on;
axis([0 60 400 550]);
hold off;