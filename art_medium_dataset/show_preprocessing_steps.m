%% Visualize preprocessing stages for one sample image
% 1) Rekha Dhorigol - PES1UG24CS370
% 2) CH Yashwitha - PES1UG24CS121
% 3) Salasha Vijay - PES1UG24CS689
% 4) Fathima Zahra - PES1UG24CS664

clear;
clc;
close all;

% Select one sample image
sampleFolder = fullfile(pwd, 'raw', 'oil');
files = dir(fullfile(sampleFolder, '*.jpg'));

if isempty(files)
    error('No JPG images found in the selected folder.');
end

inputPath = fullfile(sampleFolder, files(1).name);

% Read original image
original = imread(inputPath);

% Convert to RGB if grayscale
if size(original, 3) == 1
    original = cat(3, original, original, original);
end

if size(original, 3) > 3
    original = original(:, :, 1:3);
end

% Normalize
normalized = im2double(original);

% Aspect-ratio-preserving resize
targetSize = [256 256];

[h, w, ~] = size(normalized);

scale = min(targetSize(1)/h, targetSize(2)/w);

newHeight = round(h * scale);
newWidth = round(w * scale);

resized = imresize(normalized, ...
    [newHeight newWidth], 'bicubic');

% Center padding
padded = ones(256, 256, 3);

startRow = floor((256-newHeight)/2) + 1;
startCol = floor((256-newWidth)/2) + 1;

endRow = startRow + newHeight - 1;
endCol = startCol + newWidth - 1;

padded(startRow:endRow, startCol:endCol, :) = resized;

% Display all stages
figure('Name', 'Preprocessing Comparison', ...
    'Position', [100 100 1100 700]);

subplot(2,2,1);
imshow(original);
title('1. Original Image');

subplot(2,2,2);
imshow(resized);
title('2. Aspect-Ratio-Preserving Resize');

subplot(2,2,3);
imshow(padded);
title('3. Final 256 x 256 Padded Image');

subplot(2,2,4);
imshow(normalized);
title('4. Normalized Representation [0,1]');

sgtitle('Art Medium Image Preprocessing');

% Save the comparison figure
exportgraphics(gcf, 'preprocessing_comparison.png');

% Display normalization information
fprintf('Original data type: %s\n', class(original));
fprintf('Normalized data type: %s\n', class(normalized));
fprintf('Normalized minimum: %.4f\n', min(normalized(:)));
fprintf('Normalized maximum: %.4f\n', max(normalized(:)));

fprintf('\nResized dimensions: %d x %d\n', ...
    newHeight, newWidth);

fprintf('Final dimensions: %d x %d\n', ...
    size(padded,1), size(padded,2));