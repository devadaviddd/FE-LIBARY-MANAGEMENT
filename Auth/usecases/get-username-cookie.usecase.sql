:P9999_USERNAME := apex_authentication.get_login_username_cookie;
:P9999_REMEMBER := case when :P9999_USERNAME is not null then 'Y' end;