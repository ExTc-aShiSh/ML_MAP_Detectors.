clc;
clear;
close all;

%% Simulation Parameters
N = 1000;          % Number of bits
SNR_dB = 20;        % Channel SNR in dB
sps = 100;          % Samples per symbol

%% Transmitter
[bits, symbols, tx_signal, t] = transmitter(N);


%% AWGN Channel
[rx_signal, noise] = awgn_channel(tx_signal, SNR_dB);

% Calculate Noise Power
noise_power = mean(noise.^2);

%% Receiver Modules

% Matched Filter
[mf_output, mf_samples] = matched_filter(rx_signal, N, sps);

% Correlator
corr_samples = correlator(rx_signal, N, sps);

%% ML Detection

[ml_bits, ml_threshold] = ml_detector(mf_samples);

%% MAP Detection

% Prior Probabilities
P0 = 0.95;
P1 = 0.05;

[map_bits, map_threshold] = map_detector(mf_samples, ...
    noise_power, P0, P1, sps);

%% BER Calculation

ber_ml = mean(bits ~= ml_bits);
ber_map = mean(bits ~= map_bits);

%% Display Results

fprintf('\n------ RECEIVER PERFORMANCE ------\n');

fprintf('Channel SNR       : %d dB\n', SNR_dB);
fprintf('ML Threshold     : %.4f\n', ml_threshold);
fprintf('MAP Threshold    : %.4f\n', map_threshold);

fprintf('ML BER           : %.6f\n', ber_ml);
fprintf('MAP BER          : %.6f\n', ber_map);

%% ML vs MAP Visualization

visualize_detection(sps, noise_power, P0, P1);

%% BER Performance Analysis

ber_analysis();