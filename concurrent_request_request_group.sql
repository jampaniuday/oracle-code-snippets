SELECT frg.request_group_name, fat.application_name, frg.description, frg.request_group_code, frt.responsibility_name, cpt.user_concurrent_program_name, cpt.description
FROM apps.fnd_request_groups frg
    , apps.fnd_request_group_units frgu
    , apps.fnd_concurrent_programs_tl cpt
    , apps.fnd_application_tl fat
    , apps.fnd_responsibility fr
    , apps.fnd_responsibility_tl frt
WHERE frg.request_group_id = frgu.request_group_id
      and frgu.request_unit_id = cpt.concurrent_program_id
      and frg.application_id = fat.application_id
      AND frg.request_group_id = fr.request_group_id
      AND fr.responsibility_id = frt.responsibility_id
      and TRUNC(sysdate) between fr.start_date and nvl(fr.end_date, sysdate+ 1)
      AND cpt.user_concurrent_program_name = '&concurrent_request_name';