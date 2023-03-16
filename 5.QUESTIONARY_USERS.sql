CREATE TABLE QUESTIONARY_USERS
(ID 			NUMBER,
USER_ID 		NUMBER		NOT NULL, 
QUESTIONARY_ID 	NUMBER		NOT NULL);

ALTER TABLE QUESTIONARY_USERS ADD CONSTRAINT QUESTIONARY_USERS_PK PRIMARY KEY (ID);

ALTER TABLE QUESTIONARY_USERS ADD CONSTRAINT QUESTIONARY_USERS_Q_FK FOREIGN KEY (QUESTIONARY_ID) REFERENCES QUESTIONARY (ID);

ALTER TABLE QUESTIONARY_USERS ADD CONSTRAINT QUESTIONARY_USERS_U_FK FOREIGN KEY (USER_ID) REFERENCES USERS (ID);

CREATE SEQUENCE SEQ_QUESTIONARY_USERS
	START WITH		1
	INCREMENT BY	1
		NOCACHE
		NOCYCLE;
		
CREATE TRIGGER TRG_QUESTIONARY_USERS_I_U
	BEFORE UPDATE OR INSERT
		ON QUESTIONARY
	FOR EACH ROW
BEGIN
	IF(INSERTING) THEN
		:NEW.ID := SEQ_QUESTIONARY_USERS.NEXTVAL;
	END IF;
	
	IF(UPDATING) THEN
		IF :NEW.ID <> :OLD.ID THEN 
			raise_application_error(-20555, 'Can`t change id');
		END IF;
	END IF; 
END;
/

CREATE VIEW V_QUESTIONARY_USERS
	(ID,
	USER_ID,
	LAST_NAME,
	FIRST_NAME,
	PATRONYMIC,
	QUESTIONARY_ID,
	DATE_BEG,
	DATE_END,
	TEMPLATE_ID,
	TEMPLATE_NAME)
AS 
SELECT	qu.ID,
		qu.USER_ID,
		u.LAST_NAME,
		u.FIRST_NAME,
		u.PATRONYMIC,
		qu.QUESTIONARY_ID,
		q.DATE_BEG,
		q.DATE_END,
		qt.ID AS TEMPLATE_ID,
		qt.NAME AS TEMPLATE_NAME
	FROM QUESTIONARY_USERS qu
	INNER JOIN USERS u
		ON qu.USER_ID = u.ID
	INNER JOIN QUESTIONARY q
		ON qu.QUESTIONARY_ID = q.ID
	INNER JOIN QUESTIONARY_TEMPLATE qt
		ON q.TEMPLATE_ID = qt.ID;