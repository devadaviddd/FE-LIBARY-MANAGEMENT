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