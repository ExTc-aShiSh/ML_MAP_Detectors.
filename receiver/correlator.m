function corr_samples = correlator(rx_signal, N, sps)

% Reference Pulse
reference = ones(1, sps);

corr_samples = zeros(1, N);

% Correlation for Each Symbol
for k = 1:N

    start_idx = (k-1)*sps + 1;
    end_idx = k*sps;

    received_segment = rx_signal(start_idx:end_idx);

    corr_samples(k) = sum(received_segment .* reference);

end

% Visualization
figure('Name','Correlator Receiver');

stem(1:N, corr_samples, 'filled');
title('Correlator Receiver Output');
xlabel('Symbol Index');
ylabel('Correlation Value');
grid on;

end