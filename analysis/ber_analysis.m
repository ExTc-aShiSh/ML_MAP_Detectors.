function ber_analysis()

clc;

% Simulation Parameters
N = 200000;
SNR_dB = 0:1:20;
sps = 100;

ber_ml = zeros(size(SNR_dB));
ber_map = zeros(size(SNR_dB));
ber_theory = zeros(size(SNR_dB));

% Generate Binary Data
bits = randi([0 1],1,N);

% BPSK Modulation
symbols = 2*bits - 1;

for k = 1:length(SNR_dB)

    % Convert Eb/N0 to Linear Scale
    gamma = 10^(SNR_dB(k)/10);

    % AWGN Generation
    noise_power = sps/gamma;
    noise = sqrt(noise_power)*randn(1,N*sps);

    % Transmitted Signal
    tx = repelem(symbols,sps);

    % Received Signal
    rx = tx + noise;

    % Matched Filter
    rx_matrix = reshape(rx,sps,N);
    y = sum(rx_matrix,1);

    % ML Detection
    ml_bits = double(y > 0);

    % MAP Detection (Equal Priors)
    map_bits = double(y > 0);

    % BER Calculation
    ber_ml(k) = mean(bits ~= ml_bits);
    ber_map(k) = mean(bits ~= map_bits);

    % Theoretical BPSK BER
    ber_theory(k) = 0.5*erfc(sqrt(gamma));

end

% BER Plot
figure('Name','BER Performance Analysis');

semilogy(SNR_dB,ber_ml,'o-','LineWidth',1.5);
hold on;

semilogy(SNR_dB,ber_map,'s-','LineWidth',1.5);

semilogy(SNR_dB,ber_theory,'k--','LineWidth',1.5);

grid on;

xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate');

title('BER Performance of BPSK Detection');

legend('ML Detection','MAP Detection', ...
    'Theoretical BPSK BER','Location','southwest');

end