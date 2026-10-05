% Preprocessing for Art Medium Classification
% 1) Rekha Dhorigol - PES1UG24CS370
% 2) CH Yashwitha - PES1UG24CS121
% 3) Salasha Vijay - PES1UG24CS689
% 4) Fathima Zahra - PES1UG24CS664

% Operations:
% 1. Aspect-ratio-preserving resizing
% 2. Padding to a common image size
% 3. Pixel-value normalization
% 4. RGB colour preservation
% No feature extraction or machine learning is performed here.

clear;
clc;

%% SETTINGS

rawRoot = fullfile(pwd, 'raw');
processedRoot = fullfile(pwd, 'processed');

classes = {'oil', 'watercolour', 'ink', 'pastel', 'graphite'};

% Common output canvas
targetSize = [256 256];

% Supported image formats
extensions = {'.jpg', '.jpeg', '.png', '.bmp', '.tif', '.tiff'};

%% CHECK FOLDERS

if ~isfolder(rawRoot)
    error('RAW folder not found. Make sure preprocess.m is inside art_medium_dataset.');
end

% Create processed folder if it does not exist
if ~isfolder(processedRoot)
    mkdir(processedRoot);
end

fprintf('=============================================\n');
fprintf('       ART MEDIUM IMAGE PREPROCESSING\n');
fprintf('=============================================\n\n');

%% PROCESS EACH CLASS

for c = 1:length(classes)

    className = classes{c};

    inputFolder = fullfile(rawRoot, className);
    outputFolder = fullfile(processedRoot, className);

    fprintf('---------------------------------------------\n');
    fprintf('Processing: %s\n', upper(className));
    fprintf('---------------------------------------------\n');

    % If class folder does not exist, skip it
    if ~isfolder(inputFolder)
        fprintf('Folder not found. Skipping...\n\n');
        continue;
    end

    % Create output class folder
    if ~isfolder(outputFolder)
        mkdir(outputFolder);
    end

    % Get files
    allFiles = dir(inputFolder);

    imageFiles = [];

    for k = 1:length(allFiles)

        if allFiles(k).isdir
            continue;
        end

        [~, ~, ext] = fileparts(allFiles(k).name);
        ext = lower(ext);

        if ismember(ext, extensions)
            imageFiles = [imageFiles; allFiles(k)];
        end
    end

    fprintf('Images found: %d\n', length(imageFiles));

    %% PROCESS IMAGES

    for k = 1:length(imageFiles)

        inputPath = fullfile(inputFolder, imageFiles(k).name);

        try

            %% STEP 1: READ IMAGE

            img = imread(inputPath);

            %% STEP 2: ENSURE RGB

            % If image is grayscale, convert it to RGB.
            % This keeps a consistent 3-channel representation.

            if size(img, 3) == 1
                img = cat(3, img, img, img);
            end

            % If image somehow has more than 3 channels,
            % keep only the first three.
            if size(img, 3) > 3
                img = img(:, :, 1:3);
            end

            %% STEP 3: NORMALIZE PIXEL VALUES

            % Convert image from integer representation
            % (usually 0-255) to double precision [0,1].

            imgNormalized = im2double(img);

            %% STEP 4: ASPECT-RATIO-PRESERVING RESIZE

            [height, width, ~] = size(imgNormalized);

            targetHeight = targetSize(1);
            targetWidth = targetSize(2);

            scale = min(targetHeight / height, ...
                        targetWidth / width);

            newHeight = round(height * scale);
            newWidth = round(width * scale);

            resizedImg = imresize( ...
                imgNormalized, ...
                [newHeight newWidth], ...
                'bicubic');

            %% STEP 5: PAD TO 256 x 256

            paddedImg = ones(targetHeight, targetWidth, 3);

            % Calculate position for centered placement

            startRow = floor((targetHeight - newHeight) / 2) + 1;
            startCol = floor((targetWidth - newWidth) / 2) + 1;

            endRow = startRow + newHeight - 1;
            endCol = startCol + newWidth - 1;

            paddedImg(startRow:endRow, ...
                      startCol:endCol, :) = resizedImg;

            %% STEP 6: CONVERT FOR IMAGE STORAGE

            % Keep normalized representation during processing,
            % then convert to uint8 for standard image storage.

            outputImg = im2uint8(paddedImg);

            %% STEP 7: SAVE IMAGE

            [~, baseName, ~] = fileparts(imageFiles(k).name);

            outputPath = fullfile( ...
                outputFolder, ...
                [baseName '_processed.png']);

            imwrite(outputImg, outputPath);

        catch ME

            fprintf('ERROR processing: %s\n', ...
                imageFiles(k).name);

            fprintf('Reason: %s\n', ME.message);

        end
    end

    fprintf('Finished: %s\n\n', upper(className));

end

%% FINAL MESSAGE

fprintf('=============================================\n');
fprintf('           PREPROCESSING COMPLETE\n');
fprintf('=============================================\n');

fprintf('\nOutput size: %d x %d pixels\n', ...
    targetSize(1), targetSize(2));

fprintf('Output format: PNG\n');
fprintf('Color representation: RGB\n');
fprintf('Interpolation: Bicubic\n');
fprintf('Aspect ratio: Preserved\n');
fprintf('Pixel normalization: [0,1] during processing\n');

fprintf('\nProcessed images are stored in:\n');
fprintf('%s\n', processedRoot);

fprintf('\n=============================================\n');