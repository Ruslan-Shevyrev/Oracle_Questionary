CREATE OR REPLACE PACKAGE PKG_USERS
AS

-- Create User
PROCEDURE pCREATE_USER(P_vFIRST_NAME 	IN VARCHAR2,
					  P_vLAST_NAME 		IN VARCHAR2,
					  P_vPATRONYMIC 	IN VARCHAR2);

-- Update User
PROCEDURE pUPDATE_USER(P_nID 			IN NUMBER,
					  P_vFIRST_NAME 	IN VARCHAR2,
					  P_vLAST_NAME 		IN VARCHAR2,
					  P_vPATRONYMIC 	IN VARCHAR2);

-- Delete User
PROCEDURE pDELETE_USER(P_nID IN NUMBER);

END PKG_USERS;