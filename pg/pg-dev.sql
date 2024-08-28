-- PG 15
ALTER DATABASE uaa OWNER TO uaa;

select
    p.id,
    p.metadata,
    p.payer
from payment p
left join payment_method pm
on p.payment_method_id = pm.id
;

UPDATE payment
SET payer = payment_method.payer
FROM payment_method
WHERE payment.payment_method_id = payment_method.id
  AND payment.payer IS NULL
;

-- fuzzy tuning
select
    p.hash,
    similarity(lower(p.hash), 'f2b8cbaac5fefbbd2bd10c5e'),
    CAST(p.metadata -> 'embosserName' as text),
    CAST(p.payer -> 'email' as text),
    p.metadata -> 'embosserName',
    similarity(lower(CAST(p.metadata -> 'embosserName' as text)),'福'),
    similarity(lower(CAST(p.payer -> 'email' as text)),'akirazhonggu92') as email
from payment p
where 1=1
;
