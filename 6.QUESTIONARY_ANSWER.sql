CREATE TABLE QUESTIONARY_ANSWER
(ID				NUMBER,
USER_ID			NUMBER		NOT NULL,
QUESTION_ID		NUMBER		NOT NULL,
SANSWER			VARCHAR2(4000),
NANSWER			NUMBER,
DANSWER			DATE,
BANSWER			BLOB
CANSWER			CLOB);

ALTER TABLE QUESTIONARY_ANSWER ADD CONSTRAINT QUESTIONARY_ANSWER_PK PRIMARY KEY (ID);
ALTER TABLE QUESTIONARY_ANSWER ADD CONSTRAINT QUESTIONARY_ANSWER_U_FK FOREIGN KEY (USER_ID) REFERENCES USERS (ID);
ALTER TABLE QUESTIONARY_ANSWER ADD CONSTRAINT QUESTIONARY_ANSWER_Q_FK FOREIGN KEY (QUESTION_ID) REFERENCES QUESTIONARY_QUESTION (ID);
ALTER TABLE QUESTIONARY_ANSWER ADD CONSTRAINT QUESTIONARY_ANSWER_A_CHECK CHECK 
((SANSWER IS NOT NULL AND NANSWER IS NULL AND DANSWER IS NULL AND BANSWER IS NULL AND CANSWER IS NULL)
OR (SANSWER IS NULL AND NANSWER IS NOT NULL AND DANSWER IS NULL AND BANSWER IS NULL AND CANSWER IS NULL)
OR (SANSWER IS NULL AND NANSWER IS NULL AND DANSWER IS NOT NULL AND BANSWER IS NULL AND CANSWER IS NULL)
OR (SANSWER IS NULL AND NANSWER IS NULL AND DANSWER IS NULL AND BANSWER IS NOT NULL AND CANSWER IS NULL)
OR (SANSWER IS NULL AND NANSWER IS NULL AND DANSWER IS NULL AND BANSWER IS NULL AND CANSWER IS NOT NULL));

CREATE SEQUENCE SEQ_QUESTIONARY_ANSWER
	START WITH 1
	INCREMENT BY 1
		NOCACHE
		NOCYCLE;

CREATE TRIGGER TRG_QUESTIONARY_ANSWER_I_U
	BEFORE UPDATE OR INSERT
		ON QUESTIONARY_ANSWER
	FOR EACH ROW
BEGIN
	IF(INSERTING) THEN
		:NEW.ID := SEQ_QUESTIONARY_ANSWER.NEXTVAL;
	END IF;
	
	IF(UPDATING) THEN
		IF :NEW.ID <> :OLD.ID THEN 
			raise_application_error(-20555, 'Can`t change id');
		END IF;
	END IF; 
END;
/

CREATE VIEW V_QUESTIONARY_ANSWER
	(ID,
	USER_ID,
	LAST_NAME,
	FIRST_NAME,
	PATRONYMIC,
	QUESTION_ID,
	TEMPLATE_ID,
	TEMPLATE_NAME,
	QUESTION,
	ANSWER_TYPE_ID,
	ANSWER_TYPE,
	SANSWER,
	NANSWER,
	DANSWER,
	BSANSWER,
	CANSWER)
AS 
SELECT	qa.ID,
		qa.USER_ID,
		u.LAST_NAME,
		u.FIRST_NAME,
		u.PATRONYMIC,
		qa.QUESTION_ID,
		qq.TEMPLATE_ID,
		qt.TEMPLATE_NAME,
		qq.QUESTION,
		qq.ANSWER_TYPE_ID,
		ans_t.ANSWER_TYPE,
		qa.SANSWER,
		qa.NANSWER,
		qa.DANSWER,
		qa.BSANSWER,
		qa.CANSWER
	FROM QUESTIONARY_ANSWER qa
	INNER JOIN USERS u
		ON qa.USER_ID = u.ID
	INNER JOIN QUESTIONARY_QUESTION qq
		ON qa.QUESTION_ID = qq.ID
	INNER JOIN QUESTIONARY_TEMPLATE qt
		ON qq.TEMPLATE_ID = qt.ID
	INNER JOIN QUESTIONARY_ANSWER_TYPE ans_t
		ON qq.ANSWER_TYPE_ID = ans_t.ID;