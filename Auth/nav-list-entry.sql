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