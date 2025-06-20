-- 1)
SELECT DISTINCT P.address
FROM Property P
JOIN Listings L ON P.address = L.address
JOIN House H ON P.address = H.address;
-- 2)
SELECT DISTINCT P.address, L.mlsNumber
FROM Property P
JOIN Listings L ON P.address = L.address
JOIN House H ON P.address = H.address;
-- 3)
SELECT DISTINCT P.address
FROM Property P
JOIN Listings L ON P.address = L.address
JOIN House H ON P.address = H.address
WHERE H.bedrooms = 3 AND H.bathrooms = 2;
-- 4)
SELECT DISTINCT P.address, P.price
FROM Property P
JOIN Listings L ON P.address = L.address
JOIN House H ON P.address = H.address
WHERE H.bedrooms = 3 AND H.bathrooms = 2 AND P.price BETWEEN 100000 AND 250000
ORDER BY P.price DESC;
-- 5)
SELECT DISTINCT P.address, P.price
FROM Property P
JOIN Listings L ON P.address = L.address
JOIN BusinessProperty B ON P.address = B.address
WHERE B.type = 'Office'
ORDER BY P.price DESC;
-- 6)
SELECT A.agentId, A.name AS AgentName, A.phone AS AgentPhone, F.name AS FirmName, A.dateStarted
FROM Agent A
JOIN Firm F ON A.firmId = F.id;
-- 7)
SELECT DISTINCT P.address, P.price, L.mlsNumber
FROM Property P
JOIN Listings L ON P.address = L.address
WHERE L.agentId = '001';
-- 8)
SELECT A.name AS AgentName, B.name AS BuyerName
FROM Agent A
JOIN Works_With W ON A.agentId = W.agentId
JOIN Buyer B ON W.buyerId = B.id
ORDER BY A.name;
-- 9)
SELECT A.agentId, COUNT(W.buyerId) AS BuyerCount
FROM Agent A
LEFT JOIN Works_With W ON A.agentId = W.agentId
GROUP BY A.agentId;
-- 10)
SELECT DISTINCT P.address, P.price
FROM Property P
JOIN Listings L ON P.address = L.address
JOIN House H ON P.address = H.address
JOIN Buyer B ON B.id = '001'
WHERE B.propertyType = 'House'
  AND (B.bedrooms IS NULL OR H.bedrooms = B.bedrooms)
  AND (B.bathrooms IS NULL OR H.bathrooms = B.bathrooms)
  AND (B.minimumPreferredPrice IS NULL OR P.price >= B.minimumPreferredPrice)
  AND (B.maximumPreferredPrice IS NULL OR P.price <= B.maximumPreferredPrice)
ORDER BY P.price DESC;