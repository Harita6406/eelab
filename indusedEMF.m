% M-file to calculate the net magnetic field and induced EMF

% Set up the basic conditions
bmax = 1;             % Normalize Bmax
freq = 60;            % 60 Hz
w = 2 * pi * freq;    % Angular frequency (rad/s)

% Time vector
t = 0:1/6000:1/60;     % One cycle, high resolution

% Define the three-phase magnetic fields (phasors)
Baa = sin(w * t) .* (cos(0) + 1i * sin(0));
Bbb = sin(w * t - 2*pi/3) .* (cos(2*pi/3) + 1i * sin(2*pi/3));
Bcc = sin(w * t + 2*pi/3) .* (cos(-2*pi/3) + 1i * sin(-2*pi/3));

% Net magnetic field
Bnet = Baa + Bbb + Bcc;

% Calculate flux (assume area = 1, so flux = real(Bnet))
flux = real(Bnet);  % Or you could use abs(Bnet) if modeling magnitude-only coupling

% Induced EMF = -dΦ/dt (numerical derivative)
dt = t(2) - t(1);
emf = -diff(flux) / dt;  % EMF is 1 element shorter than t

% Plot the results
figure;

subplot(3,1,1);
plot(t, real(Bnet), 'r');
title('Net Magnetic Field (Real Part)');
xlabel('Time (s)');
ylabel('B_{net}');
grid on;

subplot(3,1,2);
plot(t, flux, 'b');
title('Magnetic Flux through Rotor Loop');
xlabel('Time (s)');
ylabel('\Phi (Wb)');
grid on;

subplot(3,1,3);
plot(t(1:end-1), emf, 'm');
title('Induced EMF in Rotor');
xlabel('Time (s)');
ylabel('EMF (V)');
grid on;