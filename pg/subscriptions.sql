SELECT pi.next_payment_dt, pi.previous_payment_dt,  pi.hash, pi.attempts, pi.index
FROM payment_instruction pi;

-- All pi related COS
SELECT cs.hash, cs.ref_hash, cs.status
FROM checkout_session cs
where ref_hash in (
    SELECT pi.hash
    FROM payment_instruction pi
    );

SELECT cs.hash, cs.ref_hash, cs.status
FROM checkout_session cs where type = 'SUBSCRIPTION';

SELECT p.status, p.hash, p.ref_hash
FROM payment p
WHERE type = 'SUBSCRIPTION_CHECKOUT'
ORDER BY p.create_dt desc;