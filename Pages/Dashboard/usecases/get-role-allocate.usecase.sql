select U_ROLE, count(U_ROLE) value
from USER_ENTITY
where U_ROLE is not null
group by U_ROLE
order by 2 desc