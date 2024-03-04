-- export statement data
-- 7143280938976280576 = brand_choice
-- 7142615941312937984 = pcolle
select
    p.id,
    p.amount,
    p.status,
    p.transaction_type,
    p.metadata -> 'tenantContext' -> 'name' ->> 'en' as store,
    p.metadata ->> 'embosserName' as embosser_name,
    p.type,
    p.create_dt,
    p.update_dt
from payment p
where p.tenant_id in
(7143280938976280576)
and p.create_dt >= '2024-02-15 15:00:00'
and p.create_dt < '2024-02-29 15:00:00'
;


-- Pcolle on 0201-0215
SELECT
    '2024-01-31 15:00:00' as startDt,
    '2024-02-15 15:00:00' as endDt,
    p.metadata -> 'tenantContext' -> 'name' ->> 'en' as store,
    tenant_id AS tenantId,
    transaction_type as transactionType,
    currency,
    sum(amount) AS amount,
    status,
    COUNT(*) AS counter
FROM payment p
WHERE tenant_id = 7142615941312937984
  AND transaction_type in ('SALES')
  AND currency = 'JPY'
  AND mode = 'LIVE'
  and p.create_dt >= '2024-01-31 15:00:00'
  and p.create_dt < '2024-02-15 15:00:00'
  AND status in ('COMPLETED', 'REFUNDED', 'REJECTED')
GROUP BY
    tenant_id, transaction_type,
    currency, status, store
;


SELECT
    tenant_id AS tenantId,
    transaction_type as transactionType,
    metadata ->> 'cardBrand' AS cardBrand,
    currency,
    status,
    p.create_dt
FROM payment p
WHERE tenant_id = 7142615941312937984
  AND currency = 'JPY'
  AND mode = 'LIVE'
  and p.create_dt >= '2024-01-01'
  and p.create_dt <= '2024-03-31';

------
select
    p.id,
    p.hash,
    p.amount,
    p.mode,
    p.status,
    p.transaction_type,
    p.metadata -> 'tenantContext' -> 'name' ->> 'en' as store_name,
    p.metadata ->> 'embosserName' as embosser_name,
    p.type,
    p.create_dt,
    p.update_dt
from payment p
WHERE tenant_id = 7142615941312937984
  AND transaction_type = 'SALES'
  AND currency = 'JPY'
  AND mode = 'LIVE'
  and p.create_dt >= '2023-12-31 15:00:00'
  and p.create_dt <= '2024-01-31 15:00:00'
  and p.status in ('REFUNDED')
;