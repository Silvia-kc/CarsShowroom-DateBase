CREATE DATABASE [CarsShowroom]

CREATE TABLE [Categories](
 [CategoryID] INT PRIMARY KEY IDENTITY (1,1),
 [Name] NVARCHAR (50) NOT NULL
)
CREATE TABLE [Engines](
 [EngineID] INT PRIMARY KEY IDENTITY (1,1),
 [Type] NVARCHAR (50) NOT NULL
)
CREATE TABLE [Cars](
 [CarID] INT PRIMARY KEY IDENTITY (1,1),
 [Brand] NVARCHAR (50) NOT NULL,
 [Model] NVARCHAR (50) NOT NULL,
 [CategoryID] INT FOREIGN KEY REFERENCES Categories(CategoryID),
 [EngineID] INT FOREIGN KEY REFERENCES Engines(EngineID),
 [Color] NVARCHAR (20) NOT NULL,
 [YearOfManifacture] INT CHECK(YearOfManifacture>1950) NOT NULL,
 [Price] DECIMAL (10,2) NOT NULL,
 
 )
 CREATE TABLE [Clients](
  [ClientID] INT PRIMARY KEY IDENTITY (1,1),
  [FirstName] NVARCHAR (30) NOT NULL,
  [LastName] NVARCHAR (50) NOT NULL,
  [PhoneNumber] NVARCHAR (10) CHECK(LEN(PhoneNumber)=10) UNIQUE NOT NULL
 )
 CREATE TABLE [Sales](
  [SaleID] INT PRIMARY KEY IDENTITY (1,1),
  [CarID] INT FOREIGN KEY REFERENCES Cars(CarID),
  [ClientID] INT FOREIGN KEY REFERENCES Clients(ClientID),
  [SaleDate] DATE NOT NULL
 )

 INSERT INTO Categories([Name]) 
 VALUES
(N'Ван'), (N'Джип'), (N'Кабрио'), (N'Комби'), (N'Купе'),
(N'Миниван'), (N'Пикап'), (N'Седан'), (N'Стреч лимузина'), (N'Хечбек')
 INSERT INTO Engines([Type])
 VALUES
(N'Бензинов'), (N'Дизелов'), (N'Електрически'), (N'Хибриден'), (N'Plug-In Хибрид')
 INSERT INTO Cars([Brand],[Model],[CategoryID],[EngineID],[Color],[YearOfManifacture],[Price])
 VALUES
('VW', 'Golf', 1, 1, N'Черен', 2022, 20000),
('Audi', 'A3', 2, 2, N'Сив', 2021, 25000),
('BMW', '3 Series', 2, 1, N'Бял', 2020, 30000),
('Mercedes-Benz', 'C-Class', 2, 1, N'Бял', 2022, 35000),
('Toyota', 'Corolla', 1, 3, N'Сив', 2021, 22000),
('Audi', 'A5', 1, 1, N'Черен', 2020, 32000),
('BMW', '6 Series', 1, 2, N'Черен', 2019, 35000),
('Audi', 'A8', 3, 1, N'Черен мат', 2023, 75000),
('Mercedes-Benz', 'G 500', 2, 3, N'Черен', 2022, 68000),
('Peugeot', '308', 1, 2, N'Син', 2022, 23000)
 INSERT INTO Clients([FirstName],[LastName],[PhoneNumber])
 VALUES
(N'Иван', N'Иванов', '0888123456'),
(N'Петър', N'Петров', '0899123456'),
(N'Георги', N'Георгиев', '0877123456'),
(N'Мартин', N'Маринов', '0885123456'),
(N'Алекс', N'Александров', '0897123456'),
(N'Борис', N'Борисов', '0886123456'),
(N'Кирил', N'Кирилов', '0876123456'),
(N'Даниел', N'Данев', '0896123456'),
(N'Стоян', N'Стоянов', '0884123456'),
(N'Николай', N'Николов', '0875123456')
 INSERT INTO Sales([CarID],[ClientID],[SaleDate])
 VALUES
(6, 8, '2022-01-16'),
(2, 3, '2022-02-09'),
(5, 1, '2022-11-30'),
(7, 4, '2022-04-19'),
(1, 6, '2023-05-21')

SELECT * FROM Cars
SELECT * FROM Cars WHERE(YearOfManifacture<2020)
SELECT [Model],[Color],[YearOfManifacture],[Price] FROM Cars WHERE(Brand='Audi')
SELECT [Brand],[Model],[YearOfManifacture],[Price] FROM Cars WHERE(EngineID=1)
SELECT [Brand],[Model],[YearOfManifacture],[Price] FROM Cars WHERE(CategoryID=1)
SELECT * FROM Cars WHERE(Color=N'Черен' OR Color=N'Син')
SELECT TOP 1 [Brand],[Model],[YearOfManifacture],[Price] FROM Cars ORDER BY Price ASC
SELECT [Brand],[Model],[Color],[YearOfManifacture],[Price] FROM Cars WHERE(EngineID=1) ORDER BY Price DESC

SELECT c.Brand, c.Model, ct.Name, c.YearOfManifacture, c.Price 
FROM Cars c
JOIN Categories ct ON c.CategoryID = ct.CategoryID
WHERE ct.Name = N'Ван'

SELECT cl.FirstName, c.Brand, c.Model, c.Color, c.Price 
FROM Sales s
JOIN Clients cl ON s.ClientID = cl.ClientID
JOIN Cars c ON s.CarID = c.CarID
ORDER BY c.Brand ASC, 
c.Price DESC

SELECT c.Brand, c.Model, c.YearOfManifacture, c.Price, ct.Name 
FROM Cars c
JOIN Categories ct ON c.CategoryID = ct.CategoryID
WHERE c.Price BETWEEN 20000 AND 30000 AND ct.Name = N'Джип'

Select cl.FirstName, cl.LastName, c.Brand, c.Model, c.Color, c.Price
FROM Sales s
JOIN Clients cl ON s.ClientID = cl.ClientID
JOIN Cars c ON s.CarID = c.CarID
WHERE c.Color = N'Черен'
ORDER BY c.Price ASC

SELECT ct.Name 
FROM Categories ct
LEFT JOIN Cars c ON ct.CategoryID = c.CategoryID
WHERE c.CarID IS NULL

SELECT cl.FirstName, cl.LastName, s.SaleDate 
FROM Clients cl
LEFT JOIN Sales s ON cl.ClientID = s.ClientID

SELECT cl.FirstName, cl.LastName 
FROM Clients cl
LEFT JOIN Sales s ON cl.ClientID = s.ClientID
WHERE s.SaleID IS NULL;

