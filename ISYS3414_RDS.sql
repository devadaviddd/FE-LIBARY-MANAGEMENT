/* AUTH ROLE USE CASE */
-- WHEN USER LOAD HOME PAGE THIS QUERY WILL EXECUTE FIRST
declare
  email varchar(30);
  auth_role varchar2(10);
  moveToNewPage boolean;
  l_session_number NUMBER;
begin
    l_session_number := apex_application.g_instance;
    SELECT u_role into auth_role from USER_ENTITY
    WHERE UPPER(email) = v('APP_USER');
    if auth_role = 'Admin' then
      apex_util.redirect_url(p_url => 'f?p='||:APP_ID||':2:'||l_session_number||'::::',
        p_reset_htp_buffer => true);
    end if;
end;
-- WHEN USER LOAD PROFILE PAGE THIS QUERY WILL EXECUTE FIRST
declare
    email varchar(30);
    auth_role varchar2(10);
    moveToNewPage boolean;
    l_session_number NUMBER;
begin
    l_session_number := apex_application.g_instance;
    SELECT u_role into auth_role from USER_ENTITY
    WHERE UPPER(email) = v('APP_USER');

    if auth_role = 'Student' then
      apex_util.redirect_url(p_url => 'f?p='||:APP_ID||':19:'||l_session_number||'::::',
        p_reset_htp_buffer => true
      );
    end if;

    if auth_role = 'Teacher' then
      apex_util.redirect_url(p_url => 'f?p='||:APP_ID||':17:'||l_session_number||'::::',
        p_reset_htp_buffer => true
      );
    end if;
end;
-- WHEN USER LOAD BOOKS ISSUE PAGE THIS QUERY WILL EXECUTE FIRST
declare
    email varchar(30);
    auth_role varchar2(10);
    moveToNewPage boolean;
    l_session_number NUMBER;
begin
    l_session_number := apex_application.g_instance;
    SELECT u_role into auth_role from USER_ENTITY
    WHERE UPPER(email) = v('APP_USER');

    if auth_role = 'Student' then
      apex_util.redirect_url(p_url => 'f?p='||:APP_ID||':23:'||l_session_number||'::::',
        p_reset_htp_buffer => true
      ;
    end if;

    if auth_role = 'Teacher' then
      apex_util.redirect_url(p_url => 'f?p='||:APP_ID||':24:'||l_session_number||'::::',
        p_reset_htp_buffer => true
      );
    end if;
end;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* GET USERNAME COOKIE USE CASE */
:P9999_USERNAME := apex_authentication.get_login_username_cookie;
:P9999_REMEMBER := case when :P9999_USERNAME is not null then 'Y' end;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* AUTHENTiCATION SCHEME */
FUNCTION CUSTOM_AUTH (p_username IN VARCHAR2, p_password IN VARCHAR2) RETURN BOOLEAN AS my_user NUMBER := 0;
BEGIN
SELECT 1 INTO my_user
FROM USER_ENTITY
WHERE UPPER(EMAIL) = UPPER(p_username)
  AND u_password = p_password;
RETURN TRUE;
EXCEPTION
WHEN NO_DATA_FOUND THEN RETURN FALSE;
END CUSTOM_AUTH;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* NAV LIST ENTRY */
  /* 1. HOME PAGE ROUTE */
  SELECT u_role
  FROM USER_ENTITY
  WHERE UPPER(email) = V('APP_USER')
    AND u_role = 'Admin';

  /* 2. DASHBOARD ROUTE */
  SELECT u_role
  FROM USER_ENTITY
  WHERE UPPER(email) = V('APP_USER')
    AND u_role != 'Admin';

  /* 3. BOOK MANAGEMENT ROUTE */
  SELECT u_role
  FROM USER_ENTITY
  WHERE UPPER(email) = V('APP_USER')
    AND u_role != 'Admin';

  /* 4. USER MANAGEMENT ROUTE */
  SELECT u_role
  FROM USER_ENTITY
  WHERE UPPER(email) = V('APP_USER')
    AND u_role != 'Admin';

  /* 5. ENTRY HISTORY ROUTE */
  SELECT u_role
  FROM USER_ENTITY
  WHERE UPPER(email) = V('APP_USER')
    AND u_role != 'Admin';

  /* 6. PROFILE ROUTE */
  SELECT u_role
  FROM USER_ENTITY
  WHERE UPPER(email) = V('APP_USER')
    AND u_role = 'Admin';

  /* 7. YOUR BOOKS ROUTE */
  SELECT u_role
  FROM USER_ENTITY
  WHERE UPPER(email) = V('APP_USER')
    AND u_role = 'Admin';

  /* 8. CALENDAR ROUTE */
  SELECT u_role
  FROM USER_ENTITY
  WHERE UPPER(email) = V('APP_USER')
    AND u_role = 'Admin';
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 
/* FINE CALCULATE PRE RENDERING */
begin
  UPDATE ENTRY_RELATION
  SET CURRENT_FINE = 100 * FINE_RATE + CURRENT_FINE, ACCUMULATE_DAY = ACCUMULATE_DAY + 2
  WHERE TRUNC(ACCUMULATE_DAY) = TRUNC(SYSDATE + INTERVAL '7' HOUR) ;

  UPDATE ENTRY_RELATION
  SET E_STATUS = 'Late', CURRENT_FINE = CURRENT_FINE + 100
  WHERE TRUNC(DEADLINE) = TRUNC(SYSDATE + INTERVAL '7' HOUR) AND E_STATUS = 'In Borrow'; 
end;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* GET STUDENT BOOKS USE CASE */
SELECT ENTRY_ID,
  EMAIL,
  BOOK_ID,
  TITLE,
  B_CATEGORY,
  dbms_lob.getlength(BOOK_PICTURE) AS BOOK_PICTURE,
  FILENAME,
  MIMETYPE,
  CURRENT_FINE,
  DEADLINE,
  ACCUMULATE_DAY,
  NULL AS RETURN_ACTION
FROM USER_BOOK_VIEW
WHERE UPPER(EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* ISSUE STUDENT BOOK USE CASE */
DELETE FROM ENTRY_RELATION WHERE ID = :ENTRY_ID;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* ISSUE TEACHER BOOK USE CASE*/
SELECT ENTRY_ID,
  EMAIL,
  BOOK_ID,
  TITLE,
  B_CATEGORY,
  dbms_lob.getlength(BOOK_PICTURE) AS BOOK_PICTURE,
  FILENAME,
  MIMETYPE,
  CURRENT_FINE,
  DEADLINE,
  ACCUMULATE_DAY,
  NULL AS RETURN_ACTION
FROM USER_BOOK_VIEW
WHERE UPPER(EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* ISSUE TEACHER BOOKS USE CASE */
DELETE FROM ENTRY_RELATION WHERE ID = :ENTRY_ID;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* DELETE BOOK USE CASE */
BEGIN
  DECLARE
    IS_BOOK_EXIST INT := 0;
    IS_USER_EXIST INT := 0;
  BEGIN
    SELECT COUNT(*) INTO IS_BOOK_EXIST FROM ENTRY_RELATION WHERE BOOK_ID = :BOOK_ID;
    SELECT COUNT(*) INTO IS_USER_EXIST FROM ENTRY_RELATION WHERE email = :USER_EMAIL;
    
    IF :USER_EMAIL IS NOT NULL AND IS_USER_EXIST = 0 THEN    
      DELETE FROM USER_ENTITY WHERE EMAIL = :USER_EMAIL;
      RETURN;
    ELSIF :BOOK_ID IS NOT NULL AND IS_BOOK_EXIST = 0 THEN 
      DELETE FROM BOOK_ENTITY WHERE ID = :BOOK_ID;
      RETURN;
    ELSE 
      apex_error.add_error (
        p_message          => 'Cannot be deleted because it is currently has book issue in entry',
        p_display_location => apex_error.c_inline_in_notification 
      );
  END IF;
  END;
END;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* GET BOOKS USE CASE */
SELECT ROWID,
  ID,
  TITLE,
  AUTHOR,
  B_CATEGORY,
  NULL AS DELETE_ACTION,
  dbms_lob.getlength(BOOK_PICTURE) AS BOOK_PICTURE,
  MIMETYPE,
  FILENAME,
  B_STATUS
FROM BOOK_ENTITY;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* BOOK MANAGEMENT -> MODALS -> FORM CREATE */
SELECT ID,
  TITLE,
  AUTHOR,
  B_CATEGORY,
  BOOK_PICTURE,
  MIMETYPE,
  FILENAME,
  CREATED_DATE,
  B_STATUS
FROM BOOK_ENTITY;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* CALENDAR GET USER ENTRIES USE CASE */
SELECT ID,
  EMAIL,
  BOOK_ID,
  B_CATEGORY,
  U_NAME,
  U_ROLE,
  TITLE,
  FINE_RATE,
  ISSUE_DAY,
  ACCUMULATE_DAY,
  CURRENT_FINE,
  DEADLINE,
  E_STATUS
FROM ENTRY_RELATION
WHERE UPPER(EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* GET BOOKS AVAILABLE USE CASE */
select TITLE, NUM_STOCK
from (SELECT DISTINCT TITLE, NUM_STOCK FROM STOCK_ENTITY)
where NUM_STOCK > 0
order by 2 desc;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* GET CATEGORY ALLOCATE USE CASE */
select B_CATEGORY, count(B_CATEGORY) value
from BOOK_ENTITY
where B_CATEGORY is not null
group by B_CATEGORY
order by 2 desc;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* GET ROLE ALLOCATE USE CASE */
select U_ROLE, count(U_ROLE) value
from USER_ENTITY
where U_ROLE is not null
group by U_ROLE
order by 2 desc;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 

/* GET TOTAL BOOKS USE CASE */
SELECT COUNT(*) FROM BOOK_ENTITY;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET TOTAL ENTRIES USE CASE */
SELECT COUNT(*) FROM ENTRY_RELATION;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET TOTAL USERS USE CASE */
select count(*) from USER_ENTITY order by 1;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET USERS FINE USE CASE */
SELECT EMAIL, SUM(CURRENT_FINE) AS TOTAL_FINE
FROM ENTRY_RELATION
GROUP BY EMAIL;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET USERS ISSUED USE CASE */
SELECT TITLE,
  COUNT(TITLE) AS VALUE,
  CONCAT(
    'Users: ',
    LISTAGG(EMAIL, ', ') WITHIN GROUP (
      ORDER BY EMAIL
    )
  ) AS TOOLTIP
FROM ENTRY_RELATION
WHERE TITLE IS NOT NULL
GROUP BY TITLE;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET USERS RETURN USE CASE */
SELECT EMAIL,
  U_PASSWORD,
  U_ROLE,
  U_NAME,
  FINE_RATE,
  TOTAL_DAYS,
  BOOK_LIMIT,
  TOTAL_ISSUED
FROM USER_RETURN_BOOK
ORDER BY TOTAL_ISSUED DESC;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET ENTRIES USE CASE */
SELECT ID,
  EMAIL,
  BOOK_ID,
  B_CATEGORY,
  U_NAME,
  U_ROLE,
  TITLE,
  FINE_RATE,
  ISSUE_DAY,
  ACCUMULATE_DAY,
  CURRENT_FINE,
  DEADLINE,
  E_STATUS
FROM ENTRY_RELATION;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET BOOKS IN HOME PAGE USE CASE */
SELECT B.ID,
  B.TITLE,
  B.AUTHOR,
  B.B_CATEGORY,
  B.BOOK_PICTURE,
  (U.FINE_RATE * 100) AS FINE_RATE,
  U.TOTAL_DAYS,
  U.BOOK_LIMIT
FROM USER_RETURN_BOOK U,
  BOOK_ENTITY B
WHERE ID IN (
    SELECT BOOK_ID
    FROM STOCK_ENTITY
    WHERE NUM_STOCK > 0
  )
  AND B.B_STATUS = 'Available'
  AND UPPER(U.EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* ISSUE BOOK USE CASE */
declare
    u_role varchar2(10);
    u_name varchar2(30);
    limit_book_issue int := 0;
BEGIN 
    SELECT u_role, u_name into u_role, u_name from USER_ENTITY
      WHERE UPPER(email) = v('APP_USER');
    SELECT COUNT(LOWER(V('APP_USER'))) INTO limit_book_issue FROM ENTRY_RELATION
      WHERE EMAIL = LOWER(V('APP_USER'));    

    IF u_role = 'Student' AND limit_book_issue < 10 THEN 
      INSERT INTO ENTRY_RELATION VALUES (NULL, LOWER(V('APP_USER')), :P_BOOK_ID, :P_CATEGORY, 
        u_name, u_role, :P_TITLE, 0.02, SYSDATE, SYSDATE + 2, 0, SYSDATE + 7, 'In Borrow');    
      RETURN;  
    END IF;

    IF u_role = 'Teacher' AND limit_book_issue < 5 THEN 
      INSERT INTO ENTRY_RELATION VALUES (NULL, LOWER(V('APP_USER')), :P_BOOK_ID, :P_CATEGORY, 
        u_name, u_role, :P_TITLE, 0.03, SYSDATE, SYSDATE + 2, 0, SYSDATE + 14, 'In Borrow');
      RETURN;
    END IF;

    apex_error.add_error (
      p_message          => 'You have borrowed the maximum number of books allowed for your account',
      p_display_location => apex_error.c_inline_in_notification 
    );
END;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET STUDENT CREDENTIAL USE CASE */
SELECT EMAIL,
  U_PASSWORD,
  U_NAME
FROM USER_ENTITY
WHERE UPPER(EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET STUDENT IMAGE & ROLE & SUM USE CASE */
SELECT U.USER_IMAGE,
  U.MIMETYPE,
  U.FILENAME,
  S.U_ROLE,
  S.TOTAL_ISSUED
FROM STUDENT_ENTITY S
  INNER JOIN USER_ENTITY U ON S.EMAIL = U.EMAIL
WHERE UPPER(S.EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET STUDENT PRIVILEGE */
SELECT TOTAL_DAYS,
  BOOK_LIMIT
FROM STUDENT_ENTITY
WHERE UPPER(EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* STUDENT FORM CREATE */
SELECT EMAIL,
  U_PASSWORD,
  U_ROLE,
  U_NAME,
  USER_IMAGE,
  MIMETYPE,
  FILENAME,
  CREATED_DATE
FROM USER_ENTITY;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* TEACHER FORM CREATE */
SELECT EMAIL,
  U_PASSWORD,
  U_ROLE,
  U_NAME,
  USER_IMAGE,
  MIMETYPE,
  FILENAME,
  CREATED_DATE
FROM USER_ENTITY;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* TEACHER CREDENTIAL USE CASE */
SELECT EMAIL,
  U_PASSWORD,
  U_NAME
FROM USER_ENTITY
WHERE UPPER(EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET TEACHER IMAGE & ROLE & SUM USE CASE */
SELECT U.USER_IMAGE,
  U.MIMETYPE,
  U.FILENAME,
  S.U_ROLE,
  S.TOTAL_ISSUED
FROM TEACHER_ENTITY S
  INNER JOIN USER_ENTITY U ON S.EMAIL = U.EMAIL
WHERE UPPER(S.EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET TEACHER PRIVILEGE USE CASE */
SELECT TOTAL_DAYS,
  BOOK_LIMIT
FROM TEACHER_ENTITY
WHERE UPPER(EMAIL) = V('APP_USER');
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* BOOK MANAGEMENT > MODAL > FORM CREATE */
SELECT EMAIL,
  U_PASSWORD,
  U_ROLE,
  U_NAME,
  USER_IMAGE,
  MIMETYPE,
  FILENAME,
  CREATED_DATE
FROM USER_ENTITY;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* DELETE USER USE CASE */
BEGIN
  DECLARE
    IS_BOOK_EXIST INT := 0;
    IS_USER_EXIST INT := 0;
  BEGIN
    SELECT COUNT(*) INTO IS_BOOK_EXIST FROM ENTRY_RELATION WHERE BOOK_ID = :BOOK_ID;
    SELECT COUNT(*) INTO IS_USER_EXIST FROM ENTRY_RELATION WHERE email = :USER_EMAIL;
    
    IF :USER_EMAIL IS NOT NULL AND IS_USER_EXIST = 0 THEN    
      DELETE FROM USER_ENTITY WHERE EMAIL = :USER_EMAIL;
      RETURN;
    ELSIF :BOOK_ID IS NOT NULL AND IS_BOOK_EXIST = 0 THEN 
      DELETE FROM BOOK_ENTITY WHERE ID = :BOOK_ID;
      RETURN;
    ELSE 
      apex_error.add_error (
        p_message          => 'Cannot be deleted because it is currently has book issue in entry',
        p_display_location => apex_error.c_inline_in_notification 
      );
  END IF;
  END;
END;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 


/* GET USERS USE CASE */
SELECT EMAIL,
  U_PASSWORD,
  U_ROLE,
  U_NAME,
  dbms_lob.getlength(USER_IMAGE) AS USER_IMAGE,
  MIMETYPE,
  FILENAME,
  CREATED_DATE,
  NULL AS DELETE_ACTION
FROM USER_ENTITY;
/* ═══════════════════════════════════════ END OF QUERY ═══════════════════════════════════════ */ 
