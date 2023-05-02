SELECT EMAIL,
  U_PASSWORD,
  U_ROLE,
  U_NAME,
  dbms_lob.getlength(USER_IMAGE) AS USER_IMAGE,
  MIMETYPE,
  FILENAME,
  CREATED_DATE,
  NULL AS DELETE_ACTION
FROM USER_ENTITY