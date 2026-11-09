function [mf_output, mf_samples] = matched_filter(rx_signal, N, sps)

% Matched Filter
h = ones(1, sps);

mf_output = filter(h, 1, rx_signal);

% Sample at the end of each symbol
sample_points = sps:sps:N*sps;
mf_samples = mf_output(sample_points);

% Visualization
figure('Name','Matched Filter Receiver');

subplot(2,1,1);
plot(mf_output);
title('Matched Filter Output');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(1:N, mf_samples, 'filled');
title('Matched Filter Decision Statistics');
xlabel('Symbol Index');
ylabel('Output');
grid on;

end