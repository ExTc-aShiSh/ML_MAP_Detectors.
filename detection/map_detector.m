function [detected_bits, threshold] = map_detector(y, noise_power, P0, P1, sps)

% MAP Decision Threshold
threshold = (sps*noise_power/2)*log(P0/P1);

% Detection
detected_bits = double(y > threshold);

end