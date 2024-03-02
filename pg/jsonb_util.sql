--- 26Feb Deployed
UPDATE payment
SET payer = payment_method.payer
FROM payment_method
WHERE payment.payment_method_id = payment_method.id
  AND payment.payer IS NULL
;

select
    metadata -> 'settlement'
from tenant
where type = 'SUB_TENANT'
;

-------- delete a field
UPDATE tenant
SET metadata = jsonb_set(metadata, '{settlements}', '[]', true)
WHERE type = 'SUB_TENANT'
;

UPDATE tenant
SET metadata = metadata - 'settlement'
;


----- UPDATE fields
UPDATE tenant t
SET metadata = jsonb_set(t.metadata, '{productSetting, paymentGatewaySetting, webhookUrls}', '[]', true)
WHERE t.key != 'tk_953903f3b1adbb850b53f0a70b1292e2';


UPDATE tenant t
SET metadata = metadata - '{productSetting, paymentGatewaySetting, webhookUrls}'
WHERE condition;
