DROP SCHEMA IF EXISTS NextGen;

CREATE SCHEMA NextGen;

USE NextGen;

CREATE TABLE Books (AuthorID INT, Title VARCHAR(20), Revision INT);


CREATE PROCEDURE InsertBooks()
	SET @NumBooks = 1;
	WHILE @NumBooks <= 100 DO
		INSERT INTO Books (AuthorID, Title, Revision) VALUES (1, 'Hiii', 1);
		INSERT INTO Books (@NumBooks, LPAD('', 13, CHAR(NumBooks + 64)), 1);
		SET @NumBooks = @NumBooks + 1;
	END WHILE
