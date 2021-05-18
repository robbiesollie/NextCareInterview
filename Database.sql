DROP SCHEMA IF EXISTS NextCare;

CREATE SCHEMA NextCare;

USE NextCare;

CREATE TABLE Books (AuthorID INT, Title VARCHAR(20), Revision INT); -- part one

DELIMITER $$
CREATE PROCEDURE InsertBooks() -- part two
BEGIN
	DECLARE NumBooks INT DEFAULT 1;
	WHILE NumBooks <= 100 DO
		INSERT INTO Books (AuthorID, Title, Revision) VALUES (NumBooks, LPAD('', 13, CAST(CHAR(NumBooks + 64) AS CHAR)), 1);
		SET NumBooks = NumBooks + 1;
	END WHILE;
END $$

DELIMITER ;  

call InsertBooks();

DELIMITER $$
CREATE PROCEDURE DuplicateData() -- part three
BEGIN
	DECLARE Counter INT DEFAULT 0;
	DECLARE NumVals INT DEFAULT 100;
	DECLARE DuplicateId INT DEFAULT 0;
	DECLARE DuplicateTitle VARCHAR(20) DEFAULT '';

	SELECT COUNT(*) FROM Books INTO NumVals;
	
	WHILE Counter < NumVals DO
		SELECT AuthorID FROM Books WHERE Revision=1 LIMIT Counter, 1 INTO DuplicateId;
		SELECT Title FROM Books WHERE Revision=1 LIMIT Counter, 1 INTO DuplicateTitle;
		INSERT INTO Books(AuthorID, Title, Revision) VALUES (DuplicateId, DuplicateTitle, 2);
		SET Counter = Counter + 1;
	END WHILE;
END $$

DELIMITER ;

call DuplicateData();

ALTER TABLE Books ADD CONSTRAINT UNIQUE KEY (AuthorID, Title, Revision); -- part four

DELETE FROM Books WHERE AuthorID % 2=1 AND Revision=2; -- part five