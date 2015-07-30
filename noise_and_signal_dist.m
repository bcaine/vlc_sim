function [mu1, sigma1, mu2, sigma2] = noise_and_signal_dist(power_src, irradiance_ambient,  distance, constants)
clock_rate = constants(1);
wavelength = constants(2);
area = constants(3);
quantum_efficiency = constants(4);

% Import util functions
util;

sampling_time = 1 / clock_rate;

%% Constants
h = 6.626068e-34; % Planks constant
c = 299792458; % m/s Speed of Light

energy_photon = (h * c) / wavelength;

%% General functions
n_photons = @(p_detected) ( p_detected * sampling_time) / energy_photon;
n_electrons = @(p_detected) quantum_efficiency * n_photons(p_detected);

%% Noise Functions
current = @(p_detected) n_electrons(p_detected) / sampling_time;
sigma = @(p_detected) sqrt(n_electrons(p_detected)) / sampling_time;


%% Calculations
t_intensity = power_src/pi;
t_irradiance = t_intensity / (distance^2);
p_detect = t_irradiance * area;

p_ambient_detect = irradiance_ambient * area;

% Just Noise
ambient = current(p_ambient_detect); % In electrons
ambient_var = sigma(p_ambient_detect); % In electrons

ambient_and_signal = current(p_ambient_detect + p_detect); % In electrons
ambient_and_signal_var = sigma(p_ambient_detect + p_detect); % In electrons

mu1 = ambient / 6.25e18; % Current
sigma1 = ambient_var / 6.25e18; % Current

mu2 = ambient_and_signal / 6.25e18; % Current
sigma2 = ambient_and_signal_var / 6.25e18; % Current

end