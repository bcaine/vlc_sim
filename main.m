%% General "Main" to run VLC Sim functions

% Some general values
power_src = 3.3; % watt
irradiance_ambient = 10; % watt / m^2 Sunlight = 1000
clock_rate = 15e6; % From IEEE Spec
wavelength = 600e-9; % 590-610 nm based on Cree Spec

%% Reciever Info
area = 1e-6; % 1 mm^2
quantum_efficiency = 0.75; % Generally 50-90%. Not a huge factor

distance = 5; % meters (Transmitter to Reciever)

constants = [clock_rate, wavelength, area, quantum_efficiency];
%% Vary Power vs Distance

distance = 2.5;
power_range = 0.1:0.05:20;
errors = errors_vs_power(power_range, distance, irradiance_ambient, constants);

hold on
subplot(2,2,1) % first subplot
plot(power_range, errors, 'r');
title('Power vs Probability of Error @ 2.5m');
xlabel('Power (Watts)');
ylabel('Probability of Error');


distance = 5;
power_range = 0.1:0.05:20;
errors = errors_vs_power(power_range, distance, irradiance_ambient, constants);


subplot(2,2,2) % first subplot
plot(power_range, errors, 'r');
title('Power vs Probability of Error @ 5m');
xlabel('Power (Watts)');
ylabel('Probability of Error');


distance = 7.5;
power_range = 0.1:0.05:20;
errors = errors_vs_power(power_range, distance, irradiance_ambient, constants);


subplot(2,2,3) % first subplot
plot(power_range, errors, 'r');
title('Power vs Probability of Error @ 7.5m');
xlabel('Power (Watts)');
ylabel('Probability of Error');

distance = 10;
power_range = 0.1:0.05:20;
errors = errors_vs_power(power_range, distance, irradiance_ambient, constants);

subplot(2,2,4) % first subplot
plot(power_range, errors, 'r');
title('Power vs Probability of Error @ 10m');
xlabel('Power (Watts)');
ylabel('Probability of Error');
hold off