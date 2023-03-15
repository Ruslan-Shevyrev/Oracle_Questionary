CREATE OR REPLACE PACKAGE BODY PKG_QUESTIONARY
AS

-- Create Questionary Template
PROCEDURE pCREATE_QUESTIONARY_TEMPLATE(P_vNAME IN VARCHAR2)
IS
BEGIN
	INSERT INTO QUESTIONARY_TEMPLATE
				(NAME)
		VALUES (P_vNAME);
END pCREATE_QUESTIONARY_TEMPLATE;

-- Update Questionary Template
PROCEDURE pUPDATE_QUESTIONARY_TEMPLATE(P_nID 	IN NUMBER,
										P_vNAME IN VARCHAR2)
IS
BEGIN
	UPDATE QUESTIONARY_TEMPLATE
		SET NAME = P_vNAME
		WHERE ID = P_nID;
END pUPDATE_QUESTIONARY_TEMPLATE;

-- Delete Questionary Template
PROCEDURE pDELETE_QUESTIONARY_TEMPLATE(P_nID IN NUMBER)
IS
BEGIN
	DELETE 
		FROM QUESTIONARY_TEMPLATE
		WHERE ID = P_nID;
END pDELETE_QUESTIONARY_TEMPLATE;

-- Create Questionary Answer Type
PROCEDURE pCREATE_Q_ANSWER_TYPE(P_vNAME IN VARCHAR2)
IS
BEGIN
	INSERT INTO QUESTIONARY_ANSWER_TYPE
				(NAME)
		VALUES (P_vNAME);
END pCREATE_Q_ANSWER_TYPE;

-- Update Questionary Answer Type
PROCEDURE pUPDATE_Q_ANSWER_TYPE(P_nID 	IN NUMBER,
								P_vNAME IN VARCHAR2)
IS
BEGIN
	UPDATE QUESTIONARY_ANSWER_TYPE
		SET NAME = P_vNAME
		WHERE ID = P_nID;
END pUPDATE_Q_ANSWER_TYPE;

-- Delete Questionary Answer Type
PROCEDURE pDELETE_Q_ANSWER_TYPE(P_nID IN NUMBER)
IS
BEGIN
	DELETE 
		FROM QUESTIONARY_ANSWER_TYPE
		WHERE ID = P_nID;
END pDELETE_Q_ANSWER_TYPE;

-- Create Questionary Question
PROCEDURE pCREATE_Q_QUESTION(P_nTEMPLATE_ID 	IN NUMBER,
							P_vQUESTION 		IN VARCHAR2,
							P_nANSWER_TYPE_ID	IN NUMBER)
IS
BEGIN
	INSERT INTO QUESTIONARY_QUESTION
				(TEMPLATE_ID,
				QUESTION,
				ANSWER_TYPE_ID)
		VALUES (P_nTEMPLATE_ID,
				P_vQUESTION,
				P_nANSWER_TYPE_ID);
END pCREATE_Q_QUESTION;

-- Update Questionary Question
PROCEDURE pUPDATE_Q_QUESTION(P_nID 				IN NUMBER,
							P_nTEMPLATE_ID 		IN NUMBER,
							P_vQUESTION 		IN VARCHAR2,
							P_nANSWER_TYPE_ID	IN NUMBER)
IS
BEGIN
	UPDATE QUESTIONARY_QUESTION
		SET TEMPLATE_ID = P_nTEMPLATE_ID,
			QUESTION = P_vQUESTION,
			ANSWER_TYPE_ID = P_nANSWER_TYPE_ID
		WHERE ID = P_nID;
END pUPDATE_Q_QUESTION;

-- Delete Questionary Question
PROCEDURE pDELETE_Q_QUESTION(P_nID IN NUMBER)
IS
BEGIN
	DELETE
		FROM QUESTIONARY_QUESTION
		WHERE ID = P_nID;
END pDELETE_Q_QUESTION;

-- Create Questionary
PROCEDURE pCREATE_Q_QUESTIONARY(P_nTEMPLATE_ID 	IN NUMBER,
								P_dDATE_BEG 	IN DATE,
								P_dDATE_END		IN DATE DEFAULT NULL)
IS
BEGIN
	INSERT INTO QUESTIONARY
				(TEMPLATE_ID,
				DATE_BEG,
				DATE_END)
		VALUES (P_nTEMPLATE_ID,
				P_dDATE_BEG,
				P_dDATE_END);
END pCREATE_Q_QUESTIONARY;

-- Update Questionary
PROCEDURE pUPDATE_Q_QUESTIONARY(P_nID 			IN NUMBER,
								P_nTEMPLATE_ID 	IN NUMBER,
								P_dDATE_BEG 	IN DATE,
								P_dDATE_END		IN DATE DEFAULT NULL)
IS
BEGIN
	UPDATE QUESTIONARY
		SET TEMPLATE_ID = P_nTEMPLATE_ID,
			DATE_BEG = P_dDATE_BEG,
			DATE_END = P_dDATE_END
		WHERE ID = P_nID;
END pUPDATE_Q_QUESTIONARY;

-- Delete Questionary
PROCEDURE pDELETE_Q_QUESTIONARY(P_nID IN NUMBER)
IS
BEGIN
	DELETE
		FROM QUESTIONARY
		WHERE ID = P_nID;
END pDELETE_Q_QUESTIONARY;

-- Create Questionary User
PROCEDURE pCREATE_Q_USER(P_nUSER_ID 		IN NUMBER,
						P_nQUESTIONARY_ID 	IN NUMBER)
IS
BEGIN
	INSERT INTO QUESTIONARY_USERS
				(USER_ID,
				P_nQUESTIONARY_ID)
		VALUES (P_nUSER_ID,
				P_nQUESTIONARY_ID);
END pCREATE_Q_USER;

-- Update Questionary User
PROCEDURE pUPDATE_Q_USER(P_nID 				IN NUMBER,
						P_nUSER_ID 			IN NUMBER,
						P_nQUESTIONARY_ID 	IN NUMBER)
IS
BEGIN
	UPDATE QUESTIONARY_USERS
		SET USER_ID = P_nUSER_ID,
			QUESTIONARY_ID = P_nQUESTIONARY_ID
		WHERE ID = P_nID;
END pUPDATE_Q_USER;

-- Delete Questionary User
PROCEDURE pDELETE_Q_USER(P_nID IN NUMBER)
IS
BEGIN
	DELETE
		FROM QUESTIONARY_USERS
		WHERE ID = P_nID;
END pDELETE_Q_USER;

-- Create Questionary Answer
PROCEDURE pCREATE_Q_ANSWER(P_nQ_USER_ID 		IN NUMBER,
							P_nQUESTION_ID 		IN NUMBER,
							P_SANSWER			IN VARCHAR2 DEFAULT NULL,
							P_nANSWER  			IN NUMBER DEFAULT NULL,
							P_DANSWER			IN DATE DEFAULT NULL,
							P_BANSWER			IN BLOB DEFAULT NULL)
IS
	nANSWER_TYPE_ID NUMBER;
BEGIN

	BEGIN 
		SELECT qq.ANSWER_TYPE_ID 
			INTO nANSWER_TYPE_ID
			FROM QUESTIONARY_USERS qu 
			INNER JOIN QUESTIONARY q 
				ON qu.QUESTIONARY_ID = q.ID
			INNER JOIN QUESTIONARY_TEMPLATE qt
				ON q.TEMPLATE_ID = qt.ID
			INNER JOIN QUESTIONARY_QUESTION qq 
				ON qt.ID = qq.TEMPLATE_ID
			WHERE qu.ID = P_nQ_USER_ID 
				AND qq.ID = P_nQUESTION_ID;
	EXCEPTION WHEN NO_DATA_FOUND THEN 
		raise_application_error(-20555, 'can't find question)
	END;
				
	INSERT INTO QUESTIONARY_USERS
				(USER_ID,
				P_nQUESTIONARY_ID)
		VALUES (P_nUSER_ID,
				P_nQUESTIONARY_ID);
END pCREATE_Q_ANSWER;

-- Update Questionary Answer
PROCEDURE pUPDATE_Q_ANSWER(P_nQ_USER_ID 		IN NUMBER,
						P_nQUESTION_ID 		IN NUMBER,
						P_SANSWER			IN VARCHAR2 DEFAULT NULL,
						P_nANSWER  			IN NUMBER DEFAULT NULL,
						P_DANSWER			IN DATE DEFAULT NULL,
						P_BANSWER			IN BLOB DEFAULT NULL)
IS
BEGIN
	null;
END pUPDATE_Q_ANSWER;

-- Delete Questionary Answer
PROCEDURE pDELETE_Q_ANSWER(P_nID IN NUMBER)
IS
BEGIN
	DELETE
		FROM QUESTIONARY_ANSWER
		WHERE ID = P_nID;
END pDELETE_Q_ANSWER;

END PKG_QUESTIONARY;