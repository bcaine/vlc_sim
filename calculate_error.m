function error = calculate_error(mu1, sigma1, mu2, sigma2);

x = (min(mu1, mu2) - max(sigma1, sigma2) * 5):(min(sigma1, sigma2) / 1000):(max(mu1, mu2) + max(sigma1, sigma2) * 5);
y1 = pdf('normal', x, mu1, sigma1);
y2 = pdf('normal', x, mu2, sigma2);

% Find Intersection
idx = find(y1 - y2 < 1e-5, 1); % Index of coordinate in array

% Calculate CDFs
cdf1 = cdf('normal', x, mu1, sigma1);
cdf2 = cdf('normal', x, mu2, sigma2);

% Find left and righ terror
left_error = 1 - cdf1(idx);
right_error = cdf2(idx);

error = left_error + right_error;
end
