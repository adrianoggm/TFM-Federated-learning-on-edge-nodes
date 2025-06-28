# Datasets Index

- [SWEET Study Dataset](#sweet-study-dataset)
- [WESAD Dataset Summary](#wesad-dataset-details)
- [SWELL Dataset Summary](#swell-kw-hrv)
## SWEET Study Dataset 
- **Purpose:** Traditional stress studies are small and lab-based. The SWEET study measured stress in real life at scale, recruiting 1,002 healthy office workers and monitoring them continuously for five days to capture natural variations in physiology and context. :contentReference[oaicite:0]{index=0}:contentReference[oaicite:1]{index=1}  
- **Protocol:** Each subject wore two devices: a chest patch (ECG @256 Hz + accelerometer @32 Hz) and a wristband (skin conductance @256 Hz, skin temperature @1 Hz, accelerometer @32 Hz). They answered brief stress/emotion surveys (EMAs) 12×/day, plus morning sleep and evening GI symptom diaries. Smartphone data (location clusters, phone usage, audio features, call/SMS logs) and baseline questionnaires (PSS, PSQI, DASS, RAND-36) were also collected. :contentReference[oaicite:2]{index=2}:contentReference[oaicite:3]{index=3}  
- **Analysis:** Data were cut into 5 min windows with 4 min overlap. Quality filters (good QI ≥ 80%) and low-activity filters (ACC SD ≤ 0.04) ensured clean segments. Eighteen physiological features were extracted (6 ECG HRV metrics, 8 skin-conductance metrics, 4 temperature metrics), plus ACC SD. :contentReference[oaicite:4]{index=4}:contentReference[oaicite:5]{index=5}  
- **Key Findings:**  
  - **Data Quality:** ≥ 86 % good ECG windows, ≥ 96 % good SC/ST windows.  
  - **Context Associations:** Stress rose after coffee/breakfast and fell after dinner/alcohol; heart rate and phasic SC increased with self-reported stress.  
  - **Modeling:** A leave-one-subject-out Random Forest achieved mean F1 = 0.43 (vs. 0.36 chance). Performance varied widely across individuals, revealing “digital phenotypes” with blunted vs. pronounced stress reactivity. :contentReference[oaicite:6]{index=6}:contentReference[oaicite:7]{index=7}  
- **Conclusion:** Wearable sensors can detect stress in daily life but one-size-fits-all models underperform—future work should tailor algorithms to each person’s unique physiological fingerprint. :contentReference[oaicite:8]{index=8}:contentReference[oaicite:9]{index=9}  

---



| Column                       | Type       | Description                                                                                     |
|------------------------------|------------|-------------------------------------------------------------------------------------------------|
| **subject_id**               | integer    | Unique identifier for each of the 1,002 participants                                            |
| **window_start**             | datetime   | UTC timestamp marking the start of the 5 min analysis window                                    |
| **window_end**               | datetime   | UTC timestamp marking the end of the 5 min analysis window                                      |
| **ecg_mean_hr**              | float      | Mean heart rate (beats per minute)                                                              |
| **ecg_rmssd**                | float      | Root mean square of successive RR-interval differences (ms)                                      |
| **ecg_sdnn**                 | float      | Standard deviation of NN intervals (ms)                                                         |
| **ecg_lf**                   | float      | Low-frequency power of heart-rate variability                                                   |
| **ecg_hf**                   | float      | High-frequency power of heart-rate variability                                                  |
| **ecg_lfhf_ratio**           | float      | Ratio of LF to HF power                                                                         |
| **sc_tonic_level**           | float      | Baseline (tonic) skin conductance level (µS)                                                    |
| **sc_phasic_amplitude**      | float      | Average amplitude of phasic skin-conductance responses (µS)                                     |
| **sc_area**                  | float      | Area under the phasic SC curve (µS·s)                                                           |
| **sc_diff2**                 | float      | Second derivative (signal curvature) of the SC trace                                            |
| **sc_event_count**           | integer    | Number of phasic conductance events detected                                                    |
| **sc_latency**               | float      | Mean latency of phasic SC responses (s)                                                         |
| **st_median**                | float      | Median skin temperature over the window (°C)                                                    |
| **st_slope**                 | float      | Temperature slope (°C per minute)                                                               |
| **st_sd**                    | float      | Standard deviation of skin temperature (°C)                                                     |
| **acc_sd**                   | float      | Standard deviation of the 3D acceleration magnitude (g)                                         |
| **stress_level**             | integer    | Self-reported stress (1 = no stress, 2 = light, 3 = high)                                        |
| **pleasure_score**           | integer    | SAM pleasure rating (1–5)                                                                       |
| **arousal_score**            | integer    | SAM arousal rating (1–5)                                                                        |
| **activity_type**            | string     | Self-reported activity category (e.g., sitting, walking)                                        |
| **consumption_events**       | string     | Self-reported intake (coffee, alcohol, meals, etc.)                                             |
| **location_cluster_id**      | integer    | Clustered “stay” location (anonymized)                                                          |
| **phone_usage_metrics**      | object     | JSON with counts/durations of calls, SMS, app use                                               |
| **baseline_pss**             | integer    | Perceived Stress Scale total score                                                              |
| **baseline_psqi**            | integer    | Pittsburgh Sleep Quality Index total score                                                      |
| **baseline_dass_depression** | integer    | DASS depression subscale score                                                                  |
| **baseline_dass_anxiety**    | integer    | DASS anxiety subscale score                                                                     |
| **baseline_dass_stress**     | integer    | DASS stress subscale score                                                                      |
| **rand36_physical**          | integer    | RAND-36 physical health component score                                                         |
| **rand36_mental**            | integer    | RAND-36 mental health component score 

---
## WESAD Dataset Details

WESAD (Wearable Stress and Affect Detection) is a publicly available multimodal dataset designed for automatic recognition of stress and emotional states using wearable sensors. In a controlled lab protocol, 15 healthy adults wore both chest (RespiBAN) and wrist (Empatica E4) devices while experiencing three conditions—neutral baseline, induced stress (Trier Social Stress Test), and amusement (funny videos)—with guided respites in between. Continuous recordings of physiological signals (ECG, respiration, EMG, EDA, temperature, accelerometer, BVP) were collected alongside validated self-reports (PANAS, STAI, SAM, SSSQ). Data were windowed (60 s windows with 0.25 s shift for physiological signals; 5 s for accelerometer), cleaned, and z-normalized per subject. Baseline benchmarking with Decision Tree, Random Forest, AdaBoost, LDA, and kNN under a leave-one-subject-out scheme achieved up to 80 % accuracy (three-class) and 93 % (binary stress vs. non-stress), highlighting high inter-subject variability and the need for personalized models.



Each subject’s data are provided as a Python pickle containing:
- `data`: a NumPy array of shape (samples × variables)  
- `labels`: a vector of affective state labels  
- `header`: a dictionary with `sampling_rate`, `start_time`, and channel names  

The following variables appear in `data` (all sampled at the rates indicated in `header`):

| Variable        | Type      | Description                                                      |
|-----------------|-----------|------------------------------------------------------------------|
| subject_id      | integer   | Unique ID for each of the 15 participants                        |
| timestamp       | datetime  | Sampling timestamp (UTC)                                         |
| ACC_wrist_x     | float     | Wrist accelerometer X-axis (g)                                   |
| ACC_wrist_y     | float     | Wrist accelerometer Y-axis (g)                                   |
| ACC_wrist_z     | float     | Wrist accelerometer Z-axis (g)                                   |
| BVP             | float     | Blood volume pulse from wrist (arbitrary units)                  |
| EDA_wrist       | float     | Electrodermal activity at wrist (µS)                            |
| TEMP_wrist      | float     | Skin temperature at wrist (°C)                                   |
| ACC_chest_x     | float     | Chest accelerometer X-axis (g)                                   |
| ACC_chest_y     | float     | Chest accelerometer Y-axis (g)                                   |
| ACC_chest_z     | float     | Chest accelerometer Z-axis (g)                                   |
| ECG             | float     | Electrocardiogram from chest (mV)                                |
| RESP            | float     | Respiration from chest (inductive sensor units)                  |
| EMG             | float     | Electromyography from chest (mV)                                 |
| TEMP_chest      | float     | Skin/chest temperature (°C)                                      |
| label           | integer   | Affective state: 0 = baseline, 1 = stress, 2 = amusement         |
| PANAS_positive  | integer   | PANAS positive affect score (post-condition)                     |
| PANAS_negative  | integer   | PANAS negative affect score (post-condition)                     |
| STAI            | integer   | State-Trait Anxiety Inventory score (post-condition)             |
| SAM_valence     | integer   | SAM valence rating (1 = unpleasant … 9 = pleasant)               |
| SAM_arousal     | integer   | SAM arousal rating (1 = calm … 9 = excited)                      |
| SSSQ            | string    | Short Stress State Questionnaire category                        |

**Note:** All signals were preprocessed with band-pass filters, artifact detection, and per-subject z-normalization. The dataset and full documentation are available at:  
https://ubicomp.eti.uni-siegen.de/home/datasets/icmi18/  

---
## SWELL-KW HRV

The SWELL-KW HRV Dataset provides heart rate variability (HRV) indices computed from ECG recordings of 25 office workers under three typical workplace conditions: 

- **No Stress**: unrestricted work time (up to 45 min).  
- **Time Pressure**: time to complete tasks reduced to two-thirds of the neutral condition.  
- **Interruption**: eight unexpected email interruptions (some task-relevant, some irrelevant).

Data were collected during realistic “knowledge work” (writing reports, presentations, e-mails, information search) and accompanied by subjective ratings of task load, mental effort, emotion, and perceived stress.



## Data & Files

- **train.csv**: 369,289 sliding 5-minute windows × 36 HRV features  
- **test.csv**:  41,033 sliding 5-minute windows × 36 HRV features  

Each row corresponds to a 5 min IBI (inter-beat interval) window, updated sample by sample (oldest IBI dropped, newest appended) to produce granular HRV time series.

---

## Features (36 HRV Indices)

| Feature        | Description                                       |
|----------------|---------------------------------------------------|
| MEAN_RR        | Mean RR interval (ms)                             |
| MEDIAN_RR      | Median RR interval (ms)                           |
| SDRR           | SD of RR intervals (ms)                           |
| RMSSD          | RMS of successive RR differences (ms)             |
| SDSD           | SD of successive RR differences (ms)              |
| SDRR_RMSSD     | Ratio SDRR / RMSSD                                |
| HR             | Mean heart rate (beats per minute)                |
| pNN25, pNN50   | % successive RR differences >25 ms / >50 ms       |
| SD1, SD2       | Poincaré plot descriptors                         |
| VLF, LF, HF, TP| Power in VLF, LF, HF bands and total power (ms²)  |
| VLF_PCT,...    | VLF/LF/HF as % of total power                     |
| HF_NU          | HF power in normalized units                      |
| LF_HF, HF_LF   | LF/HF and HF/LF ratios                            |
| sampen         | Approximate entropy                               |
| higuci         | Higuchi fractal dimension                         |
| datasetId      | Internal session/subject identifier               |
| condition      | “no stress” / “interruption” / “time pressure”    |

---

## HRV Computation & Preprocessing

1. **IBI Extraction**: detect R-peaks in ECG to form IBI time series.  
2. **Sliding Windows**: compute all indices over 5 min windows, sliding sample-by-sample.  
3. **Cleaning**: discard windows with artifacts or poor ECG quality.  
4. **Normalization**: metrics can be z-normalized per subject for analysis.

---

## Example Usage & Performance

A Random Forest classifier trained on a subset of seven features (selected via Pearson correlation to `condition`) achieved 100 % accuracy and perfect F1 scores on the test set—demonstrating both the dataset’s richness and the risk of overfitting given class imbalance and large sample count.

---

**Access & Citation**  
The original SWELL-KW dataset and accompanying papers can be found at:  
http://cs.ru.nl/~skoldijk/SWELL-KW/Dataset.html  


## Comparative 
| Dataset           | Subjects | Devices / Sensors                                                                                 | Protocol & Duration                                                                      | Windowing                                         | Features (# & type)                                             | Labels / Conditions                             | Size & Link                                                                      |
|-------------------|----------|---------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|---------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------|-----------------------------------------------------------------------------------|
| **SWEET Study**   | 1 002    | Chest patch (ECG 256 Hz, ACC 32 Hz); Wristband (SC 256 Hz, ST 1 Hz, ACC 32 Hz); Smartphone logs   | 5 days continuous; 12 EMAs/day + morning/evening diaries                                 | 5 min windows, 4 min overlap (QI ≥ 80 %, ACC_SD ≤ 0.04) | 19 physio features (6 ECG-HRV, 8 SC, 4 ST, 1 ACC_SD)            | Stress (1–3), pleasure (1–5), arousal (1–5), activities, intake events | Bajo acuerdo con autores (no público)                                             |
| **WESAD**         | 15       | Chest (RespiBAN™: ECG, RESP, EMG, EDA, TEMP, ACC); Wrist (Empatica E4: BVP, EDA, TEMP, ACC)          | Lab: baseline / stress (Trier) / amusement + guided breaks                                | 60 s windows, 0.25 s shift (physio); 5 s windows (ACC)  | 12 channels (ECG, RESP, EMG, EDA, BVP, TEMP, ACC)              | Baseline / stress / amusement (3-way)             | ~3.5 M samples (~2 GB)  
[descarga ↗](https://ubicomp.eti.uni-siegen.de/home/datasets/icmi18/) |
| **SWELL-KW HRV**  | 25       | ECG → IBI series → HRV                                                                             | Office tasks: no stress / time pressure / email interruptions (≈45 min cada condición)   | 5 min sliding windows (uno por cada nuevo IBI)       | 36 HRV indices (time & freq domain + entropy, fractal)        | No-stress / time-pressure / interruption (3-way) | Train: 369 289 ventanas  
Test: 41 033 ventanas  
[descarga ↗](http://cs.ru.nl/~skoldijk/SWELL-KW/Dataset.html) |
