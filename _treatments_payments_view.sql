-- 1. TREATMENT TABLE
DROP TABLE IF EXISTS treatment;
CREATE TABLE IF NOT EXISTS treatment (
  TreatmentID int NOT NULL AUTO_INCREMENT,
  PatientID int NOT NULL,
  DoctorID int NOT NULL,
  Diagnosis varchar(255) NOT NULL,
  Description text,
  StartDate date NOT NULL,
  EndDate date DEFAULT NULL,
  TreatmentType varchar(100) DEFAULT NULL,
  Cost decimal(10,2) DEFAULT NULL,
  Status enum('Active','Completed','Discontinued') DEFAULT 'Active',
  PRIMARY KEY (`TreatmentID`),
  KEY PatientID (`PatientID`),
  KEY DoctorID (`DoctorID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO treatment (`TreatmentID`, PatientID, DoctorID, Diagnosis, Description, StartDate, EndDate, TreatmentType, Cost, `Status`) VALUES
(1, 1, 1, 'Hypertension', 'Daily medication and lifestyle changes', '2024-11-01', '2024-12-01', 'Medication', 200.00, 'Completed'),
(2, 2, 2, 'Contact Dermatitis', 'Topical cream and avoidance of allergens', '2024-11-05', '2024-11-30', 'Therapy', 150.00, 'Completed'),
(3, 3, 3, 'Asthma', 'Maintenance inhaler therapy', '2024-11-10', NULL, 'Medication', 100.00, 'Active'),
(4, 4, 4, 'Osteoarthritis', 'Physical therapy and pain management', '2024-11-15', '2025-01-15', 'Therapy', 500.00, 'Completed'),
(5, 5, 5, 'Type 2 Diabetes', 'Insulin therapy and diet control', '2024-11-20', NULL, 'Medication', 350.00, 'Active');

-- 2. PAYMENT TABLE
DROP TABLE IF EXISTS payment;
CREATE TABLE IF NOT EXISTS payment (
  PaymentID int NOT NULL AUTO_INCREMENT,
  PatientID int NOT NULL,
  AppointmentID int DEFAULT NULL,
  Amount decimal(10,2) NOT NULL,
  PaymentDate date NOT NULL,
  PaymentMethod enum('Cash','Credit Card','Debit Card','Insurance','Bank Transfer') NOT NULL,
  ReceiptNumber varchar(50) NOT NULL,
  Status enum('Paid','Pending','Refunded') DEFAULT 'Paid',
  PRIMARY KEY (`PaymentID`),
  UNIQUE KEY ReceiptNumber (`ReceiptNumber`),
  KEY PatientID (`PatientID`),
  KEY AppointmentID (`AppointmentID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO payment (`PaymentID`, PatientID, AppointmentID, Amount, PaymentDate, PaymentMethod, ReceiptNumber, `Status`) VALUES
(1, 1, 1, 300.00, '2024-11-01', 'Cash', 'REC-2024-001', 'Paid'),
(2, 2, 2, 250.00, '2024-11-05', 'Credit Card', 'REC-2024-002', 'Paid'),
(3, 3, 3, 200.00, '2024-11-10', 'Insurance', 'REC-2024-003', 'Paid'),
(4, 4, 4, 350.00, '2024-11-15', 'Debit Card', 'REC-2024-004', 'Paid'),
(5, 5, 5, 280.00, '2024-11-20', 'Cash', 'REC-2024-005', 'Paid');

-- 3. VIEW: PATIENT TREATMENT SUMMARY
DROP VIEW IF EXISTS patienttreatmentsummary;
CREATE VIEW patienttreatmentsummary AS 
SELECT concat(`p`.`FirstName`,' ',`p`.`LastName`) AS PatientName, 
       count(`t`.`TreatmentID`) AS TotalTreatments, 
       sum(`t`.`Cost`) AS TotalCost, 
       max(`t`.`StartDate`) AS LatestTreatmentDate, 
       group_concat(distinct t.Diagnosis separator ', ') AS Diagnoses 
FROM ((`patient` pt join person p on((`pt`.`PersonID` = p.`PersonID`))) 
left join treatment t on((`pt`.`PatientID` = t.`PatientID`))) 
GROUP BY pt.PatientID 
ORDER BY TotalCost DESC;
