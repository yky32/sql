SELECT
    pi.id,
    pi.hash, pi.previous_payment_dt, pi.next_payment_dt, pi.status,
    cs.hash, cs.ref_hash, cs.status,
    p.hash, p.ref_hash
FROM payment_instruction pi
JOIN checkout_session cs ON pi.hash = cs.ref_hash
LEFT JOIN payment p ON (p.hash = cs.hash OR p.ref_hash = cs.hash)
ORDER BY pi.update_dt DESC
;



SELECT
    'JPY',
    sum(p.amount),
    p.transaction_type,
    p.status
FROM payment p
WHERE
    p.currency = 'JPY' AND
    p.create_dt < '2024-11-25 15:00:00' AND
    p.create_dt < '2024-11-26 15:00:00'
GROUP BY
    p.status,
    p.transaction_type
;