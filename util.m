%% General Functions for our VLC Sim

intensity = @(power) power/pi;
irradiance = @(intensity, distance) intensity / (distance^2);
detected_power = @(irradiance, area) irradiance * area;

n_photons = @(p_detected, sampling_time) ( p_detected * sampling_time) / energy_photon;
n_electrons = @(p_detected, quantum_efficiency, sampling_time) quantum_efficiency * n_photons(p_detected, sampling_time);

%% Noise Functions
current = @(p_detected, quantum_efficiency, sampling_time) n_electrons(p_detected, quantum_efficiency, sampling_time) / sampling_time;
sigma = @(p_detected, quantum_efficiency, sampling_time) sqrt(n_electrons(p_detected, quantum_efficiency, sampling_time)) / sampling_time;
