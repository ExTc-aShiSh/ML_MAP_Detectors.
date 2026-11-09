function visualize_detection(sps, noise_power, P0, P1)

% Decision Statistic Parameters
mu0 = -sps;
mu1 = sps;

sigma_y = sqrt(sps * noise_power);

% Decision Thresholds
ml_threshold = 0;
map_threshold = (sps*noise_power/2)*log(P0/P1);

% X-axis
x = linspace(-2*sps, 2*sps, 1000);

% Gaussian Probability Distributions
pdf0 = normpdf(x, mu0, sigma_y);
pdf1 = normpdf(x, mu1, sigma_y);

% Weighted Likelihoods
weighted0 = P0 * pdf0;
weighted1 = P1 * pdf1;

% Visualization
figure('Name','Interactive ML vs MAP Visualizer');

subplot(2,1,1);

plot(x, pdf0, 'b', 'LineWidth', 2);
hold on;
plot(x, pdf1, 'r', 'LineWidth', 2);

xline(ml_threshold, 'k--', 'ML Threshold');

title('ML Detection: Probability Distributions');
xlabel('Received Decision Statistic');
ylabel('Probability Density');

legend('P(y|S0)','P(y|S1)','ML Threshold');
grid on;

subplot(2,1,2);

plot(x, weighted0, 'b', 'LineWidth', 2);
hold on;
plot(x, weighted1, 'r', 'LineWidth', 2);

xline(map_threshold, 'm--', 'MAP Threshold');

title('MAP Detection: Weighted Likelihoods');
xlabel('Received Decision Statistic');
ylabel('Weighted Probability Density');

legend('P(S0)P(y|S0)', ...
    'P(S1)P(y|S1)', ...
    'MAP Threshold');

grid on;

sgtitle('ML and MAP Detection Analysis');

end