CREATE DATABASE LeiMedicalDB;
GO

USE LeiMedicalDB;
GO

CREATE TABLE Patients (
    patient_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    contact_info VARCHAR(50)
);

CREATE TABLE Doctors (
    doctor_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    department VARCHAR(100),
    contact VARCHAR(50)
);

CREATE TABLE Admissions (
    admission_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    admission_date DATE,
    discharge_date DATE,
    diagnosis VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Lab_Results (
    test_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT,
    test_name VARCHAR(100),
    result_value FLOAT,
    test_date DATE,
    lab_technician VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

CREATE TABLE Prescriptions (
    prescription_id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    medication VARCHAR(100),
    dosage VARCHAR(50),
    issue_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Disease_Registry (
    disease_id INT IDENTITY(1,1) PRIMARY KEY,
    disease_name VARCHAR(100),
    icd_code VARCHAR(10),
    severity VARCHAR(50)
);

-- PRINT 'Database and Tables Created Successfully!';


-- Set the path where the CSV files are stored
DECLARE @FilePath NVARCHAR(255) = 'C:\Users\Leinad\Documents\Tech_Villain\Simulation';

-- Import Patients
BULK INSERT Patients
FROM 'C:\Users\Leinad\Documents\Tech_Villain\Simulation\patients.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import Doctors
BULK INSERT Doctors
FROM 'C:\Users\Leinad\Documents\Tech_Villain\Simulation\doctors.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import Admissions
BULK INSERT Admissions
FROM 'C:\Users\Leinad\Documents\Tech_Villain\Simulation\admissions.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import Lab Results
BULK INSERT Lab_Results
FROM 'C:\Users\Leinad\Documents\Tech_Villain\Simulation\lab_results.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import Prescriptions
BULK INSERT Prescriptions
FROM 'C:\Users\Leinad\Documents\Tech_Villain\Simulation\prescriptions.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Import Disease Registry
BULK INSERT Disease_Registry
FROM 'C:\Users\Leinad\Documents\Tech_Villain\Simulation\disease_registry.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

-- Verify data was inserted
SELECT COUNT(*) AS PatientCount FROM Patients;
SELECT COUNT(*) AS DoctorCount FROM Doctors;
SELECT COUNT(*) AS AdmissionCount FROM Admissions;
SELECT COUNT(*) AS LabResultCount FROM Lab_Results;
SELECT COUNT(*) AS PrescriptionCount FROM Prescriptions;
SELECT COUNT(*) AS DiseaseRegistryCount FROM Disease_Registry;


SELECT TOP(5) * FROM Patients

SELECT TOP 10 p.name, d.name, admission_date, discharge_date FROM Admissions
JOIN Patients p ON Admissions.patient_id = p.patient_id
JOIN Doctors d ON Admissions.doctor_id = d.doctor_id;

-- Sample 1: Patient Admissions with Diagnosis and Doctor Details
SELECT 
    p.patient_id, p.name, p.gender, p.blood_type,
    a.admission_date, a.discharge_date, a.diagnosis,
    d.name AS doctor_name, d.specialization,
    COUNT(l.test_id) AS num_lab_tests
FROM 
    Patients p
JOIN 
    Admissions a ON p.patient_id = a.patient_id
JOIN 
    Doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN 
    Lab_Results l ON p.patient_id = l.patient_id
GROUP BY 
    p.patient_id, p.name, p.gender, p.blood_type,
    a.admission_date, a.discharge_date, a.diagnosis,
    d.name, d.specialization;

-- Sample 2: Disease Prevalence by Age/Gender
SELECT
    a.diagnosis,
    p.gender,
    CASE 
        WHEN DATEDIFF(YEAR, p.dob, GETDATE()) BETWEEN 0 AND 18 THEN '0-18'
        WHEN DATEDIFF(YEAR, p.dob, GETDATE()) BETWEEN 19 AND 35 THEN '19-35'
        WHEN DATEDIFF(YEAR, p.dob, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        WHEN DATEDIFF(YEAR, p.dob, GETDATE()) BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS prevalence_count
FROM 
    Admissions a
JOIN 
    Patients p ON a.patient_id = p.patient_id
GROUP BY 
    a.diagnosis, p.gender,
    CASE 
        WHEN DATEDIFF(YEAR, p.dob, GETDATE()) BETWEEN 0 AND 18 THEN '0-18'
        WHEN DATEDIFF(YEAR, p.dob, GETDATE()) BETWEEN 19 AND 35 THEN '19-35'
        WHEN DATEDIFF(YEAR, p.dob, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
        WHEN DATEDIFF(YEAR, p.dob, GETDATE()) BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
    END
ORDER BY 
    a.diagnosis, age_group, p.gender;

