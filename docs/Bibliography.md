# Bibliography

This bibliography compiles the articles reviewed on Internet of Things in Healthcare, with a focus on system sensor architectures and security considerations.

## Reviewed Literature
We took into account literature reviews from  2020-2025 5 years and datasets from 2010 to todays date. 
### References
1.- Article that makes a literature overview about the different sensors, architectures, and security concerns on IoTHealth systems. 

2.- This article reviews the use of wearable devices to detect and monitor stress, highlighting five key stages: physiological data collection (in controlled and real-world settings), preprocessing (signal filtering and normalization), feature extraction (HRV statistics, tonic/phasic EDA features, among others), machine learning model training (traditional classifiers and deep learning), and performance evaluation. It also addresses challenges such as personalization, real-time detection, and the integration of privacy and usability in real-world applications.

3.- This systematic literature review synthesizes state-of-the-art methods for mental-stress recognition using data-fusion of wearable sensor signals and machine learning. It defines seven research questions covering fusion strategies, classifier choices, sensor modalities, temporal segmentation, evaluation metrics and classifier performance. After screening 163 Scopus results (49 included studies), the review reports prevailing practices—feature-level fusion, widely used classifiers (SVM, Random Forest, KNN), ECG/EEG sensors, overlapping and uniform time windows—and summarizes typical model accuracies and future research directions.

4.- Large Scale study where they created a dataset measuring a lot of complex values from 1,002 healthy office workers and monitoring them continuously for five days to capture natural variations. see [datasets](./datasets.md)  for more info.( I could not find the dataset link anywhere.)
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
```





## Literature to Review

- **Schmidt, P., Reiss, A., Duerichen, R., Marberger, C., & Van Laerhoven, K. (2018):** Introducing WESAD, a Multimodal Dataset for Wearable Stress and Affect Detection. *Proceedings of the 20th ACM International Conference on Multimodal Interaction, 400-408.*  
  [Link](https://doi.org/10.1145/3242969.3242985)

- **PJ, S. (2021):** Swell dataset analysis for stress prediction.  
  [Link](https://www.kaggle.com/code/shreyaspj/swell-dataset-analysis-for-stress-prediction)

- **Dahal, K., Bogue-Jimenez, B., & Doblas, A. (2023):** Global stress detection framework combining a reduced set of HRV features and random forest model. *Sensors, 23(11), 5220.*  
  [Link](https://www.mdpi.com/1424-8220/23/11/5220/pdf)

- **Abd-Alrazaq, A., Alajlani, M., Ahmad, R., AlSaad, R., Aziz, S., Ahmed, A., ... & Sheikh, J. (2024):** The performance of wearable AI in detecting stress among students: systematic review and Meta-analysis. *Journal of Medical Internet Research, 26, e52622.*  
  [Link](https://doi.org/10.2196/52622)