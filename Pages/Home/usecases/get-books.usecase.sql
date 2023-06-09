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