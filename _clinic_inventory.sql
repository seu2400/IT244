-- 1. CLINIC TABLE
DROP TABLE IF EXISTS `clinic`;
CREATE TABLE IF NOT EXISTS `clinic` (
  `ClinicID` int NOT NULL AUTO_INCREMENT,
  `ClinicName` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `OperatingHours` varchar(100) DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ClinicID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `clinic` (`ClinicID`, `ClinicName`, `City`, `Address`, `Phone`, `OperatingHours`, `CreatedAt`) VALUES
(1, 'SmartCare Clinic Riyadh', 'Riyadh', 'King Fahd Road, Al Olaya District', '011-234-5678', '8:00 AM - 10:00 PM', '2026-08-05 22:07:15'),
(2, 'SmartCare Clinic Jeddah', 'Jeddah', 'Prince Sultan Street, Al Rawdah District', '012-345-6789', '8:00 AM - 10:00 PM', '2026-08-05 22:07:15'),
(3, 'SmartCare Clinic Dammam', 'Dammam', 'King Faisal Road, Al Khobar', '013-456-7890', '8:00 AM - 10:00 PM', '2026-08-05 22:07:15');

-- 2. MEDICINE TABLE
DROP TABLE IF EXISTS `medicine`;
CREATE TABLE IF NOT EXISTS `medicine` (
  `MedicineID` int NOT NULL AUTO_INCREMENT,
  `MedicineName` varchar(100) NOT NULL,
  `Category` varchar(50) NOT NULL,
  `Manufacturer` varchar(100) DEFAULT NULL,
  `UnitPrice` decimal(10,2) NOT NULL,
  `ReorderLevel` int DEFAULT '10',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MedicineID`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `medicine` (`MedicineID`, `MedicineName`, `Category`, `Manufacturer`, `UnitPrice`, `ReorderLevel`, `CreatedAt`) VALUES
(1, 'Panadol 500mg', 'Analgesic', 'GSK', 5.00, 50, '2026-08-05 22:07:15'),
(2, 'Augmentin 625mg', 'Antibiotic', 'Pfizer', 25.00, 30, '2026-08-05 22:07:15'),
(3, 'Ventolin Inhaler', 'Respiratory', 'GSK', 45.00, 20, '2026-08-05 22:07:15'),
(4, 'Insulin 100IU', 'Endocrine', 'Novo Nordisk', 120.00, 15, '2026-08-05 22:07:15'),
(5, 'Omeprazole 20mg', 'Gastrointestinal', 'AstraZeneca', 18.00, 25, '2026-08-05 22:07:15'),
(6, 'Amoxicillin 500mg', 'Antibiotic', 'Pfizer', 15.00, 40, '2026-08-05 22:07:15'),
(7, 'Vitamin D 1000IU', 'Supplement', 'Sanofi', 10.00, 30, '2026-08-05 22:07:15'),
(8, 'Enalapril 5mg', 'Cardiovascular', 'AstraZeneca', 22.00, 20, '2026-08-05 22:07:15'),
(9, 'Metformin 500mg', 'Endocrine', 'Novo Nordisk', 15.00, 35, '2026-08-05 22:07:15'),
(10, 'Ibuprofen 400mg', 'Analgesic', 'Pfizer', 8.00, 45, '2026-08-05 22:07:15');

-- 3. CLINIC_MEDICINE TABLE
DROP TABLE IF EXISTS `clinic_medicine`;
CREATE TABLE IF NOT EXISTS `clinic_medicine` (
  `ClinicID` int NOT NULL,
  `MedicineID` int NOT NULL,
  `QuantityInStock` int NOT NULL DEFAULT '0',
  `LastUpdated` date NOT NULL,
  PRIMARY KEY (`ClinicID`,`MedicineID`),
  KEY `MedicineID` (`MedicineID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `clinic_medicine` (`ClinicID`, `MedicineID`, `QuantityInStock`, `LastUpdated`) VALUES
(1, 1, 100, '2024-11-25'),
(1, 2, 50, '2024-11-25'),
(1, 3, 30, '2024-11-25'),
(1, 4, 20, '2024-11-25'),
(2, 1, 80, '2024-11-25'),
(2, 5, 40, '2024-11-25'),
(2, 6, 60, '2024-11-25'),
(3, 2, 35, '2024-11-25'),
(3, 7, 50, '2024-11-25'),
(3, 8, 25, '2024-11-25');
