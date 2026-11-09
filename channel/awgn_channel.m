function [rx_signal, noise] = awgn_channel(tx_signal, SNR_dB)

% Calculate Signal Power
signal_power = mean(tx_signal.^2);

% Convert SNR from dB to linear scale
SNR_linear = 10^(SNR_dB/10);

% Calculate Noise Power
noise_power = signal_power/SNR_linear;

% Generate Gaussian Noise
noise = sqrt(noise_power)*randn(size(tx_signal));

% Received Signal
rx_signal = tx_signal + noise;

% Visualization
figure('Name','AWGN Channel');

subplot(3,1,1);
plot(tx_signal);
ylim([-1.2 1.2])
title('Transmitted Signal');
grid on;

subplot(3,1,2);
plot(noise);
title('Added Gaussian Noise');
grid on;

subplot(3,1,3);
plot(rx_signal);
title(['Received Signal (SNR = ',num2str(SNR_dB),' dB)']);
grid on;

end