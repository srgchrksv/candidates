SELECT 
    u.name,
    s.interview_status
FROM fact_interviews AS f
    JOIN dim_user AS u ON f.user_id = u.user_id
    JOIN dim_document AS doc ON u.document_id = doc.document_id
    JOIN dim_interview_status AS s ON f.interview_status_id = s.interview_status_id
    JOIN dim_date AS d ON doc.document_expiry_date_id = d.date_id
WHERE s.interview_status = 'Passed' AND (
    
        d.date > NOW()
        OR doc.document_id IS NOT NULL
        OR u.name IS NOT NULL
    
)