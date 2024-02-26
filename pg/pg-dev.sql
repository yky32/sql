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
    CAST(p1_0.metadata -> 'embosserName' as text),
    similarity(lower(CAST(p1_0.metadata -> 'embosserName' as text)),'Test')
from payment p1_0
where 1=1
;
