function [bits, symbols, tx_signal, t] = transmitter(N)

% Binary Data Generation
bits = randi([0 1], 1, N);

% BPSK Modulation
symbols = 2*bits - 1;

% Pulse Shaping
samples_per_symbol = 100;
tx_signal = repelem(symbols, samples_per_symbol);

% Time Vector
t = (0:length(tx_signal)-1)/samples_per_symbol;

% Visualization
figure('Name','Transmitter Module');

subplot(2,1,1);
stairs(0:N-1, bits, 'LineWidth', 1.5);
ylim([-0.2 1.2]);
title('Generated Binary Data');
xlabel('Bit Index');
ylabel('Bit Value');
grid on;

subplot(2,1,2);
plot(t, tx_signal, 'LineWidth', 1.5);
ylim([-1.2 1.2])
title('BPSK Modulated Signal');
xlabel('Time (Symbol Periods)');
ylabel('Amplitude');
grid on;

end