# Art Medium Classification – Phase 1 Dataset

## Git repo link: https://github.com/rekhadhorigol/ip-mini-project-art-medium.git

## Team: 
1) Rekha Dhorigol - PES1UG24CS370 
2) CH Yashwitha - PES1UG24CS121 
3) Salasha Vijay - PES1UG24CS689 
4) Fathima Zahra - PES1UG24CS664 

## 1. Project Overview

This project focuses on preparing an image dataset for an **Art Medium Classification** application. The objective is to organize and preprocess artwork images belonging to five different artistic mediums.

The dataset contains **125 images**, with 25 images in each category.

### Classes

* Oil
* Watercolour
* Ink
* Pastel
* Graphite/Pencil

**The dataset was manually collected from multiple institutional art collections. Each image is assigned to one of the five categories and documented using a metadata CSV file.**

## 2. Dataset Structure

The project directory is organized as follows:

```text
art_medium_dataset/
│
├── raw/
│   ├── oil/
│   ├── watercolour/
│   ├── ink/
│   ├── pastel/
│   └── graphite/
│
├── processed/
│   ├── oil/
│   ├── watercolour/
│   ├── ink/
│   ├── pastel/
│   └── graphite/
│
├── metadata/
│   └── dataset.csv
│
├── check_dataset.m
├── preprocess.m
├── README.md
├── Preprocessing_Documentation.pdf
├── show_preprocessing_steps.m
└── preprocessing_comparison.png
```

### Dataset Summary

| Category    | Number of Images |
| ----------- | ---------------: |
| Oil         |               25 |
| Watercolour |               25 |
| Ink         |               25 |
| Pastel      |               25 |
| Graphite    |               25 |
| **Total**   |          **125** |

## 3. Metadata Description

The `metadata/dataset.csv` file maintains information about the collected images.

| Column     | Description                                      |
| ---------- | ------------------------------------------------ |
| id         | Unique identifier for each image                 |
| filename   | Original image filename                          |
| category   | Art-medium category                              |
| source_url | Available source reference for the artwork/image |
| dimensions | Original image dimensions in pixels              |
| format     | Original image format                            |
| **collector**  | **Team member who collected the image**              |

**Note on source URLs:** The `source_url` field records the available source reference. Depending on the source website and how the image was collected, this may be an individual artwork page URL or a direct/API image URL. These references are retained as available in the collection process.

## 4. Dataset Validation

The MATLAB script `check_dataset.m` is used to validate the raw dataset before preprocessing.

It performs the following checks:

* Verifies the existence of all five category folders.
* Counts supported image files in each category.
* Checks whether images can be read successfully.
* Reports the minimum and maximum original image dimensions.
* Identifies missing, extra, or unreadable images.
* Displays a summary of the dataset.

The expected count is 25 images per category, giving a total of 125 images.

## 5. Image Preprocessing

The MATLAB script `preprocess.m` applies the following operations:

1. Conversion to a consistent three-channel RGB representation.
2. Pixel-value normalization to the range [0,1] during processing.
3. Aspect-ratio-preserving resizing using bicubic interpolation.
4. Center padding to obtain a uniform 256 × 256 image.
5. Conversion to 8-bit image format and saving as PNG.

The processed images are stored in the `processed/` directory, maintaining the same category-wise organization as the raw dataset.

Detailed explanations and justifications for these operations are provided in `Preprocessing_Documentation.pdf`.

## 6. Software Requirements

* MATLAB or MATLAB Online
* Image Processing Toolbox (for functions such as `imresize`)

## 7. How to Run

1. Open the `art_medium_dataset` folder in MATLAB or upload it to MATLAB Drive.
2. Set the current working directory to the main `art_medium_dataset` folder.
3. Run `check_dataset.m` to validate the raw dataset.
4. Run `preprocess.m` to generate the processed images.
5. Find the generated images inside the `processed/` directory.

Both scripts use relative folder paths, so they should be executed from the main dataset directory.

## 8. Dataset Limitations

The dataset was collected from multiple institutional art collections. However, the distribution of image sources is not uniform across all art-medium categories. Consequently, source-related visual characteristics may introduce dataset bias.

This limitation should be considered when interpreting future classification results, and source-diversified data should be incorporated in subsequent dataset expansion.

## 9. Future Work

Possible improvements and extensions include:

* Expanding the dataset with more images from diverse sources.
* Improving source diversity across all art-medium categories.
* Supporting indexed-colour images with appropriate colour-map handling if additional image formats are introduced.
* Exploring suitable image features and classification techniques in subsequent project phases.

---

**Project:** Art Medium Classification - IP Mini Project
**Phase:** Phase 1 – Dataset Collection, Validation & Preprocessing
**Dataset Size:** 125 images across 5 categories

*Author*
*Rekha Dhorigol*