ALTER TABLE Book
ADD Insert_Time  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP ;

ALTER TABLE Book_no
ADD Insert_Time  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP ;

ALTER TABLE Authur
ADD Insert_Time  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP ;


ALTER TABLE Genre
ADD Insert_Time  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP ;


ALTER TABLE Translator
ADD Insert_Time  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP ;


ALTER TABLE Membership
ADD Insert_Time  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP ;


ALTER TABLE Address
ADD Insert_Time  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP ;


ALTER TABLE Borrower
ADD Insert_Time  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP ;

CREATE TABLE Book_warehouse (

	ISBN INT NOT NULL ,
	Title CHAR(25) NOT NULL,
	Explaination TEXT DEFAULT NULL,
	Version_no INT DEFAULT NULL,
	Pub_Date DATE NOT NULL,
	Pub_Name CHAR(25) DEFAULT NULL,
	Update_time TIMESTAMP Default NULL,
	Delete_Time TIMESTAMP Default NULL,
	Description TEXT NOT NULL,
	
	
	
	PRIMARY KEY (Book_id) 
	
);
       
CREATE OR REPLACE FUNCTION rec_Update_Book()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Book_warehouse(ISBN,Title,Explaination,Version_no,Pub_Date,Pub_Name,Update_Time,Delete_Time,Description)
		 VALUES(OLD.ISBN,OLD.Title,OLD.Explaination,OLD.Version_no,OLD.Pub_Date,OLD.Pub_Name,CURRENT_TIMESTAMP,OLD.Delete_Time,'UPDATED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION rec_Delete_Book()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Book_warehouse(ISBN,Title,Explaination,Version_no,Pub_Date,Pub_Name,Update_Time,Delete_Time,Description)
		 VALUES(OLD.ISBN,OLD.Title,OLD.Explaination,OLD.Version_no,OLD.Pub_Date,OLD.Pub_Name,OLD.Update_Time,CURRENT_TIMESTAMP,'DELETED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER Book_Update
  BEFORE UPDATE
  ON Book
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Update_Book();
  
  CREATE TRIGGER Book_Delete
  BEFORE UPDATE
  ON Book
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Delete_Book();
  
  CREATE TABLE Book_no_warehouse(
	Book_id INT NOT NULL,
	ISBN INT NOT NULL,
	Book_number INT NOT NULL,
	Update_time TIMESTAMP Default NULL,
	Delete_Time TIMESTAMP Default NULL,
	Description TEXT NOT NULL,
	
	PRIMARY KEY (Book_id),
	
	
	CONSTRAINT Book_no_to_Book 
	FOREIGN KEY (ISBN) 
	REFRENCES Book (ISBN)
);

CREATE OR REPLACE FUNCTION rec_Update_Book_no()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Book_no_warehouse(Book_id,ISBN,Book_number,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Book_id,OLD.ISBN,OLD.Book_number,CURRENT_TIMESTAMP,OLD.Delete_Time,'UPDATED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION rec_Delete_Book_no()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Book_no_warehouse(Book_id,ISBN,Book_number,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Book_id,OLD.ISBN,OLD.Book_number,OLD.Update_time,CURRENT_TIMESTAMP,'DELETED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER Book_no_Update
  BEFORE UPDATE
  ON Book_no
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Update_Book_no();
  
  CREATE TRIGGER Book_no_Delete
  BEFORE UPDATE
  ON Book_no
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Dlete_Book_no();


	
  
  
  CREATE TABLE Authur_warehouse (

	Authur_id INT NOT NULL,
	Authur_FName CHAR(25) NOT NULL,
	Authur_LName CHAR(25) NOT NULL,
	B_ISBN INT UNIQUE NOT NULL,
	Update_time TIMESTAMP Default NULL,
	Delete_Time TIMESTAMP Default NULL,
	Description TEXT NOT NULL,
	
	PRIMARY KEY (Authur_id),
	
	CONSTRAINT Authur_to_Book
	FOREIGN KEY (B_ISBN) 
	REFERENCES Book_warehouse (ISBN)
);



CREATE OR REPLACE FUNCTION rec_Update_Authur()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Authur_warehouse(Authur_id,Authur_FName,Authur_LName,B_ISBN,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Authur_id,OLD.Authur_FName,OLD.Authur_LName,OLD.B_ISBN,CURRENT_TIMESTAMP,OLD.Delete_Time,'UPDATED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION rec_Delete_Authur()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Authur_warehouse(Authur_id,Authur_FName,Authur_LName,B_ISBN,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Authur_id,OLD.Authur_FName,OLD.Authur_LName,OLD.B_ISBN,OLD.Update_Time,CURRENT_TIMESTAMP,'DELETED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER Authur_Update
  BEFORE UPDATE
  ON Authur
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Update_Authur();
  
  CREATE TRIGGER Authur_Update
  BEFORE UPDATE
  ON Authur
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Delete_Authur();
  
  
  CREATE TABLE Genre_warehouse (

	Genre_id INT NOT NULL,
	Genre_Name CHAR(15) NOT NULL,
	B_ISBN INT UNIQUE NOT NULL, 
	Update_time TIMESTAMP Default NULL,
	Delete_Time TIMESTAMP Default NULL,
	Description TEXT NOT NULL,
	
	PRIMARY KEY (Genre_id),
	
	CONSTRAINT Genre_to_Book
	FOREIGN KEY (B_ISBN) 
	REFERENCES Book_warehouse (ISBN) 
);

CREATE OR REPLACE FUNCTION rec_Update_Genre()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Genre_warehouse(Genre_id,Genre_NameB_ISBN,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Genre_id,OLD.Genre_Name,OLD.B_ISBN,CURRENT_TIMESTAMP,OLD.Delete_Time,'UPDATED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION rec_DELETE_Genre()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Genre_warehouse(Genre_id,Genre_Name,B_ISBN,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Genre_id,OLD.Genre_Name,OLD.B_ISBN,OLD.Update_Time,CURRENT_TIMESTAMP,'DELETED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER Genre_Update
  BEFORE UPDATE
  ON Genre
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Update_Genre();

CREATE TRIGGER Genre_Delete
  BEFORE UPDATE
  ON Genre
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Delete_Genre();
  
  CREATE TABLE Translator_warehouse (

	T_id INT NOT NULL,
	T_FName CHAR(25) NOT NULL,
	T_LName CHAR(25) NOT NULL,
	B_ISBN INT UNIQUE NOT NULL,
	Language CHAR(25) NOT NULL,
	Update_time TIMESTAMP Default NULL,
	Delete_Time TIMESTAMP Default NULL,
	Description TEXT NOT NULL,
	
	PRIMARY KEY (T_id),
	
	CONSTRAINT Translator_to_Book
	FOREIGN KEY (B_ISBN) 
	REFERENCES Book_warehouse (ISBN)
);
  
  
CREATE OR REPLACE FUNCTION rec_Update_Translator()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Translator_warehouse(T_id,T_FName,T_LName,B_ISBN,Language,Update_Time,Delete_Time,Description)
		 VALUES(OLD.T_id,OLD.T_FName,OLD.T_LName,OLD.B_ISBN,OLD.Language,CURRENT_TIMESTAMP,OLD.Delete_Time,'UPDATED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION rec_Delete_Translator()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Translator_warehouse(T_id,T_FName,T_LName,Book_id,B_ISBN,Language,Update_Time,Delete_Time,Description)
		 VALUES(OLD.T_id,OLD.T_FName,OLD.T_LName,OLD.Book_id,OLD.B_ISBN,OLD.Language,OLD.Update_Time,CURRENT_TIMESTAMP,'UPDATED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER Translator_Update
  BEFORE UPDATE
  ON Translator
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Update_Translator();
  
  CREATE TRIGGER Translator_Delete
  BEFORE UPDATE
  ON Translator
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Delete_Translator();
  
  CREATE TABLE Membership_warehouse (

	FNAme CHAR(25) NOT NULL,
	LName CHAR(25) NOT NULL,
	BDate DATE NOT NULL,
	MsDate DATE NOT NULL,
	Ms_id INT NOT NULL,
	Phone_no INT NOT NULL,
	Update_time TIMESTAMP Default NULL,
	Delete_Time TIMESTAMP Default NULL,
	Description TEXT NOT NULL,
	
	PRIMARY KEY (Ms_id)
);

CREATE OR REPLACE FUNCTION rec_Update_Membership()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Membership_warehouse(FName,LName,BDate,MsDate,Ms_id,Phone_no,Update_Time,Delete_Time,Description)
		 VALUES(OLD.FName,OLD.LName,OLD.BDate,OLD.MsDate,OLD.Ms_id,OLD.Phone_no,CURRENT_TIMESTAMP,OLD.Delete_Time,'UPDATED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION rec_Delete_Membership()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Membership_warehouse(FName,LName,BDate,MsDate,Ms_id,Phone_no,Update_Time,Delete_Time,Description)
		 VALUES(OLD.FName,OLD.LName,OLD.BDate,OLD.MsDate,OLD.Ms_id,OLD.Phone_no,OLD.Update_Time,CURRENT_TIMESTAMP,'Deleted DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER Membership_Update
  BEFORE UPDATE
  ON Membership
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Update_Membership();
  
  CREATE TRIGGER Membership_Delete
  BEFORE UPDATE
  ON Membership
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Delete_Membership();
  
  CREATE TABLE Address_warehouse (
	
	Post_no INT NOT NULL,
	City CHAR(25) NOT NULL,
	Street TEXT NOT NULL,
	Ms_id INT NOT NULL,
	Update_time TIMESTAMP Default NULL,
	Delete_Time TIMESTAMP Default NULL,
	Description TEXT NOT NULL,
	
	PRIMARY KEY (Post_no),
	
	CONSTRAINT Address_to_Membership
	FOREIGN KEY (Ms_id) 
	REFERENCES Membership_warehouse (Ms_id)
);

CREATE OR REPLACE FUNCTION rec_Update_Address()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Address_warehouse(Post_no,City,Street,Ms_id,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Post_no,OLD.City,OLD.Ms_id,CURRENT_TIMESTAMP,OLD.Delete_Time,'UPDATED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION rec_Delete_Address()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Address_warehouse(Post_no,City,Street,Ms_id,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Post_no,OLD.City,OLD.Ms_id,OLD.Update_Time,CURRENT_TIMESTAMP,'DELETED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER Address_Update
  BEFORE UPDATE
  ON Address
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Update_Address();
  
  CREATE TRIGGER Address_Delete
  BEFORE UPDATE
  ON Address
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Delete_Address();
  
  CREATE TABLE Borrower_warehouse (
	
	Book_id INT NOT NULL,
	Ms_id INT NOT NULL,
	Update_time TIMESTAMP Default NULL,
	Delete_Time TIMESTAMP Default NULL,
	Description TEXT NOT NULL,
	
	
	CONSTRAINT Borrower_to_Book
       FOREIGN KEY (Book_id)
       REFERENCES Book_warehouse (Book_id),

       CONSTRAINT Borrrower_to_Membership
       FOREIGN KEY (Ms_id)
       REFERENCES Membership_warehouse (Ms_id)
);

CREATE OR REPLACE FUNCTION rec_Update_Borrower()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Borrower_warehouse(Book_id,Ms_id,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Book_id,OLD.Ms_id,CURRENT_TIMESTAMP,OLD.Delete_Time,'UPDATED DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION rec_Delete_Borrower()
  RETURNS trigger AS
$BODY$
BEGIN
	
		 INSERT INTO Borrower_warehouse(Book_id,Ms_id,Update_Time,Delete_Time,Description)
		 VALUES(OLD.Book_id,OLD.Ms_id,OLD.Update_Time,CURRENT_TIMESTAMP,'Deleted DATA');
	

	RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER Borrower_Update
  BEFORE UPDATE
  ON Borrower
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Update_Borrower();
  
  CREATE TRIGGER Borrower_Delete
  BEFORE UPDATE
  ON Borrower
  FOR EACH ROW
  EXECUTE PROCEDURE rec_Delete_Borrower();
	

