SELECT 
    u.name,
    CASE WHEN u.name IS NULL THEN True ELSE False END AS null_name,
    doc.document_id,
    CASE WHEN doc.document_id IS NULL THEN True ELSE False END AS null_document_id,
    d.date,
    CASE WHEN d.date < NOW() THEN True ELSE False END AS expired_document,
    s.interview_status
FROM fact_interviews AS f
    JOIN dim_user AS u ON f.user_id = u.user_id
    JOIN dim_document AS doc ON u.document_id = doc.document_id
    JOIN dim_interview_status AS s ON f.interview_status_id = s.interview_status_id
    JOIN dim_date AS d ON doc.document_expiry_date = d.date
WHERE (
        d.date < NOW()
        OR doc.document_id IS NULL
        OR u.name IS NULL
    )
    -- AND (s.interview_status ~* 'Passed|Pending')