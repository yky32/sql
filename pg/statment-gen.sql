select
    p.id,
    p.amount,
    p.status,
    p.transaction_type,
    p.metadata -> 'tenantContext' -> 'name' ->> 'en' as store_name,
    p.metadata ->> 'embosserName' as embosser_name,
    p.type,
    p.create_dt,
    p.update_dt
from payment p
where p.tenant_id = 7142615941312937984
and p.create_dt >= '2024-01-01'
and p.create_dt <= '2024-02-01'
;



SELECT
    tenant_id AS tenantId,
    transaction_type as transactionType,
    metadata ->> 'cardBrand' AS cardBrand,
    currency,
    sum(amount) AS amount,
    status,
    COUNT(*) AS counter
FROM payment p
WHERE tenant_id = 7143280938976280576
  AND transaction_type = 'SALES'
  AND currency = 'JPY'
  AND mode = 'LIVE'
  and p.create_dt >= '2024-01-31'
  and p.create_dt <= '2024-02-15'
GROUP BY
    tenant_id, transaction_type,
    currency, cardBrand, status;


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
  and p.create_dt <= '2024-01-31'