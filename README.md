# Art Medium Classification

## Image Processing Mini Project

An image-processing and classification project that investigates the automatic identification of artistic mediums from artwork images using classical image-processing techniques, machine learning, and deep learning.

---

## 1. Project Overview

Different artistic mediums exhibit distinct visual characteristics, including colour distribution, texture, strokes, edges, shading, and intensity patterns.

This project investigates whether these visual characteristics can be used to automatically classify an artwork into one of five artistic-medium categories.

### Problem Statement

Given an image of an artwork, determine the most likely artistic medium used to create it.

### Objectives

- Collect and organize a real-world artwork image dataset.
- Validate and preprocess the collected images.
- Extract visual features using classical image-processing techniques.
- Perform classification using machine-learning approaches.
- Implement deep-learning-based image classifiers.
- Compare the performance of different methods.
- Analyse experimental results and limitations.

---

## 2. Art Medium Classes

The dataset contains five categories:

1. Oil
2. Watercolour
3. Ink
4. Pastel
5. Graphite / Pencil

**Dataset size: 125 images — 25 images per category.**

| Art Medium | Number of Images |
|---|---:|
| Oil | 25 |
| Watercolour | 25 |
| Ink | 25 |
| Pastel | 25 |
| Graphite / Pencil | 25 |
| **Total** | **125** |

The images were manually collected from publicly available institutional art collections. Image source information and collection metadata are maintained in `art_medium_dataset/metadata/dataset.csv`.

---

# Project Structure

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
│   ├── preprocess.m
│   ├── show_preprocessing_steps.m
│   ├── Preprocessing_Documentation.pdf
│   ├── preprocessing_comparison.png
│   └── README.md
│
├── notebooks/
│   ├── Art_Medium_Classification_Classical_ML.ipynb
|   └── Art_Medium_Classification_Deep_Learning.ipynb
|
├── results/
|   ├── classical_ml_model_comparison.csv
│   ├── classification_reports.txt
│   ├── model_comparison.csv
│   ├── training_history.csv
│   └── graphs/
|         ├── model_accuracy_comparison.png
│         ├── mvit_confusion_matrix.png
│         ├── mvit_v2_s_training_curves.png
│         ├── resnet_confusion_matrix.png
│         └── resnet18_training_curves.png
│
├── README.md
├── Project_Report.pdf
└── .gitignore
```

The notebook and results filenames shown above are the recommended organization. Adjust them to match the actual filenames in the repository.

---

# 4. Phase 1 – Dataset Collection and Preprocessing

## 4.1 Dataset Collection

A dataset of 125 artwork images was manually collected from publicly available institutional art collections.

The sources include:

- The Metropolitan Museum of Art
- National Gallery of Art
- Art Institute of Chicago
- Cleveland Museum of Art

The dataset contains 25 images in each of the five categories.

The metadata file records the image identifier, filename, category, source reference, original dimensions, format, and collector.

## 4.2 Dataset Validation

The MATLAB script `check_dataset.m` was used to validate the raw dataset.

The validation process checks:

- Existence of all five category folders.
- Number of images in each category.
- Image readability.
- Original image dimensions.
- Missing, extra, or unreadable images.

**Validation result: 125 out of 125 images successfully validated.**

## 4.3 Image Preprocessing

The images were preprocessed using MATLAB.

The preprocessing pipeline includes:

1. Conversion to a consistent three-channel RGB representation.
2. Pixel-value normalization to the range `[0,1]` during processing.
3. Aspect-ratio-preserving resizing.
4. Bicubic interpolation.
5. Center padding to obtain a uniform image size.
6. Conversion to 8-bit PNG format.

### Final Image Specification

| Property | Value |
|---|---|
| Image dimensions | 256 × 256 pixels |
| Colour representation | RGB |
| Pixel normalization | `[0,1]` during processing |
| Interpolation | Bicubic |
| Aspect ratio | Preserved |
| Output format | PNG |

Grayscale conversion and aggressive image enhancement operations were avoided to preserve potentially useful colour, texture, and stroke information.

Detailed preprocessing steps and examples are available in `art_medium_dataset/Preprocessing_Documentation.pdf`.

---

# 5. Phase 2 – Classical Image Processing and Machine Learning

The preprocessed dataset was used to investigate two classical feature-extraction techniques:

- Harris Corner Detection
- SIFT (Scale-Invariant Feature Transform)

The extracted features were evaluated using:

- Support Vector Machine (SVM)
- Cosine Similarity

## 5.1 Experimental Dataset Split

The classical ML experiment used:

| Dataset Split | Number of Images |
|---|---:|
| Training | 100 |
| Testing | 25 |
| **Total** | **125** |

Each category contributed five images to the test set.

## 5.2 Harris Corner Detection

Harris Corner Detection identifies image regions with significant intensity changes in multiple directions.

For this experiment, Harris-based features were represented using a fixed-length feature vector containing 52 features.

The extracted features were evaluated using SVM and Cosine Similarity.

## 5.3 SIFT Feature Extraction

SIFT detects distinctive local keypoints and generates descriptors representing local visual patterns.

For this experiment, the extracted SIFT descriptors were converted into fixed-length feature vectors using a 50-word Bag of Visual Words (BoVW) representation.

The visual vocabulary was created using training-set descriptors.

The resulting feature vectors were evaluated using SVM and Cosine Similarity.

## 5.4 Classical ML Results

| Feature Extraction | Classification Method | Accuracy |
|---|---|---:|
| Harris Corner | SVM | 24.0% |
| Harris Corner | Cosine Similarity | 20.0% |
| SIFT | SVM | **52.0%** |
| SIFT | Cosine Similarity | 48.0% |

### Best Classical ML Approach

**SIFT + SVM achieved the highest classical ML accuracy of 52.0%.**

SIFT performed better than Harris Corner Detection for the current dataset, suggesting that its local visual descriptors provided a more useful representation for this classification task.

The complete classification report and evaluation outputs are available in the classical ML notebook.

---

# 6. Deep Learning-Based Image Classification

Deep learning was implemented using PyTorch and Torchvision.

Two pretrained architectures were evaluated:

- ResNet-18
- MViT V2-S

The final classification layers were adapted for the five art-medium categories.

## 6.1 Dataset Split

The deep-learning experiment used a stratified dataset split:

| Dataset Split | Number of Images |
|---|---:|
| Training | 87 |
| Validation | 19 |
| Testing | 19 |
| **Total** | **125** |

Both models were evaluated using the same training, validation, and test partitions.

## 6.2 ResNet-18

ResNet-18 is a convolutional neural network based on residual learning.

A pretrained ResNet-18 model was adapted for five-class artwork classification by replacing its final classification layer.

The pretrained backbone was frozen, and the new classification layer was trained for the target classes.

## 6.3 MViT V2-S

MViT V2-S is a multiscale vision transformer architecture.

A pretrained MViT V2-S model was adapted for the same five-class classification task by replacing its final classification layer.

The pretrained backbone was frozen, and the new classification layer was trained.

A smaller batch size was used for MViT to accommodate its greater GPU memory requirements in the experimental setup.

## 6.4 Softmax Classification

The models produce class scores, also known as logits.

The Softmax function converts these scores into class probabilities:

\[
P(y_i)=\frac{e^{z_i}}{\sum_j e^{z_j}}
\]

The class with the highest predicted probability is selected as the predicted art medium.

Cross-entropy loss was used during training with the raw logits.

## 6.5 Deep Learning Results

| Model | Test Accuracy |
|---|---:|
| ResNet-18 | **52.63%** |
| MViT V2-S | 47.37% |

### Best Deep Learning Model

**ResNet-18 achieved the highest deep-learning test accuracy of 52.63%.**

Although MViT V2-S is a more complex architecture, ResNet-18 performed slightly better in this experiment.

The difference corresponds to one correctly classified image out of the 19 test images.

This result is specific to the current dataset and experimental setup and does not establish that ResNet-18 is generally superior to MViT.

---

# 7. Overall Performance Comparison

| Approach | Method | Accuracy |
|---|---|---:|
| Classical ML | Harris + SVM | 24.0% |
| Classical ML | Harris + Cosine Similarity | 20.0% |
| Classical ML | SIFT + SVM | **52.0%** |
| Classical ML | SIFT + Cosine Similarity | 48.0% |
| Deep Learning | ResNet-18 | **52.63%** |
| Deep Learning | MViT V2-S | 47.37% |

The best classical ML approach was SIFT + SVM, with 52.0% accuracy.

The best deep-learning model was ResNet-18, with 52.63% test accuracy.

The two best-performing approaches produced very similar results on their respective test sets. Since the classical and deep-learning experiments used different train/test splits, their accuracies should not be treated as a direct controlled comparison.

---

# 8. Limitations

The project has several limitations:

- The dataset contains only 125 images.
- Each category contains only 25 images.
- The number of training and testing samples is limited.
- Artistic styles, subjects, and compositions vary considerably.
- Some art mediums may have visually similar characteristics.
- The distribution of image sources is not uniform across all classes, potentially introducing source-related dataset bias.
- Deep-learning results may vary with dataset split, training configuration, and model initialization.

The deep-learning test set contains only 19 images, so each correctly classified image changes the reported accuracy by approximately 5.26 percentage points.

The results should therefore be interpreted within the context of this particular experiment.

---

# 9. Future Work

Possible future improvements include:

- Expanding the dataset with more artwork images.
- Increasing source diversity across all classes.
- Collecting more varied artistic styles and compositions.
- Investigating additional feature-extraction methods.
- Exploring further deep-learning architectures.
- Fine-tuning pretrained models.
- Performing systematic hyperparameter tuning.
- Evaluating the models on larger and more diverse test sets.

---

# 10. Tools and Technologies

### Image Processing
- MATLAB
- MATLAB Image Processing Toolbox

### Classical Machine Learning
- Python
- OpenCV
- Scikit-learn
- NumPy
- Pandas
- Google Colab

### Deep Learning
- Python
- PyTorch
- Torchvision
- CUDA
- Google Colab

### Version Control
- Git
- GitHub

---

# 11. Team

1. Rekha Dhorigol – PES1UG24CS370
2. CH Yashwitha – PES1UG24CS121
3. Salasha Vijay – PES1UG24CS689
4. Fathima Zahra – PES1UG24CS664

---

## Note

This repository represents an academic Image Processing mini project. The dataset and experiments are intended for educational and experimental purposes. The reported performance is specific to the collected dataset and the experimental configurations described above.
