-- RaceDay Database
-- Part 1 - Section C: SQL Database Script

CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

-- Step 3B: Create Role table

CREATE TABLE Role (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- Step 3C: Create User table

CREATE TABLE [User] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    RoleID INT NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(20),
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_User_Role
        FOREIGN KEY (RoleID)
        REFERENCES Role(RoleID)
);
GO

USE RaceDayDB;
GO

SELECT * FROM [User];
GO

-- Step 3D: Create Event table

CREATE TABLE Event (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID INT NOT NULL,
    EventName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    EventDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    Location NVARCHAR(150) NOT NULL,
    RouteInformation NVARCHAR(500),
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES [User](UserID)
);
GO

-- Step 3E: Create Category table

CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300),
    EntryFee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    MaxParticipants INT,

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    CONSTRAINT UQ_Category_Event_Name
        UNIQUE (EventID, CategoryName)
);
GO

-- Step 3F: Create Enrollment table

CREATE TABLE Enrollment (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID INT NOT NULL,
    CategoryID INT NOT NULL,
    RegistrationDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(30) NOT NULL DEFAULT 'Registered',

    CONSTRAINT FK_Enrollment_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES [User](UserID),

    CONSTRAINT FK_Enrollment_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID),

    CONSTRAINT UQ_Enrollment_Participant_Category
        UNIQUE (ParticipantID, CategoryID)
);
GO

-- Step 3G: Create Result table

CREATE TABLE Result (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    FinishTime TIME,
    Position INT,
    ResultStatus NVARCHAR(30) NOT NULL DEFAULT 'Pending',
    RecordedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Result_Enrollment
        FOREIGN KEY (EnrollmentID)
        REFERENCES Enrollment(EnrollmentID),

    CONSTRAINT UQ_Result_Enrollment
        UNIQUE (EnrollmentID)
);
GO

-- Step 3H: Create EventWeather table

CREATE TABLE EventWeather (
    WeatherID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    Temperature DECIMAL(5,2),
    WeatherCondition NVARCHAR(100),
    WindSpeed DECIMAL(5,2),
    ForecastDate DATE NOT NULL,
    LastUpdated DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_EventWeather_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
);
GO

-- Step 3I: Insert Roles

INSERT INTO Role (RoleName)
VALUES
    ('Organiser'),
    ('Participant');
GO

SELECT * FROM Role;
GO

-- Step 3J: Insert Users

INSERT INTO [User]
    (RoleID, FirstName, LastName, Email, PasswordHash, PhoneNumber)
VALUES
    (1, 'Thabo', 'Mokoena', 'thabo.mokoena@raceday.co.za', 'Password123', '0712345678'),
    (1, 'Lerato', 'Molefe', 'lerato.molefe@raceday.co.za', 'Password123', '0723456789'),
    (2, 'Sipho', 'Dlamini', 'sipho.dlamini@email.com', 'Password123', '0734567890'),
    (2, 'Naledi', 'Maseko', 'naledi.maseko@email.com', 'Password123', '0745678901');
GO

SELECT UserID, RoleID, FirstName, LastName, Email
FROM [User];
GO

-- Step 3K: Insert Events

INSERT INTO Event
    (OrganiserID, EventName, Description, EventDate, StartTime, Location, RouteInformation)
VALUES
    (1, 'Johannesburg City Run', 
     'A community running event in Johannesburg.',
     '2026-10-10', '07:00:00', 
     'Johannesburg, Gauteng',
     'Road running route through the city.'),

    (1, 'Pretoria Charity Walk', 
     'A charity walking event supporting the local community.',
     '2026-10-24', '08:00:00',
     'Pretoria, Gauteng',
     'Scenic walking route around Pretoria.'),

    (2, 'Mpumalanga Cycle Challenge', 
     'A cycling event for recreational and competitive cyclists.',
     '2026-11-07', '06:30:00',
     'Mbombela, Mpumalanga',
     'Road cycling route through the surrounding area.');
GO

SELECT * FROM Event;
GO

-- Step 3L: Insert Categories

INSERT INTO Category
    (EventID, CategoryName, Description, EntryFee, MaxParticipants)
VALUES
    (1, '5 km Run', 
     'A 5 kilometre running category.',
     100.00, 200),

    (1, '10 km Run', 
     'A 10 kilometre running category.',
     150.00, 300),

    (2, '5 km Walk', 
     'A 5 kilometre walking category.',
     80.00, 250),

    (2, '10 km Walk', 
     'A 10 kilometre walking category.',
     120.00, 200),

    (3, '30 km Cycle', 
     'A 30 kilometre cycling category.',
     200.00, 150),

    (3, '60 km Cycle', 
     'A 60 kilometre cycling category.',
     300.00, 100);
GO

SELECT * FROM Category;
GO

-- Step 3M: Insert Enrolments

INSERT INTO Enrollment
    (ParticipantID, CategoryID, Status)
VALUES
    (3, 1, 'Registered'),
    (3, 3, 'Registered'),
    (4, 2, 'Registered'),
    (4, 5, 'Registered');
GO

SELECT * FROM Enrollment;
GO

-- Step 3N: Insert Results

INSERT INTO Result
    (EnrollmentID, FinishTime, Position, ResultStatus)
VALUES
    (1, '00:28:45', 12, 'Completed'),
    (2, '00:52:30', 8, 'Completed'),
    (3, '00:58:20', 25, 'Completed');
GO

SELECT * FROM Result;
GO

-- Step 3O: Insert Event Weather

INSERT INTO EventWeather
    (EventID, Temperature, WeatherCondition, WindSpeed, ForecastDate)
VALUES
    (1, 22.50, 'Partly Cloudy', 12.00, '2026-10-10'),
    (2, 24.00, 'Sunny', 8.50, '2026-10-24'),
    (3, 20.50, 'Clear', 10.00, '2026-11-07');
GO

SELECT * FROM EventWeather;
GO

-- Step 3P: Final Database Check

SELECT * FROM Role;
SELECT * FROM [User];
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM Enrollment;
SELECT * FROM Result;
SELECT * FROM EventWeather;
GO