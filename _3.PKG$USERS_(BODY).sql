CREATE OR REPLACE PACKAGE BODY PKG$USERS
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

END PKG$USERS;