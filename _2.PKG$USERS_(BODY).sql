CREATE TABLE USERS
(ID				NUMBER,
LAST_NAME		varchar2(100)	NOT NULL,
FIRST_NAME		varchar2(100)   NOT NULL,
PATRONYMIC		varchar2(100));

ALTER TABLE USERS ADD CONSTRAINT USERS_PK PRIMARY KEY (ID);

CREATE SEQUENCE SEQ_USERS
	START WITH     1
	INCREMENT BY   1
		NOCACHE
		NOCYCLE;

CREATE TRIGGER TRG_USERS_I_U
	BEFORE UPDATE OR INSERT
		ON USERS
	FOR EACH ROW
BEGIN
    IF(INSERTING) THEN
		:NEW.ID := SEQ_USERS.NEXTVAL;
    END IF;
   
    IF(UPDATING) THEN
		IF :NEW.ID <> :OLD.ID THEN
			raise_application_error(-20555, 'Can`t change id');
		END IF;
    END IF;
END;
/


CREATE VIEW V_USERS
	(ID,
	LAST_NAME,
	FIRST_NAME,
	PATRONYMIC)
AS
SELECT  ID,
		LAST_NAME,
		FIRST_NAME,
		FIRST_NAME
	FROM USERS;