SELECT fcr.request_id
    , frtl.responsibility_name
    , fcpt.user_concurrent_program_name
    , fcr.argument_text
    , fcr.actual_start_date
    , fcr.actual_completion_date
    , fnd.user_name
    , fe.execution_file_name
FROM apps.fnd_concurrent_programs_tl fcpt
    , apps.fnd_concurrent_programs fcp
    , apps.fnd_concurrent_requests fcr
    , apps.fnd_executables fe
    , apps.fnd_responsibility_tl frtl
    , apps.fnd_user fnd
WHERE fcpt.concurrent_program_id = fcp.concurrent_program_id
  AND fcp.concurrent_program_id = fcr.concurrent_program_id
  AND fcp.executable_id = fe.executable_id
  AND fcr.responsibility_id = frtl.responsibility_id
  AND fcr.requested_by = fnd.user_id
  AND trunc(fcr.actual_start_date) BETWEEN to_date('&start_date', 'DD-MON-YYYY') AND to_date('&end_date', 'DD-MON-YYYY')
ORDER BY request_id DESC;