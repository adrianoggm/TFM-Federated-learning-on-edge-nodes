# Bibliography

This bibliography compiles the articles reviewed on Internet of Things in Healthcare, with a focus on system sensor architectures and security considerations.

---

## Reviewed Literature

We considered literature reviews from **2020–2025** (5 years) and datasets from **2010 to the present**.

### References

1. **Overview of IoT Health Systems:**  
   Literature review covering different sensors, architectures, and security concerns in IoT-based healthcare systems.

2. **Wearable Devices for Stress Detection:**  
   Reviews the use of wearables to detect and monitor stress, highlighting five key stages:  
   - Physiological data collection (controlled and real-world settings)  
   - Preprocessing (signal filtering and normalization)  
   - Feature extraction (e.g., HRV statistics, tonic/phasic EDA features)  
   - Machine learning model training (traditional classifiers and deep learning)  
   - Performance evaluation  
   Addresses challenges such as personalization, real-time detection, and the integration of privacy and usability in real-world applications.

3. **Systematic Review of Mental Stress Recognition:**  
   Synthesizes state-of-the-art methods for mental-stress recognition using data fusion of wearable sensor signals and machine learning.  
   - Defines seven research questions (fusion strategies, classifier choices, sensor modalities, temporal segmentation, evaluation metrics, classifier performance)  
   - After screening 163 Scopus results (49 included studies), reports prevailing practices: feature-level fusion, widely used classifiers (SVM, Random Forest, KNN), ECG/EEG sensors, overlapping and uniform time windows  
   - Summarizes typical model accuracies and future research directions.

4. **Large-Scale Office Worker Study:**  
   Created a dataset by monitoring 1,002 healthy office workers continuously for five days to capture natural variations.  
   - See [datasets](./datasets.md) for more info.  
   - *Note:* The dataset is not publicly available due to privacy concerns; data can be requested from the corresponding author.

5. **WESAD Public Dataset:**  
   WESAD is a public dataset including physiological and motion signals collected simultaneously from chest and wrist, along with self-reported emotional states (neutral, induced stress, and amusement).  
   - Designed as a benchmark for developing and comparing wearable-based stress and affect detection algorithms.
   
6. **SWELL-KW HRV Analysis:** Explores heart rate variability features from the SWELL-KW dataset, performs exploratory data analysis and mRMR-based feature selection, and employs a Random Forest model to classify stress conditions—achieving 100 % accuracy and highlighting potential overfitting.

7. **Eight-Feature Global Stress Detector:** Introduces a global Random Forest framework using eight selected HRV metrics, validated on SWELL (25 subjects) and WESAD (15 subjects), with ≥ 99 % accuracy and F1 on each dataset and 99.5 % average accuracy across the combined 37-subject cohort.

8. **Wearable AI for Stress Detection in Students:**  
   - **Context:** Chronic academic stress harms student health and performance; traditional questionnaires and lab tests are limited. Wearable AI offers continuous, objective monitoring of biomarkers (heart rate, HRV, EDA).  
   - **Objective:** Systematically review and meta-analyze how well wearable-based AI algorithms detect and predict stress in students.  
   - **Methods:** Searched 7 databases (MEDLINE, Embase, PsycINFO, ACM DL, Scopus, IEEE Xplore, Google Scholar) through June 12, 2023; included 19 studies; adapted QUADAS-2 for bias assessment; conducted narrative synthesis plus a DerSimonian-Laird random-effects meta-analysis on 37 accuracy estimates from 6 studies (I² = 98.8%); performed subgroup analyses by number of stress classes, device type/location, dataset size, and ground truth method.  
   - **Results:** Pooled accuracy = 0.856 (95% CI 0.70–0.93); sensitivity = 0.755 (SD 0.181); specificity = 0.744 (SD 0.147); F1-score = 0.759 (SD 0.139). Significant moderators: more than two stress levels > binary; electrodes > smartwatches > smart bands; non-wrist sensors > wrist; smaller datasets (≤100) > larger; objective ground truth > self-reports.  
   - **Limitations:**High heterogeneity and risk of overfitting (few studies in meta-analysis, small sample sizes) warrant caution despite >85% accuracy.Study populations were almost entirely undergraduates, with very few postgraduates and virtually no high-school students. Only 42% of studies managed the “Analysis” domain rigorously (proper train/test splits, preprocessing, complete reporting), indicating potential bias.
   - **Conclusions:** Wearable AI shows promise but is currently suboptimal for standalone use; should complement questionnaires. Future research should address predictive modeling, distinguish stress types and other disorders, include diverse student populations, optimize sensor placement and ground truth standards, and report detailed metrics for meta-analyses.

---
```bibtex
@article{Rehman2025IoTHealth,
  author  = {Rehman, Attiq Ur and Lu, Songfeng and Bin Heyat, Md Belal and Iqbal, Muhammad Shahid and Parveen, Saba and Bin Hayat, Mohd Ammar and Akhtar, Faijan and Ashraf, Muhammad Awais and Khan, Owais and Pomary, Dustin and Sawan, Mohamad},
  title   = {Internet of Things in Healthcare Research: Trends, Innovations, Security Considerations, Challenges and Future Strategy},
  journal = {International Journal of Intelligent Systems},
  volume  = {2025},
  number  = {1},
  pages   = {Article ID 8546245},
  year    = {2025},
  doi     = {10.1155/INT/8546245}
}

@article{Pinge2024StressWearables,
  author  = {Pinge, et al.},
  title   = {Detection and Monitoring of Stress Using Wearables: A Systematic Review},
  journal = {Frontiers in Computer Science},
  year    = {2024},
  doi     = {10.3389/fcomp.2024.1478851},
  abstract = {This systematic review compiles research from the last decade on the use of wearables to detect stress. It summarizes sensor types (e.g., heart rate and heart rate variability via ECG/PPG, skin conductance via EDA, skin temperature, accelerometry, etc.) and describes common methodological stages: continuous physiological data collection, preprocessing (e.g., signal filtering), feature extraction (e.g., HRV statistics, tonic/phasic EDA features), and machine learning model training. The review covers both laboratory and real-world studies, discussing algorithms used, performance, and future opportunities (e.g., improving personalization and early intervention upon stress detection).}
}

@article{Chacon2025StressRecognition,
  author  = {Chacon, P. C. and Aguileta, A. and Moo, F. and Aguilar, R.},
  title   = {Systematic literature review of mental stress recognition using wearable sensor data fusion},
  journal = {International Journal of Combinatorial Optimization Problems and Informatics},
  volume  = {16},
  number  = {2},
  pages   = {98},
  year    = {2025},
  url     = {https://search.proquest.com/openview/b8203ad65e877201e27ba0f18906bd9c/1?pq-origsite=gscholar&cbl=696410}
}

@article{Smets2018DigitalPhenotypes,
  author  = {Smets, E. and Rios Velazquez, E. and Schiavone, G. and Chakroun, I. and D’Hondt, E. and De Raedt, W. and Van Hoof, C.},
  title   = {Large-scale wearable data reveal digital phenotypes for daily-life stress detection},
  journal = {NPJ Digital Medicine},
  volume  = {1},
  number  = {1},
  pages   = {67},
  year    = {2018},
  url     = {https://scholar.google.es/scholar?output=instlink&q=info:0J63vcjZMsYJ:scholar.google.com/&hl=es&as_sdt=0,5&scillfp=13313851419359735860&oi=lle}
}

@inproceedings{schmidt2018wesad,
  author       = {Schmidt, Philipp and Reiss, Anton and Duerichen, Roland and Marberger, Christopher and Van Laerhoven, Kristof},
  title        = {Introducing WESAD, a Multimodal Dataset for Wearable Stress and Affect Detection},
  booktitle    = {Proceedings of the 20th ACM International Conference on Multimodal Interaction},
  pages        = {400--408},
  year         = {2018},
  doi          = {10.1145/3242969.3242985},
  url          = {https://doi.org/10.1145/3242969.3242985}
}

@misc{pj2021swell,
  author       = {PJ, S.},
  title        = {Swell dataset analysis for stress prediction},
  year         = {2021},
  howpublished = {Kaggle Notebook},
  url          = {https://www.kaggle.com/code/shreyaspj/swell-dataset-analysis-for-stress-prediction}
}

@article{dahal2023global,
  author       = {Dahal, Kailash and Bogue-Jimenez, Bruno and Doblas, Ana},
  title        = {Global Stress Detection Framework Combining a Reduced Set of HRV Features and Random Forest Model},
  journal      = {Sensors},
  volume       = {23},
  number       = {11},
  pages        = {5220},
  year         = {2023},
  publisher    = {MDPI},
  doi          = {10.3390/s23115220},
  url          = {https://www.mdpi.com/1424-8220/23/11/5220}
}

@article{abd2024wearable,
  author       = {Abd-Alrazaq, Abdullah and Alajlani, Malak and Ahmad, Raed and AlSaad, Rawan and Aziz, Shaikha and Ahmed, Aisha and Sheikh, Javaid},
  title        = {The Performance of Wearable AI in Detecting Stress Among Students: Systematic Review and Meta-Analysis},
  journal      = {Journal of Medical Internet Research},
  volume       = {26},
  pages        = {e52622},
  year         = {2024},
  doi          = {10.2196/52622},
  url          = {https://doi.org/10.2196/52622}
}

```





## Literature to Review





  [Link](https://doi.org/10.2196/52622)