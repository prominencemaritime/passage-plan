SELECT
	v.id AS vessel_id,
	v.name AS vessel,
	e.id AS event_id,
	e.name AS event_name,
	d.name AS department_name,
	EXTRACT(DAY FROM NOW() - e.ended_at) AS days_ago,
	et.id AS event_type_id,
	et.name AS event_type_name,
	ed.*
FROM
	vessels v
LEFT JOIN events e
	ON e.vessel_id = v.id
LEFT JOIN event_types et
	ON et.id = e.type_id
LEFT JOIN parties p
	ON p.id = e.responsible_id
LEFT JOIN event_departments ed
	ON ed.event_id = e.id
LEFT JOIN departments d
	ON d.id = ed.department_id
WHERE
	e.deleted_at IS NULL
	AND d.name IS NOT NULL
	AND v.active = true
	--AND (NOW() - e.ended_at < INTERVAL '1 day' * 20)
	--AND et.id = '37'
ORDER BY EXTRACT(DAY FROM NOW() - e.ended_at) ASC;


SELECT
	e.id,
	e.name AS event_name,
	e.created_at,
    ed.synced_at,
    es.name AS status,
    v.email AS email
    --v.id AS vessel_id,
    --v.name AS vessel_name
FROM 
	events e
LEFT JOIN vessels v ON v.id = e.vessel_id
--LEFT JOIN vessel_subtypes vs ON vs.id = v.subtype_id
LEFT JOIN event_details ed ON ed.event_id = e.id
LEFT JOIN event_statuses es ON es.id = ed.status_id
WHERE
	e.type_id = 18--:type_id
    --AND es.id = :status_id
	--AND LOWER(e.name) LIKE :name_filter
    --AND LOWER(e.name) NOT LIKE :name_excluded
	AND ed.synced_at >= NOW() - INTERVAL '10 day' --* :lookback_days
ORDER BY
	ed.synced_at ASC;