%% DEPRECATED:
% This was a proof of concept of formulas. We are now using main.m
% to run this across a range of conditions

%% Transmitter Info
power_src = 3.3; % watt
irradiance_ambient = 10; % watt / m^2 Sunlight = 1000
clock_rate = 15e6; % From IEEE Spec
wavelength = 600e-9; % 590-610 nm based on Cree Spec

%% Reciever Info
sampling_time = 1 / clock_rate;
% With that clock rate, lets use RS(64, 32)
% which should give us a 6mb/s data rate.
area = 1e-6; % 1 mm^2
quantum_efficiency = 0.75; % Generally 50-90%. Not a huge factor

dist = 5; % meters (Transmitter to Reciever)
%% Constants
h = 6.626068e-34; % Planks constant
c = 299792458; % m/s Speed of Light

energy_photon = (h * c) / wavelength;
%% General Functions
% From Lambertian Source
intensity = @(power) power/pi;
irradiance = @(intensity, distance) intensity / (distance^2);
detected_power = @(irradiance, area) irradiance * area;

n_photons = @(p_detected) ( p_detected * sampling_time) / energy_photon;
n_electrons = @(p_detected) quantum_efficiency * n_photons(p_detected);

%% Noise Functions
current = @(p_detected) n_electrons(p_detected) / sampling_time;
sigma = @(p_detected) sqrt(n_electrons(p_detected)) / sampling_time;

%% Calculations
t_intensity = intensity(power_src);
t_irradiance = irradiance(t_intensity, dist);
p_detect = detected_power(t_irradiance, area);

p_ambient_detect = detected_power(irradiance_ambient, area);

% Just Noise
ambient = current(p_ambient_detect); % In electrons
ambient_var = sigma(p_ambient_detect); % In electrons

ambient_and_signal = current(p_ambient_detect + p_detect); % In electrons
ambient_and_signal_var = sigma(p_ambient_detect + p_detect); % In electrons

mu1 = ambient / 6.25e18; % Current
sigma1 = ambient_var / 6.25e18; % Current

mu2 = ambient_and_signal / 6.25e18; % Current
sigma2 = ambient_and_signal_var / 6.25e18; % Current

%% Plot these two.
x = (min(mu1, mu2) - max(sigma1, sigma2) * 5):(min(sigma1, sigma2) / 1000):(max(mu1, mu2) + max(sigma1, sigma2) * 5);
y1 = pdf('normal', x, mu1, sigma1);
y2 = pdf('normal', x, mu2, sigma2);
plot(x, y1, 'b')
hold on 
plot(x, y2, 'r')
legend('Ambient', 'Ambient and Signal')
title('Density functions')
hold on

%% Find intersection of two PDFs
idx = find(y1 - y2 < 1e-5, 1); % Index of coordinate in array
px = x(idx);
py = y1(idx);

plot(px, py, 'ro', 'MarkerSize', 18)

%% Now calculate Error
cdf1 = cdf('normal', x, mu1, sigma1);
cdf2 = cdf('normal', x, mu2, sigma2);

left_error = 1 - cdf1(idx);
right_error = cdf2(idx);

prob_error = left_error + right_error;

% QUESTION: Probability of error seems very very low
sprintf('Distance: %f Meters', dist)
sprintf('Source Power: %f Watts', power_src)
sprintf('Ambient Irradiance %f W/m^2', irradiance_ambient)
sprintf('Chance of error: %f%%', prob_error * 100)