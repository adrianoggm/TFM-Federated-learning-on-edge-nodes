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