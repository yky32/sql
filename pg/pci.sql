SELECT l.scope,
       l.log_scope,
       l.domain,
       l.event,
       l.content -> 'metadata',
       l.request_body,
       l.request_body -> 'pan',
       l.response_body,
       l.response_body -> 'data' ->> 'cardNumber'
FROM log l
WHERE l.domain = 'checkout'
  AND l.event = 'checkout.kvb-payment-method.create'
;


-- metadata
UPDATE log l
SET content = jsonb_set(l.content, '{metadata, maskedPan}',
                        to_jsonb(concat(
                                substring(l.content -> 'metadata' ->> 'pan' for 6),
                                '******',
                                substring(l.content -> 'metadata' ->> 'pan' from 13 for 4)
                                 )))
WHERE l.content -> 'metadata' IS NOT NULL
AND l.domain = 'checkout'
AND l.event = 'checkout.kvb-payment-method.create';


UPDATE log l
SET content = jsonb_set(l.content, '{metadata, pan}',
                        to_jsonb(concat(
                                substring(l.content -> 'metadata' ->> 'pan' for 6),
                                '******',
                                substring(l.content -> 'metadata' ->> 'pan' from 13 for 4)
                                 )))
WHERE l.content -> 'metadata' IS NOT NULL
AND l.domain = 'checkout'
AND l.event = 'checkout.kvb-payment-method.create';

UPDATE log l
SET content = jsonb_set(l.content, '{metadata, cardNumber}',
                        to_jsonb(concat(
                                substring(l.content -> 'metadata' ->> 'pan' for 6),
                                '******',
                                substring(l.content -> 'metadata' ->> 'pan' from 13 for 4)
                                 )))
WHERE l.content -> 'metadata' IS NOT NULL
  AND l.domain = 'checkout'
  AND l.event = 'checkout.kvb-payment-method.create';



-- request_body
UPDATE log l
SET request_body = jsonb_set(l.request_body, '{pan}',
                             to_jsonb(concat(
                                     substring(l.request_body ->> 'pan' for 6),
                                     '******',
                                     substring(l.request_body ->> 'pan' from 13 for 4)
                                      )))
WHERE l.domain = 'checkout'
  AND l.event = 'checkout.kvb-payment-method.create';

-- response_body
UPDATE log l
SET request_body = jsonb_set(l.response_body, '{data, cardNumber}',
                             to_jsonb(concat(
                                     substring(l.response_body -> 'data' ->> 'cardNumber' for 6),
                                     '******',
                                     substring(l.response_body -> 'data' ->> 'cardNumber' from 13 for 4)
                                      )))
WHERE l.domain = 'checkout'
  AND l.event = 'checkout.kvb-payment-method.create';