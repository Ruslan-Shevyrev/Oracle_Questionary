CREATE OR REPLACE PACKAGE BODY PKG_USERS
AS

-- Create User
PROCEDURE pCREATE_USER(P_vFIRST_NAME 	IN VARCHAR2,
					  P_vLAST_NAME 		IN VARCHAR2,
					  P_vPATRONYMIC 	IN VARCHAR2)
AS
BEGIN
	INSERT INTO USERS
				(FIRST_NAME,
				LAST_NAME,
				PATRONYMIC)
		VALUES(P_vFIRST_NAME,
				P_vLAST_NAME,
				P_vPATRONYMIC);
END pCREATE_USER;

-- Update User
PROCEDURE pUPDATE_USER(P_nID			IN NUMBER,
						P_vFIRST_NAME	IN VARCHAR2,
						P_vLAST_NAME		IN VARCHAR2,
						P_vPATRONYMIC	IN VARCHAR2)
AS
BEGIN
	UPDATE USERS 
		SET FIRST_NAME	= P_vFIRST_NAME,
			LAST_NAME	= P_vLAST_NAME,
			PATRONYMIC	= P_vPATRONYMIC
		WHERE ID = P_nID;
END pUPDATE_USER;

-- Delete User
PROCEDURE pDELETE_USER(P_nID IN NUMBER)
AS
BEGIN
	DELETE
		FROM USERS
		WHERE ID = P_nID;
END pDELETE_USER;

END PKG_USERS;