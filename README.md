# Art Medium Classification

## Mini Project – Image Processing

A real-world image-processing project for classifying artworks based on their visual medium, such as oil, watercolour, ink, pastel, and graphite.

---

## Project Overview

Different artistic mediums produce distinct visual characteristics such as colour distribution, texture, strokes, shading, and intensity patterns. This project aims to investigate whether image-processing and machine-learning techniques can be used to automatically identify the medium used in an artwork.

The project is being developed in multiple phases, beginning with dataset collection and preprocessing, followed by image analysis and classification.

### Problem Statement

Given an image of an artwork, determine the most likely artistic medium used to create it.

### Objective

The main objectives of the project are to:

* Build a categorized dataset of artwork images.
* Apply appropriate image-processing techniques to prepare the dataset.
* Extract meaningful visual characteristics from the images.
* Develop and evaluate a classification approach for identifying the art medium.
* Analyze the effectiveness and limitations of the developed approach.

---

## Art Medium Classes

The current dataset contains five classes:

1. **Oil**
2. **Watercolour**
3. **Ink**
4. **Pastel**
5. **Graphite / Pencil**

The current dataset contains **125 images**, with **25 images per class**.

---

## Project Structure

```text
ip-mini-project-art-medium/
│
├── art_medium_dataset/
│   ├── raw/
│   │   ├── oil/
│   │   ├── watercolour/
│   │   ├── ink/
│   │   ├── pastel/
│   │   └── graphite/
│   │
│   ├── processed/
│   │   ├── oil/
│   │   ├── watercolour/
│   │   ├── ink/
│   │   ├── pastel/
│   │   └── graphite/
│   │
│   ├── metadata/
│   │   └── dataset.csv
│   │
│   ├── check_dataset.m
|   ├── preprocess.m
|   ├── README.md
|   ├── Preprocessing_Documentation.pdf
|   ├── show_preprocessing_steps.m
|   └── preprocessing_comparison.png
│
└── README.md
```

The `art_medium_dataset` directory contains the dataset, metadata, preprocessing scripts, and Phase 1 documentation.

---

# Phase 1 – Dataset Collection and Preprocessing

## Dataset Collection

A dataset of **125 artwork images** was manually collected from publicly available institutional art collections.

The dataset was designed to contain:

* 25 Oil images
* 25 Watercolour images
* 25 Ink images
* 25 Pastel images
* 25 Graphite/Pencil images

Sources include established art institutions such as:

* The Metropolitan Museum of Art
* National Gallery of Art
* Art Institute of Chicago
* Cleveland Museum of Art

The source information for each image is recorded in `metadata/dataset.csv`.

### Dataset Metadata

The metadata file contains:

| Field        | Description                         |
| ------------ | ----------------------------------- |
| `id`         | Unique image identifier             |
| `filename`   | Image filename                      |
| `category`   | Art-medium class                    |
| `source_url` | Source reference for the image      |
| `dimensions` | Original image dimensions           |
| `format`     | Image file format                   |
| `collector`  | Team member who collected the image |

> The `source_url` field records the available source reference. Depending on the source website and how the image was collected, this may be an individual artwork page URL or a direct/API image URL.

---

## Dataset Validation

The raw dataset was validated using `check_dataset.m`.

The validation checks:

* Number of images in each class
* Supported image formats
* Image readability
* Image dimensions
* Missing class folders
* Overall dataset completeness

### Validation Result

**125 / 125 images were successfully validated.**

Each of the five classes contains exactly 25 readable images.

---

## Preprocessing

The images were preprocessed using MATLAB.

The final preprocessing pipeline consists of:

1. RGB representation preservation
2. Pixel-value normalization
3. Aspect-ratio-preserving resizing
4. Center padding to a common image size

### Final Image Specification

| Property               | Value                    |
| ---------------------- | ------------------------ |
| Image size             | 256 × 256 pixels         |
| Colour representation  | RGB                      |
| Pixel normalization    | [0, 1] during processing |
| Resizing interpolation | Bicubic                  |
| Aspect ratio           | Preserved                |
| Output format          | PNG                      |

### Why these techniques were selected

The preprocessing was designed to standardize the dataset while preserving visual characteristics that may be useful for distinguishing artistic mediums.

Grayscale conversion was not used because colour may provide important information for differentiating certain art mediums.

Aggressive noise removal, histogram equalization, sharpening, and contrast enhancement were also avoided because they may modify or remove useful texture, stroke, and colour characteristics present in the original artwork.

Cropping and arbitrary geometric transformations were not applied because they could remove important visual regions or alter the original composition.

The complete preprocessing procedure and visual examples are documented in `Preprocessing_Documentation.pdf`.

---

## Dataset Limitation

The dataset was collected from multiple institutional art collections. However, the distribution of image sources is not uniform across all art-medium categories. Consequently, source-related visual characteristics may introduce dataset bias.

This limitation should be considered when interpreting future classification results, and source-diversified data should be incorporated in subsequent dataset expansion.

---

# Phase 2 – Image Analysis and Classification

Phase 2 will build upon the preprocessed dataset created during Phase 1.

The planned workflow includes:

```text
Preprocessed Images
        ↓
Feature Extraction / Image Analysis
        ↓
Feature Representation
        ↓
Classification
        ↓
Performance Evaluation
```

The specific image-processing, feature-extraction, and classification techniques will be selected based on their suitability for distinguishing the visual characteristics of the five art-medium classes.

The classification performance will be evaluated using appropriate metrics and visualizations.

---

## Tools and Technologies

* **MATLAB**
* Image Processing Toolbox
* Git / GitHub

---

## Team

This project is developed as a team-based mini project.

**Team Members:**

1) Rekha Dhorigol - PES1UG24CS370 
2) CH Yashwitha - PES1UG24CS121 
3) Salasha Vijay - PES1UG24CS689 
4) Fathima Zahra - PES1UG24CS664 

---

## Current Status

| Phase                               | Status      |
| ----------------------------------- | ----------- |
| Application selection               | ✅ Completed |
| Dataset collection                  | ✅ Completed |
| Dataset organization                | ✅ Completed |
| Dataset validation                  | ✅ Completed |
| Image preprocessing                 | ✅ Completed |
| Phase 1 documentation               | ✅ Completed |
| Feature extraction / image analysis | 🔄 Phase 2  |
| Classification                      | 🔄 Phase 2  |
| Performance evaluation              | 🔄 Phase 2  |

---

## Future Work

Future stages of the project will focus on:

* Extracting meaningful visual features from artwork images.
* Investigating suitable classification techniques.
* Comparing classification performance across approaches.
* Evaluating the effect of different visual features on art-medium recognition.
* Expanding the dataset with greater source diversity.
* Improving robustness against variations in artwork style, composition, and image acquisition conditions.

---

## Phase 1 Deliverables

The `art_medium_dataset` directory contains the materials submitted for Phase 1:

* Raw dataset
* Preprocessed dataset
* Dataset metadata
* Dataset validation MATLAB script
* Preprocessing MATLAB script
* Preprocessing documentation
* Phase 1 dataset README

---

## Note

This repository represents an academic mini-project. The dataset and methods are intended for educational and experimental purposes. Classification performance in later phases may be affected by dataset size, class characteristics, source bias and variations in artwork style and image acquisition.

*Author*
*Rekha Dhorigol*