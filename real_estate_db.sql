DROP DATABASE IF EXISTS real_estate_db;

CREATE DATABASE real_estate_db;

USE real_estate_db;

CREATE TABLE Property (
    address VARCHAR(50) PRIMARY KEY,
    ownerName VARCHAR(30),
    price INTEGER NOT NULL
);

CREATE TABLE House (
    address VARCHAR(50),
    bedrooms INT NOT NULL,
    bathrooms INT NOT NULL,
    size INT NOT NULL,
    FOREIGN KEY (address) REFERENCES Property(address)
);

CREATE TABLE BusinessProperty (
    address VARCHAR(50),
    type CHAR(20),
    size INT NOT NULL,
    FOREIGN KEY (address) REFERENCES Property(address)
);

CREATE TABLE Agent (
    agentId INT PRIMARY KEY,
    name VARCHAR(30),
    phone CHAR(12),
    firmId INT,
    dateStarted DATE
);

CREATE TABLE Firm (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    address VARCHAR(50)
);

CREATE TABLE Buyer (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    phone CHAR(12),
    propertyType CHAR(20),
    bedrooms INT,
    bathrooms INT,
    businessPropertyType CHAR(20),
    minimumPreferredPrice INT,
    maximumPreferredPrice INT
);

CREATE TABLE Listings (
    mlsNumber INT PRIMARY KEY,
    address VARCHAR(50),
    agentId INT,
    dateListed DATE,
    FOREIGN KEY (address) REFERENCES Property(address),
    FOREIGN KEY (agentId) REFERENCES Agent(agentId)
);

CREATE TABLE Works_With (
    buyerId INT,
    agentID INT,
    FOREIGN KEY (buyerId) REFERENCES Buyer(id),
    FOREIGN KEY (agentID) REFERENCES Agent(agentId)
);
-- I inserted more data than necessary to ensure proper functionality
INSERT INTO Property (address, ownerName, price)
VALUES 
('3001 Greasy Grove', 'Jimmy Haggis', 252000),
('4342 Tilted Towers', 'Curtis Sandy', 200000),
('1000 Pleasant Park', 'Clementine Humperdink', 452000),
('1234 Dusty Depot', 'Big Sludge', 320000),
('5678 Tomato Town', 'Formica Johnson', 500001),
('7890 Salty Springs', 'Charlie Mustard', 275000),
('8765 Retail Row', 'Jrosh Dove', 380050),
('4612 Lazy Lagoon', 'Happy Carothers', 100001),
('4321 Lonely Lodge', 'Old Joey', 200500),
('8765 Shifty Shafts', 'Vague Shadow', 300004),
('1357 Greasy Grove', 'Christopher Nail', 400000),
('2468 Viking Village', 'Paul Stew', 300500),
('9101 Lucky Landing', 'Dr. Edward Plunk', 280051);

INSERT INTO House (address, bedrooms, bathrooms, size)
VALUES 
('4342 Tilted Towers', 3, 2, 3000),
('1000 Pleasant Park', 4, 3, 2500),
('1234 Dusty Depot', 3, 2, 2000),
('5678 Tomato Town', 5, 4, 3500),
('7890 Salty Springs', 3, 2, 1800),
('8765 Retail Row', 4, 3, 2400);


INSERT INTO BusinessProperty (address, type, size)
VALUES 
('4612 Lazy Lagoon', 'Office', 4000),
('4321 Lonely Lodge', 'Restaurant', 5000),
('8765 Shifty Shafts', 'Office', 3000),
('1357 Greasy Grove', 'Warehouse', 8000),
('2468 Viking Village', 'Retail', 4500),
('9101 Lucky Landing', 'Factory', 6000);


INSERT INTO Agent (agentId, name, phone, firmId, dateStarted)
VALUES 
(001, 'Kevin Levin', '850-134-0000', 1, '2022-03-15'),
(22, 'Joink Gruff', '850-490-5824', 2, '2020-08-22'),
(33, 'Himiny Frothers', '850-551-1313', 3, '2021-01-10'),
(44, 'Michael Jordan', '850-555-1122', 1, '2019-05-30'),
(55, 'Jimbly Fisher', '850-512-3944', 2, '2023-02-14'),
(66, 'Nicholas Spindle', '850-867-5309', 1, '2024-11-25');

INSERT INTO Firm (id, name, address)
VALUES 
(6, 'Real Estate Company.', '995 Flush Factory'),
(1, 'House Realty', '500 East Gadsden Street'),
(2, 'Nicks Properties', '55 Call Street'),
(3, 'Plant Group', '193 Magnolia Drive'),
(4, 'Luxury Apartments Inc.', '123 Tennessee Street'),
(5, 'Affordable Condominiums', '850 T-pain Lane');

INSERT INTO Listings (mlsNumber, address, agentId, dateListed)
VALUES 
(1001, '1000 Pleasant Park', 001, '2024-01-10'),
(1002, '1234 Dusty Depot', 22, '2024-02-20'),
(1003, '5678 Tomato Town', 33, '2023-03-15'),
(1004, '7890 Salty Springs', 44, '2019-04-05'),
(1005, '8765 Retail Row', 55, '2022-05-01'),
(1006, '4342 Tilted Towers', 66, '2016-08-16');

INSERT INTO Buyer (id, name, phone, propertyType, bedrooms, bathrooms, businessPropertyType, minimumPreferredPrice, maximumPreferredPrice)
VALUES 
(101, 'Hinkly Dinkly', '850-444-5678', 'House', 4, 3, NULL, 100000, 500000),
(102, 'Sharp Fred', '850-333-1234', 'BusinessProperty', NULL, NULL, 'Warehouse', 200000, 400000),
(103, 'Park Floam', '850-777-9101', 'House', 3, 2, NULL, 250000, 350000),
(104, 'Derf Pringle', '850-888-4455', 'House', 5, 4, NULL, 400000, 600000),
(105, 'Glorp Steamy', '850-999-5566', 'BusinessProperty', NULL, NULL, 'Retail', 300000, 450000);