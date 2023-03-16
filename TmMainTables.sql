USE TMSolution

CREATE TABLE [tbWorkingDaysTypes] (
  [idWorkingDaysType] INT PRIMARY KEY IDENTITY(1, 1),
  [workingDaysType] VARCHAR(10) NOT NULL
)
GO

CREATE TABLE [tbBusRoadTypes] (
  [idRoadType] INT PRIMARY KEY IDENTITY(1, 1),
  [roadType] VARCHAR(10) NOT NULL
)
GO

CREATE TABLE [tbFuelTypes] (
  [idFuelType] INT PRIMARY KEY IDENTITY(1, 1),
  [fuelType] VARCHAR(10) NOT NULL
)
GO

CREATE TABLE [tbAlterBody] (
  [idAlterBody] INT PRIMARY KEY IDENTITY(1, 1),
  [characterstic] VARCHAR(30) NOT NULL
)
GO

CREATE TABLE [TbSexGenre] (
  [idSexGenre] INT PRIMARY KEY IDENTITY(1, 1),
  [genre] VARCHAR(10) NOT NULL
)
GO

CREATE TABLE [tbStationTypes] (
  [idStationType] INT PRIMARY KEY IDENTITY(1, 1),
  [stationType] VARCHAR(20) NOT NULL
)
GO

CREATE TABLE [tbHourSchedules] (
  [idHourSchedule] INT PRIMARY KEY IDENTITY(1, 1),
  [starHour1] FLOAT NOT NULL,
  [endHour1] FLOAT NOT NULL,
  [starHour2] FLOAT NOT NULL,
  [endHour2] FLOAT NOT NULL
)
GO

CREATE TABLE [tbTimeTables] (
  [idTimeTable] INT PRIMARY KEY IDENTITY(1, 1),
  [idWorkingDaysType] INT NOT NULL,
  [idHourSchedule] INT NOT NULL
)
GO

CREATE TABLE [tbBusType] (
  [idBusType] INT PRIMARY KEY IDENTITY(1, 1),
  [capacity] INT NOT NULL,
  [idBusRoadType] INT NOT NULL,
  [idFuelType] INT NOT NULL
)
GO

CREATE TABLE [tbBuses] (
  [idBus] INT PRIMARY KEY IDENTITY(1, 1),
  [idBusType] INT NOT NULL
)
GO

CREATE TABLE [tbStations] (
  [idStation] INT PRIMARY KEY IDENTITY(1, 1),
  [stationName] VARCHAR(50) NOT NULL,
  [latitude] FLOAT NOT NULL,
  [longitud] FLOAT NOT NULL,
  [optCapacity] INT NOT NULL,
  [idStationType] INT NOT NULL
)
GO

CREATE TABLE [tbOcupations] (
  [idOcupation] INT PRIMARY KEY IDENTITY(1, 1),
  [ocupation] VARCHAR(80) NOT NULL
)
GO

CREATE TABLE [tbPassengers] (
  [idPassenger] INT PRIMARY KEY IDENTITY(1, 1),
  [age] INT NOT NULL,
  [idOcupation] INT NOT NULL,
  [idAlterBody] INT NOT NULL,
  [idSexGenre] INT NOT NULL
)
GO

CREATE TABLE [tbRoutes] (
  [idRoute] INT PRIMARY KEY IDENTITY(1, 1),
  [routeName] VARCHAR(50) NOT NULL,
  [distance] FLOAT NOT NULL,
  [optTime] FLOAT NOT NULL,
  [avgTime] FLOAT NOT NULL,
  [idStartStation] INT NOT NULL,
  [idEndStation] INT NOT NULL,
  [idBusType] INT NOT NULL,
  [idTimeTable] INT NOT NULL
)
GO

CREATE TABLE [tbRoutesStations] (
  [idStop] INT PRIMARY KEY IDENTITY(1, 1),
  [idRoute] INT NOT NULL,
  [idStation] INT NOT NULL
)
GO

CREATE TABLE [tbPassengerRoute] (
  [id] INT PRIMARY KEY IDENTITY(1, 1),
  [starHour] DATETIME NOT NULL,
  [endHour] DATETIME NOT NULL,
  [idPassenger] INT NOT NULL,
  [idRoute] INT NOT NULL,
  [idStartStation] INT NOT NULL,
  [idEndStation] INT NOT NULL
)
GO

CREATE TABLE [tbTripPeopleIn_Out] (
  [idTripPeopleIn_Out] INT PRIMARY KEY IDENTITY(1, 1),
  [time] DATETIME NOT NULL,
  [peopleIn] INT NOT NULL,
  [peopleOut] INT NOT NULL,
  [idTrip] INT NOT NULL,
  [idStation] INT NOT NULL
)
GO

CREATE TABLE [tbTrips] (
  [idTrip] INT PRIMARY KEY IDENTITY(1,1),
  [startTime] DATETIME NOT NULL,
  [endTime] DATETIME NOT NULL,
  [incident] CHAR(1) NOT NULL,
  [idRoute] INT NOT NULL,
  [idBus] INT NOT NULL
)

GO

ALTER TABLE [tbBusType] ADD FOREIGN KEY ([idBusRoadType]) REFERENCES [tbBusRoadTypes] ([idRoadType])
GO

ALTER TABLE [tbPassengers] ADD FOREIGN KEY ([idOcupation]) REFERENCES [tbOcupations] ([idOcupation])
GO

ALTER TABLE [tbBusType] ADD FOREIGN KEY ([idFuelType]) REFERENCES [tbFuelTypes] ([idFuelType])
GO

ALTER TABLE [tbBuses] ADD FOREIGN KEY ([idBusType]) REFERENCES [tbBusType] ([idBusType])
GO

ALTER TABLE [tbPassengers] ADD FOREIGN KEY ([idAlterBody]) REFERENCES [tbAlterBody] ([idAlterBody])
GO

ALTER TABLE [tbPassengers] ADD FOREIGN KEY ([idSexGenre]) REFERENCES [TbSexGenre] ([idSexGenre])
GO

ALTER TABLE [tbStations] ADD FOREIGN KEY ([idStationType]) REFERENCES [tbStationTypes] ([idStationType])
GO

ALTER TABLE [tbTimeTables] ADD FOREIGN KEY ([idWorkingDaysType]) REFERENCES [tbWorkingDaysTypes] ([idWorkingDaysType])
GO

ALTER TABLE [tbRoutes] ADD FOREIGN KEY ([idTimeTable]) REFERENCES [tbTimeTables] ([idTimeTable])
GO

ALTER TABLE [tbTimeTables] ADD FOREIGN KEY ([idHourSchedule]) REFERENCES [tbHourSchedules] ([idHourSchedule])
GO

ALTER TABLE [tbRoutesStations] ADD FOREIGN KEY ([idRoute]) REFERENCES [tbRoutes] ([idRoute])
GO

ALTER TABLE [tbRoutesStations] ADD FOREIGN KEY ([idStation]) REFERENCES [tbStations] ([idStation])
GO

ALTER TABLE [tbPassengerRoute] ADD FOREIGN KEY ([idPassenger]) REFERENCES [tbPassengers] ([idPassenger])
GO

ALTER TABLE [tbPassengerRoute] ADD FOREIGN KEY ([idRoute]) REFERENCES [tbRoutes] ([idRoute])
GO

ALTER TABLE [tbPassengerRoute] ADD FOREIGN KEY ([idStartStation]) REFERENCES [tbStations] ([idStation])
GO

ALTER TABLE [tbPassengerRoute] ADD FOREIGN KEY ([idEndStation]) REFERENCES [tbStations] ([idStation])
GO

ALTER TABLE [tbTripPeopleIn_Out] ADD FOREIGN KEY ([idTrip]) REFERENCES [tbTrips] ([idTrip])
GO

ALTER TABLE [tbTripPeopleIn_Out] ADD FOREIGN KEY ([idStation]) REFERENCES [tbStations] ([idStation])
GO

ALTER TABLE [tbTrips] ADD FOREIGN KEY ([idRoute]) REFERENCES [tbRoutes] ([idRoute])
GO

ALTER TABLE [tbTrips] ADD FOREIGN KEY ([idBus]) REFERENCES [tbBuses] ([idBus])
