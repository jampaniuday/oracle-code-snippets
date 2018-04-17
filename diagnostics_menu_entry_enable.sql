DECLARE

    l_level_name VARCHAR2(100);
    l_level_value_name VARCHAR2(100);
    l_level_value NUMBER(10);
    
    l_progress_flag BOOLEAN;

begin

-- APPL, RESP or USER
l_level_name := 'USER';

-- Application, Responsibility or User Name
l_level_value_name := '&level_value_name';

l_level_value_name := upper(l_level_value_name);

if l_level_name = 'USER' THEN
    
    SELECT user_id
    INTO l_level_value
    FROM apps.fnd_user
    WHERE upper(user_name) = l_level_value_name;
    
    l_progress_flag := TRUE;
    
else
    l_progress_flag := FALSE;
    
end if;

if l_progress_flag THEN

    if fnd_profile.save(X_NAME => 'FND_HIDE_DIAGNOSTICS',
                     X_VALUE => 'N',
                     X_LEVEL_NAME => l_level_name,
                     X_LEVEL_VALUE => l_level_value) then
   
        dbms_output.put_line('FND_HIDE_DIAGNOSTICS updated to N for ' || l_level_name || + ' ' || l_level_value_name);
    else
        dbms_output.put_line('Fail');
    end if;
 
    if fnd_profile.save(X_NAME => 'DIAGNOSTICS',
                     X_VALUE => 'Y',
                     X_LEVEL_NAME => l_level_name,
                     X_LEVEL_VALUE => l_level_value) then
   
        dbms_output.put_line('DIAGNOSTICS updated to Y for ' || l_level_name || + ' ' || l_level_value_name);
    else
        dbms_output.put_line('Fail');
    end if;
 else
    dbms_output.put_line('Cannot update FND_PROFILE_OPTIONS, information entered is invalid');
 end if;
 
 commit;
end;
