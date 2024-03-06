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


-- ETL SQL: Pcolle on 0201-0215 ('SALES', 'REFUND')
SELECT tenant_id                AS tenantId,
       transaction_type         as transactionType,
       p.metadata -> 'tenantContext' -> 'name' ->> 'en' as store,
       metadata ->> 'cardBrand' AS cardBrand,
       currency,
       sum(amount)              AS amount,
       status,
       COUNT(*)                 AS counter
FROM payment p
WHERE tenant_id = 7142615941312937984
  AND transaction_type IN ('SALES', 'REFUND')
  AND currency IN ('JPY')
  AND mode = 'LIVE'
  AND p.create_dt >= '2024-01-31 15:00:00'
  AND p.create_dt < '2024-02-15 15:00:00'
GROUP BY tenant_id,
         transaction_type,
         currency,
         cardBrand,
         store,
         status
;

-- ETL SQL: Pcolle on 0216-0229
SELECT tenant_id                AS tenantId,
       transaction_type         as transactionType,
       p.metadata -> 'tenantContext' -> 'name' ->> 'en' as store,
       metadata ->> 'cardBrand' AS cardBrand,
       currency,
       sum(amount)              AS amount,
       status,
       COUNT(*)                 AS counter
FROM payment p
WHERE tenant_id = 7142615941312937984
  AND transaction_type IN ('SALES', 'REFUND')
  AND currency IN ('JPY')
  AND mode = 'LIVE'
  AND p.create_dt >= '2024-02-15 15:00:00'
  AND p.create_dt < '2024-02-29 15:00:00'
GROUP BY tenant_id,
         transaction_type,
         currency,
         cardBrand,
         store,
         status
;

-- ETL SQL: Brand Choice on 0216-0229
SELECT tenant_id                AS tenantId,
       transaction_type         as transactionType,
       p.metadata -> 'tenantContext' -> 'name' ->> 'en' as store,
       metadata ->> 'cardBrand' AS cardBrand,
       currency,
       sum(amount)              AS amount,
       status,
       COUNT(*)                 AS counter
FROM payment p
WHERE tenant_id = 7143280938976280576
  AND transaction_type IN ('SALES', 'REFUND')
  AND currency IN ('JPY')
  AND mode = 'LIVE'
  AND p.create_dt >= '2024-02-15 15:00:00'
  AND p.create_dt < '2024-02-29 15:00:00'
GROUP BY tenant_id,
         transaction_type,
         currency,
         cardBrand,
         store,
         status
;