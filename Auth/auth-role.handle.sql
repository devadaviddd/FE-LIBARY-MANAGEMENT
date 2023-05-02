/* WHEN USER LOAD HOME PAGE THIS QUERY WILL EXECUTE FIRST*/
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

/* WHEN USER LOAD PROFILE PAGE THIS QUERY WILL EXECUTE FIRST*/
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

/* WHEN USER LOAD BOOKS ISSUE PAGE THIS QUERY WILL EXECUTE FIRST*/
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