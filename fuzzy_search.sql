-- fuzzy tuning
select
        similarity(lower(CAST(p1_0.hash as text)),'refund') as hash,
        similarity(lower(CAST(p1_0.currency as text)),'refund') as currency,
        p1_0.status,
        similarity(lower(CAST(p1_0.status as text)),'refund') as status,
        p1_0.type,
        p1_0.metadata,
        p1_0.status,
        similarity(lower(CAST(p1_0.type as text)),'refund') as type,
        similarity(lower(CAST(p1_0.id as text)),'refund') as id,
        similarity(lower(CAST(p1_0.amount as text)),'refund') as amount,
        similarity(lower(CAST(p1_0.transaction_type as text)),'refund') as transaction_type
from payment p1_0
where 1=1
  and (
        similarity(lower(cast(p1_0.type as text)),'refund')>= 0.55
        or similarity(lower(cast(p1_0.status as text)),'refund')>=0.55
        or similarity(lower(cast(p1_0.currency as text)),'refund')>=0.55
        or similarity(lower(cast(p1_0.hash as text)),'refund')>= 0.55
        or similarity(lower(cast(p1_0.transaction_type as text)),'refund')>=0.55
        or similarity(lower(cast(p1_0.amount as text)),'refund')>= 0.55
        or similarity(lower(cast(p1_0.id as text)),'refund') >= 0.55
    )
;
