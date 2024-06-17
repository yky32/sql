-- All pi related COS
SELECT cs.hash, cs.ref_hash, cs.status
FROM checkout_session cs
where ref_hash in (
    SELECT pi.hash
    FROM payment_instruction pi
    );
-- PM
-- pm_7208155155756220416 - 4242424242424241
-- pm_7207212035531079680 - 4242424242424242
-- pm_7207334239925174272 - 4242424242424242

-- Step1. Valid Subscriptions
SELECT
    pi.status,
    pi.payment_method_id,
    pi.hash,
    pi.end_dt,
    pi.next_payment_dt,
    pi.previous_payment_dt,pi.attempts, pi.index
FROM payment_instruction pi;

-- Step2. Generated COS
SELECT
    cs.hash, cs.ref_hash, cs.status,
    cs.metadata -> 'subscription' ->> 'paymentMethodId' as paymentMethodId,
    cs.attempts,
    cs.type,
    cs.completed_dt, cs.nature
FROM checkout_session cs
where type = 'SUBSCRIPTION'
AND status in ('OPEN', 'EXPIRED')
ORDER BY cs.create_dt desc
;

SELECT * FROM checkout_session cs
where cs.hash LIKE  'gg6eb2696a57a5c17814731345e18bgg-2%';

-- Step3. Payment Details.
SELECT p.status, p.hash, p.ref_hash
FROM payment p
WHERE type = 'SUBSCRIPTION_CHECKOUT'
AND (p.hash in ('gg6eb2696a57a5c17814731345e18bgg-2')
OR p.ref_hash in  ('gg6eb2696a57a5c17814731345e18bgg-2'))
ORDER BY p.create_dt desc;