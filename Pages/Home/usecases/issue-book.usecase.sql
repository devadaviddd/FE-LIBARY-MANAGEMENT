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



