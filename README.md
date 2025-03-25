# LeiMedical (Hospital Analysis & Visualization Simulation) 

## Project Overview

This project simulates a hospital management system by generating mock data for patients, doctors, admissions, lab results, prescriptions, and disease registries. The goal is to analyze and visualize hospital operations, patient demographics, and disease prevalence.

## Dataset Description

The project consists of five core datasets:

**Patients:** Contains patient demographics like name, gender, blood type, and date of birth.

**Doctors:** Lists doctors with details about their specialization and department.

**Admissions:** Tracks patient admissions, assigned doctors, diagnosis, and length of stay.

**Lab Results:** Records lab tests conducted during patient admissions.

**Prescriptions:** Documents medications prescribed to patients.

**Disease Registry:** Maps diseases to patients with additional context about gender and age.

---

## Analysis Conducted

The following analyses were performed:

- Doctor workload and specialization insights.

- Diagnosis frequency and trends by gender.

- Disease prevalence across different age groups.

- Length of stay for different diagnoses.

- Top diseases treated by each medical specialization.

## Visualizations

Key visualizations include:

- Doctor Workload Analysis

- Gender vs. Diagnosis Trends

- Disease Prevalence by Age/Gender

- Average Length of Stay per Diagnosis

- Specializations and Most Frequent Diagnoses

## Tools & Technologies

**Python** (Pandas, Matplotlib, Seaborn)

**SQL** (Data Ingestion and Queries)

**Tableau** (Interactive Dashboards)

## Setup Instructions

Clone the repository:
```
git clone https://github.com/Dannysesi/LeiMedical

Install dependencies:

pip install pandas matplotlib seaborn

Import the dataset into your preferred SQL environment.

Run the Python scripts for analysis and visualization.

Open Tableau to create dashboards.

Simulating Real-World Scenarios


Project Structure

├── Data
│   ├── disease_prevalence_by_age_gender.csv
│   ├── patient_admissions_details.csv
├── Notebooks
│   ├── sim_eda.ipynb
│   ├── sim_eda2.ipynb
├── SQL
│   ├── LeiMedicalDB.sql
├── Tableau
│   ├── LeiMedical.twb
├── LICENSE
└── README.md
```

### Contributors

Dannysesi -> Leinad the Tech Villain

### Future Improvements

Implement a machine learning model for disease prediction.

Automate data ingestion and dashboard updates.

### License

MIT License

#### This README serves as a guide to understanding the project's context, objectives, and workflows. Let me know if you’d like to add more details or refine any section! 🚀


