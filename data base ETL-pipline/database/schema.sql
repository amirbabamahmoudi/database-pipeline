CREATE TABLE Book (

	ISBN INT NOT NULL ,
	Title CHAR(25) NOT NULL,
	Explaination TEXT DEFAULT NULL,
	Version_no INT DEFAULT NULL,
	Pub_Date DATE NOT NULL,
	Pub_Name CHAR(25) DEFAULT NULL,
	
	
	
	PRIMARY KEY (ISBN) 
	
);
CREATE TABLE Book_no(
	Book_id INT NOT NULL,
	ISBN INT NOT NULL,
	Book_number INT NOT NULL,
	
	PRIMARY KEY (Book_id),
	
	
	CONSTRAINT Book_no_to_Book 
	FOREIGN KEY (ISBN) 
	REFRENCES Book (ISBN)
	
	ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);
	 


CREATE TABLE Authur (

	Authur_id INT NOT NULL,
	Authur_FName CHAR(25) NOT NULL,
	Authur_LName CHAR(25) NOT NULL,
	B_ISBN INT NOT NULL,
	
	PRIMARY KEY (Authur_id),
	
	CONSTRAINT Authur_to_Book
	FOREIGN KEY (B_ISBN) 
	REFERENCES Book (ISBN)
	
	ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);

CREATE TABLE Genre (

	Genre_id INT NOT NULL,
	Genre_Name CHAR(15) NOT NULL,
	B_ISBN INT NOT NULL, 
	
	PRIMARY KEY (Genre_id),
	
	CONSTRAINT Genre_to_Book
	FOREIGN KEY (B_ISBN) 
	REFERENCES Book (ISBN) 
	
	ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);

CREATE TABLE Translator (

	T_id INT NOT NULL,
	T_FName CHAR(25) NOT NULL,
	T_LName CHAR(25) NOT NULL,
	B_ISBN INT NOT NULL,
	Language CHAR(25) NOT NULL,
	
	PRIMARY KEY (T_id),
	
	CONSTRAINT Translator_to_Book
	FOREIGN KEY (B_ISBN) 
	REFERENCES Book (ISBN)
	
	ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);

CREATE TABLE Membership (

	FNAme CHAR(25) NOT NULL,
	LName CHAR(25) NOT NULL,
	BDate DATE NOT NULL,
	MsDate DATE NOT NULL,
	Ms_id INT NOT NULL,
	Phone_no INT NOT NULL,
	
	PRIMARY KEY (Ms_id)
);

CREATE TABLE Address (
	
	Post_no INT NOT NULL,
	City CHAR(25) NOT NULL,
	Street TEXT NOT NULL,
	Ms_id INT NOT NULL,
	
	PRIMARY KEY (Post_no),
	
	CONSTRAINT Address_to_Membership
	FOREIGN KEY (Ms_id) 
	REFERENCES Membership (Ms_id)
	
	ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);

CREATE TABLE Borrower (
	
	Book_id INT NOT NULL,
	Ms_id INT NOT NULL,
	
	CONSTRAINT Borrower_to_Book
       FOREIGN KEY (Book_id)
       REFERENCES BOOK_no (Book_id),

       CONSTRAINT Borrrower_to_Membership
       FOREIGN KEY (Ms_id)
       REFERENCES Membership (Ms_id)
       
       ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);
	
	

	
	
	
	
