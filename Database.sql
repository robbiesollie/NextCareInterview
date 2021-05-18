DROP SCHEMA IF EXISTS NextGen;

CREATE SCHEMA NextGen;

USE NextGen;

CREATE TABLE Books (AuthorID INT, Title VARCHAR(20), Revision INT);

DELIMITER $$
CREATE PROCEDURE InsertBooks()
BEGIN
	DECLARE NumBooks INT DEFAULT 1;
	WHILE NumBooks <= 100 DO
		INSERT INTO Books (AuthorID, Title, Revision) VALUES (NumBooks, LPAD('', 13, CAST(CHAR(NumBooks + 64) AS CHAR)), 1);
		-- SELECT LPAD('', 13, CAST(CHAR(@NumBooks + 64) AS CHAR));
		-- SELECT CAST(CHAR(@NumBooks + 64) AS CHAR);
		-- INSERT INTO Books (@NumBooks, LPAD('', 13, CHAR(@NumBooks + 64)), 1);
		SET NumBooks = NumBooks + 1;
	END WHILE;
END $$

DELIMITER ;  

call InsertBooks();

DELIMITER $$
CREATE PROCEDURE DuplicateData()
BEGIN
	DECLARE Counter INT DEFAULT 0;
	DECLARE NumVals INT DEFAULT 100;
	DECLARE DuplicateId INT DEFAULT 0;
	DECLARE DuplicateTitle VARCHAR(20) DEFAULT '';

	SELECT COUNT(*) FROM Books INTO NumVals;
	-- DECLARE DuplicateId INT DEFAULT 0;
	
	WHILE Counter < NumVals DO
		-- DECLARE NewId INT DEFAULT 0;
		SELECT AuthorID FROM Books WHERE Revision=1 LIMIT Counter, 1 INTO DuplicateId;
		-- DECLARE NewTitle INT;
		SELECT Title FROM Books WHERE Revision=1 LIMIT Counter, 1 INTO DuplicateTitle;
		INSERT INTO Books(AuthorID, Title, Revision) VALUES (DuplicateId, DuplicateTitle, 2);
		SET Counter = Counter + 1;
	END WHILE;
END $$

DELIMITER ;

call DuplicateData();

ALTER TABLE Books ADD CONSTRAINT UNIQUE KEY (AuthorID, Title, Revision);

DELETE FROM Books WHERE AuthorID % 2=1 AND Revision=2;