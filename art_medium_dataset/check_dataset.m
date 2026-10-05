% Dataset validation for Art Medium Classification - This script checks the raw dataset without modifying any images.
% 1) Rekha Dhorigol - PES1UG24CS370
% 2) CH Yashwitha - PES1UG24CS121
% 3) Salasha Vijay - PES1UG24CS689
% 4) Fathima Zahra - PES1UG24CS664


clear;
clc;

%% SETTINGS

% Raw dataset folder
rawRoot = fullfile(pwd, 'raw');

% Expected classes
classes = {'oil', 'watercolour', 'ink', 'pastel', 'graphite'};

% Expected number of images per class
expectedPerClass = 25;

% Supported image formats
extensions = {'.jpg', '.jpeg', '.png', '.bmp', '.tif', '.tiff'};

%% CHECK RAW FOLDER

fprintf('=============================================\n');
fprintf('   ART MEDIUM DATASET VALIDATION\n');
fprintf('=============================================\n\n');

if ~isfolder(rawRoot)
    error(['RAW folder not found.\n' ...
           'Make sure this script is inside art_medium_dataset/']);
end

fprintf('Dataset location:\n%s\n\n', rawRoot);

%% INITIALIZE RESULTS

classNames = strings(0);
imageCounts = [];
minWidths = [];
maxWidths = [];
minHeights = [];
maxHeights = [];
badImages = {};

%% CHECK EACH CLASS

for c = 1:length(classes)

    className = classes{c};
    classPath = fullfile(rawRoot, className);

    fprintf('---------------------------------------------\n');
    fprintf('Checking class: %s\n', upper(className));
    fprintf('---------------------------------------------\n');

    % Check whether class folder exists
    if ~isfolder(classPath)
        fprintf('WARNING: Folder does not exist!\n\n');

        classNames(end+1) = string(className);
        imageCounts(end+1) = 0;
        minWidths(end+1) = NaN;
        maxWidths(end+1) = NaN;
        minHeights(end+1) = NaN;
        maxHeights(end+1) = NaN;

        continue;
    end

    % Find files in class folder
    allFiles = dir(classPath);

    validFiles = [];

    for k = 1:length(allFiles)

        if allFiles(k).isdir
            continue;
        end

        [~, ~, ext] = fileparts(allFiles(k).name);
        ext = lower(ext);

        if ismember(ext, extensions)
            validFiles = [validFiles; allFiles(k)];
        end
    end

    count = length(validFiles);

    fprintf('Number of images: %d\n', count);

    % Check count
    if count == expectedPerClass
        fprintf('Count status: OK (25 images)\n');
    elseif count < expectedPerClass
        fprintf('Count status: INCOMPLETE (need %d more)\n', ...
            expectedPerClass - count);
    else
        fprintf('Count status: EXTRA (%d more than required)\n', ...
            count - expectedPerClass);
    end

    %% Check image dimensions

    widths = [];
    heights = [];

    for k = 1:count

        filePath = fullfile(classPath, validFiles(k).name);

        try
            img = imread(filePath);

            [h, w, ~] = size(img);

            widths(end+1) = w;
            heights(end+1) = h;

        catch
            fprintf('WARNING: Cannot read image: %s\n', ...
                validFiles(k).name);

            badImages{end+1} = filePath;
        end
    end

    % Store statistics
    classNames(end+1) = string(className);
    imageCounts(end+1) = count;

    if ~isempty(widths)
        minWidths(end+1) = min(widths);
        maxWidths(end+1) = max(widths);
        minHeights(end+1) = min(heights);
        maxHeights(end+1) = max(heights);

        fprintf('Width range : %d - %d pixels\n', ...
            min(widths), max(widths));

        fprintf('Height range: %d - %d pixels\n', ...
            min(heights), max(heights));
    else
        minWidths(end+1) = NaN;
        maxWidths(end+1) = NaN;
        minHeights(end+1) = NaN;
        maxHeights(end+1) = NaN;
    end

    fprintf('\n');
end

%% SUMMARY TABLE

fprintf('\n=============================================\n');
fprintf('              DATASET SUMMARY\n');
fprintf('=============================================\n\n');

summaryTable = table( ...
    classNames', ...
    imageCounts', ...
    minWidths', ...
    maxWidths', ...
    minHeights', ...
    maxHeights', ...
    'VariableNames', { ...
    'Class', ...
    'ImageCount', ...
    'MinWidth', ...
    'MaxWidth', ...
    'MinHeight', ...
    'MaxHeight'});

disp(summaryTable);

%% TOTAL COUNT

totalImages = sum(imageCounts);

fprintf('Total images: %d\n', totalImages);
fprintf('Expected images: %d\n\n', expectedPerClass * length(classes));

%% BAD IMAGE REPORT

if isempty(badImages)

    fprintf('Unreadable/corrupt images: NONE\n');

else

    fprintf('Unreadable/corrupt images: %d\n', length(badImages));

    fprintf('\nProblematic files:\n');

    for k = 1:length(badImages)
        fprintf('%s\n', badImages{k});
    end
end

%% FINAL STATUS

allCountsCorrect = all(imageCounts == expectedPerClass);
noBadImages = isempty(badImages);

fprintf('\n=============================================\n');
fprintf('              FINAL STATUS\n');
fprintf('=============================================\n');

if allCountsCorrect && noBadImages

    fprintf('DATASET CHECK: COMPLETE AND VALID\n');
    fprintf('All 5 classes contain exactly 25 readable images.\n');

elseif allCountsCorrect && ~noBadImages

    fprintf('DATASET CHECK: REVIEW REQUIRED\n');
    fprintf('Image counts are correct, but some images cannot be read.\n');

else

    fprintf('DATASET CHECK: INCOMPLETE\n');
    fprintf('Some classes do not contain exactly 25 images yet.\n');

end

fprintf('=============================================\n');