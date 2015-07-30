%% General "Main" to run VLC Sim functions

% Some general values
power_src = 3.3; % watt
irradiance_ambient = 10; % watt / m^2 Sunlight = 1000
clock_rate = 15e6; % From IEEE Spec
wavelength = 600e-9; % 590-610 nm based on Cree Spec

%% Reciever Info
area = 1e-6; % 1 mm^2
quantum_efficiency = 0.75; % Generally 50-90%. Not a huge factor

constants = [clock_rate, wavelength, area, quantum_efficiency];
%% Vary Power vs Distance (fixing distance)

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
errors = errors_vs_power(power_range, distance, irradiance_ambient, constants);


subplot(2,2,2) % first subplot
plot(power_range, errors, 'r');
title('Power vs Probability of Error @ 5m');
xlabel('Power (Watts)');
ylabel('Probability of Error');


distance = 7.5;
errors = errors_vs_power(power_range, distance, irradiance_ambient, constants);


subplot(2,2,3) % first subplot
plot(power_range, errors, 'r');
title('Power vs Probability of Error @ 7.5m');
xlabel('Power (Watts)');
ylabel('Probability of Error');

distance = 10;
errors = errors_vs_power(power_range, distance, irradiance_ambient, constants);

subplot(2,2,4) % first subplot
plot(power_range, errors, 'r');
title('Power vs Probability of Error @ 10m');
xlabel('Power (Watts)');
ylabel('Probability of Error');
hold off

%% Plot Power vs Distance (Fixing power)
figure()

dist_range = 0.5:0.25:30;

power = 1;
errors = errors_vs_distance(dist_range, power, irradiance_ambient, constants);

hold on
subplot(2,2,1) % first subplot
plot(dist_range, errors, 'r');
title('Distance vs Probability of Error @ 1W');
xlabel('Distance (Meters)');
ylabel('Probability of Error');


power = 3.3;
errors = errors_vs_distance(dist_range, power, irradiance_ambient, constants);


subplot(2,2,2) % first subplot
plot(dist_range, errors, 'r');
title('Distance vs Probability of Error @ 3.3W');
xlabel('Distance (Meters)');
ylabel('Probability of Error');


power = 6.6;
errors = errors_vs_distance(dist_range, power, irradiance_ambient, constants);


subplot(2,2,3) % first subplot
plot(dist_range, errors, 'r');
title('Distance vs Probability of Error @ 6.6W');
xlabel('Distance (Meters)');
ylabel('Probability of Error');

power = 9.9;
errors = errors_vs_distance(dist_range, power, irradiance_ambient, constants);

subplot(2,2,4) % first subplot
plot(dist_range, errors, 'r');
title('Distance vs Probability of Error @ 9.9W');
xlabel('Distance (Meters)');
ylabel('Probability of Error');
hold off