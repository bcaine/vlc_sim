function errors = errors_vs_power(power_range, distance, irradiance_ambient, constants)
% Note that distributions is a function that has some fixed values
errors = zeros(1, length(power_range));
i = 1;
for power = power_range
    [mu1, sigma1, mu2, sigma2] = noise_and_signal_dist(power, irradiance_ambient, distance, constants);
    errors(i) = calculate_error(mu1, sigma1, mu2, sigma2);
    i = i + 1;
end
end
