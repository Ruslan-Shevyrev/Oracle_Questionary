CREATE OR REPLACE PACKAGE PKG$QUESTIONARY
AS

-- Create Questionary Template
PROCEDURE pCREATE_QUESTIONARY_TEMPLATE(P_vNAME IN VARCHAR2);

-- Update Questionary Template
PROCEDURE pUPDATE_QUESTIONARY_TEMPLATE(P_nID 	IN NUMBER,
										P_vNAME IN VARCHAR2);

-- Delete Questionary Template
PROCEDURE pDELETE_QUESTIONARY_TEMPLATE(P_nID IN NUMBER);

-- Create Questionary Answer Type
PROCEDURE pCREATE_Q_ANSWER_TYPE(P_vNAME IN VARCHAR2);

-- Update Questionary Answer Type
PROCEDURE pUPDATE_Q_ANSWER_TYPE(P_nID 	IN NUMBER,
								P_vNAME IN VARCHAR2);
							
-- Delete Questionary Answer Type
PROCEDURE pDELETE_Q_ANSWER_TYPE(P_nID IN NUMBER);

-- Create Questionary Question
PROCEDURE pCREATE_Q_QUESTION(P_nTEMPLATE_ID 	IN NUMBER,
							P_vQUESTION 		IN VARCHAR2,
							P_nANSWER_TYPE_ID	IN NUMBER);
						
-- Update Questionary Question
PROCEDURE pUPDATE_Q_QUESTION(P_nID 				IN NUMBER,
							P_nTEMPLATE_ID 		IN NUMBER,
							P_vQUESTION 		IN VARCHAR2,
							P_nANSWER_TYPE_ID	IN NUMBER);
						
END PKG$QUESTIONARY;