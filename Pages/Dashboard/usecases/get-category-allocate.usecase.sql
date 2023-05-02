select B_CATEGORY, count(B_CATEGORY) value
from BOOK_ENTITY
where B_CATEGORY is not null
group by B_CATEGORY
order by 2 desc