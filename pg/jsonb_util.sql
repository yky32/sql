-- Functions
CREATE EXTENSION IF NOT EXISTS pg_trgm;

--- 26Feb Deployed˜
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
--- 要從 tenant 表中移除整個 settlements 字段,可以使用以下 SQL 語句:

UPDATE tenant
SET metadata = metadata - 'settlements'
WHERE id = 7146406928892035072;

--- 這條 SQL 語句使用 metadata - 'settlements' 從 metadata 欄位中移除 'settlements' 屬性。
--- 以前的語句 jsonb_set(metadata, '{settlements}', '[]', true) 是將 settlements 字段設為空數組 []。但如果你想完全移除這個字段,可以使用上面的語句。
--- 這樣就可以從 tenant 表中的指定 id 記錄中移除整個 settlements 字段。

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