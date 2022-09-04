CREATE OR REPLACE PACKAGE PKG$USERS
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
					 
END PKG$USERS;