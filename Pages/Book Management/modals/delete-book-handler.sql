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