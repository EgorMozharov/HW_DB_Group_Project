CREATE TABLE IF NOT EXISTS Client(
	Client_ID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Surname VARCHAR(255) NOT NULL,
	Country VARCHAR(255) NOT NULL,
	City VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	Mail VARCHAR(255) NOT NULL,
	Password VARCHAR(255) NOT NULL,
	Login VARCHAR(255) NOT NULL,
	Date_Regestration DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS Purchase(
	Purchase_ID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
  	Status_ID INT REFERENCES Purchase_Status(id) On DELETE CASCADE NOT NULL,
	Client_ID INT NOT NULL,
	Postomat_ID INT,
	Date_Regestration DATE NOT NULL,
	Date_Finish DATE,
	Date_Accept DATE,
	Date_Decline DATE
);
CREATE TABLE IF NOT EXISTS Purchase_Status(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  	Status VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS Item(
	Item_ID INT NOT NULL PRIMARY KEY,
	Purchase_ID INT REFERENCES Purchase(Purchase_ID) On DELETE CASCADE,
  	Item_Status INT REFERENCES Item_Status(id) On DELETE CASCADE NOT NULL,
  	Item_Type INT REFERENCES Item_Type(id) On DELETE CASCADE NOT NULL,
	Name VARCHAR(255) NOT NULL,
	Price INT NOT NULL
);
CREATE TABLE IF NOT EXISTS Item_Status(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  	Status VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS Item_Type(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  	Type VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS Postomat(
	Postomat_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  	Postomat_location REFERENCES Postomat_Location(id) On DELETE CASCADE NOT NULL,
	Status VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS Postomat_Location(
  	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  	Country VARCHAR(255) NOT NULL,
	City VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL
);


--Adding new values to Client
INSERT INTO Client VALUES(1, "Egor", "Mozharov", "Russia", "Moscow", "Nelidovskya 23", "egor.mozharov@mail.ru", "Egor134", "Egor123", "2020-10-10");
INSERT INTO Client VALUES(2, "Drygine", "Arteme", "Russia", "Moscow", "St Pelor 12-A", "Drygine.Arteme@mail.ru", "Drygine12", "Drygine32", "2020-15-10");
SELECT * from Client;
--Adding new values to Purchase
INSERT INTO Purchase VALUES(1, 1, 1, 1, "2020-10-15", "2020-11-14", "2020-10-15", NULL);
SELECT * from Purchase;
--Adding new values to Purchase_Status
INSERT INTO Purchase_Status VALUES(1, "Delivered");
INSERT INTO Purchase_Status VALUES(2, "Declined");
INSERT INTO Purchase_Status VALUES(3, "In Process");
SELECT * from Purchase_Status;
--Adding new values to Item
INSERT INTO Item VALUES(1, 1, 1, 1, "AiphoneX", 7000);
INSERT INTO Item VALUES(2, NULL, 2, 1, "AiphoneX", 5000);
INSERT INTO Item VALUES(3, 1, 1, 1, "AiphoneX", 7000);
SELECT * from Item;
--Adding new values to Item_Status
INSERT INTO Item_Status VALUES(1, "Sold");
INSERT INTO Item_Status VALUES(2, "Warehouse");
SELECT * from Item_Status;
--Adding new values to Item_Type
INSERT INTO Item_Type VALUES(1, "Electronic Device");
SELECT * from Item_Type;
--Adding new values to Postomat
INSERT INTO Postomat VALUES(1, 1, "Work");
INSERT INTO Postomat VALUES(2, 1, "CLosed");
SELECT * from Postomat;
--Adding new values to Postomat_Location
INSERT INTO Postomat_Location VALUES(1, "Russia", "Moscow", "Nelidiv 25A");
INSERT INTO Postomat_Location VALUES(2, "Russia", "Moscow", "Prospect Lenina 22A");
SELECT * from Postomat_Location;

--Update Item_Type table
UPDATE Item_Type SET Type = 'Phone' WHERE id = 1;
SELECT * from Item_Type;
--Update Client table
UPDATE Client SET Address = 'Nelo 12' WHERE Name = 'Egor' and Surname = 'Mozharov';
SELECT * from Client;
--Update Postomat table
UPDATE Postomat SET status = "Broken" WHERE Postomat_ID = 2;
SELECT * from Postomat;


--Delete Item with id=2
DELETE FROM Item WHERE item_id = 2;
SELECT * from Item

--Select all Purchase which was delivered and amount of Item in one Purchase more than 1
SELECT * FROm Purchase LEFT JOIN Item ON Item.purchase_id = Purchase.purchase_id GROUP BY Purchase.purchase_id HAVING COUNT(Item.Item_ID) >= 2;
--CalculatePostomat_Location total Price for item which was sold
SELECT SUM(Item.Price) FROM Item LEFT JOIN Item_Status ON Item_Status.id = Item.Item_Status WHERE Item_Status.Status = "Sold"
--Calculate current number of working postomats
SELECT COUNT(Postomat.Postomat_ID) FROM Postomat WHERE Postomat.Status = "Work"
--Calculate how much the clients living in Moscow spent in total
SELECT SUM(Item.Price) FROM Item 
FULL JOIN Item_Status ON Item_Status.id = Item.Item_Status 
FULL JOIN Purchase ON Purchase.purchase_id = Item.Purchase_ID
FULL JOIN Client ON Client.client_id = Purchase.Client_ID
WHERE Item_Status.Status = "Sold" AND Client.City = "Moscow"
--Select all distinct Purchase_Status
SELECT DISTINCT(Purchase_Status.Status) FROM Purchase_Status
--Calculate the number of Client who made at least 1 purchase
SELECT COUNT(Client.Client_ID) FROM Client
CROSS JOIN Purchase ON Purchase.Client_ID = Client.Client_ID
--

--

--

--

--

--

--

--

--

--

--
