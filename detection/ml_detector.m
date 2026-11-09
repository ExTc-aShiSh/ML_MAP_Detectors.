function [detected_bits, threshold] = ml_detector(y)

% ML Decision Threshold
threshold = 0;

% Detection
detected_bits = double(y > threshold);

end