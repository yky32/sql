select
    pm.metadata -> payer
from payment p
left join payment_method pm
on p.payment_method_id = pm.id;