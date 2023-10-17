use lb;
create table Suppliers (sid  integer, sName varchar(20), address varchar(20));
alter table Suppliers add primary key(sid);
insert into Suppliers
values
(1,'Goutham','chennai'),
(2,'Ajith','tirupathi'),
(3,'Vishal','hyderabad'),
(4,'Vijay','chennai'),
(5,'Ashok','bangalore');


create table Parts 
(pid integer, pName varchar(20), color varchar(20));
alter table Parts add primary key(pid);
insert into parts 
values
(1,'engine','red'),
(2,'gear','green'),
(3,'wheels','red'),
(4,'tyres','blue'),
(5,'tyres','blue');


create table Catalog
(sid integer, pid integer, cost real);
alter table Catalog add primary key(sid,pid);
insert into Catalog 
values
(1,1,10000),
(2,2,20000),
(3,3,30000),
(4,4,20000),
(5,5,10000);
select * from parts;
select * from catalog;
select * from suppliers;


-- a
SELECT sName FROM suppliers
WHERE sid IN (SELECT sid FROM catalog WHERE pid IN (SELECT pid FROM parts WHERE color = 'red'));

-- b
select sid from suppliers
WHERE sid IN (SELECT sid FROM catalog WHERE pid IN (SELECT pid FROM parts WHERE color = 'red' and address='chennai'));

-- c
SELECT s.sName AS SupplierName, AVG(c.cost) AS AverageCost
FROM suppliers s
INNER JOIN catalog c ON s.sid = c.sid
INNER JOIN parts p ON c.pid = p.pid
WHERE p.color = 'red'
GROUP BY s.sName;

-- d
SELECT s.sName AS SupplierName
FROM suppliers s
JOIN catalog c ON s.sid = c.sid
GROUP BY s.sName
ORDER BY COUNT(c.pid) DESC
LIMIT 1;

-- e
SELECT DISTINCT c1.sid AS SupplierID
FROM catalog c1
WHERE NOT EXISTS (
    SELECT p.pid
    FROM parts p
    WHERE p.pid NOT IN (
        SELECT c2.pid
        FROM catalog c2
        WHERE c2.sid = c1.sid
    )
);


-- f
SELECT DISTINCT c1.sid AS SupplierID
FROM catalog c1
WHERE NOT EXISTS (
    SELECT p.pid
    FROM parts p
    WHERE p.color = 'red'
    AND p.pid NOT IN (
        SELECT c2.pid
        FROM catalog c2
        WHERE c2.sid = c1.sid
    )
);

-- g
SELECT p.color AS PartColor, COUNT(DISTINCT c.sid) AS NumberOfSuppliers
FROM parts p
LEFT JOIN catalog c ON p.pid = c.pid
GROUP BY p.color;

-- h
SELECT s.sName AS SupplierName
FROM suppliers s
JOIN catalog c ON s.sid = c.sid
JOIN parts p ON c.pid = p.pid
WHERE p.color = 'red'
ORDER BY c.cost ASC
LIMIT 1;

-- i
SELECT p1.color AS PartColor, c1.sid AS SupplierID, s.sName AS SupplierName, c1.cost AS PartCost
FROM catalog c1
INNER JOIN parts p1 ON c1.pid = p1.pid
INNER JOIN suppliers s ON c1.sid = s.sid
WHERE c1.cost = (
    SELECT MIN(c2.cost)
    FROM catalog c2
    WHERE c2.pid = c1.pid
)
ORDER BY p1.color, c1.cost;


-- j
SELECT s.sName AS SupplierName, COUNT(c.pid) AS NumberOfPartsSupplied
FROM suppliers s
LEFT JOIN catalog c ON s.sid = c.sid
GROUP BY s.sName
ORDER BY NumberOfPartsSupplied DESC;

-- k
SELECT s.sid AS SupplierID, s.sName AS SupplierName, c.pid AS PartID, p.color AS PartColor, c.cost AS PartCost
FROM suppliers s
JOIN catalog c ON s.sid = c.sid
JOIN parts p ON c.pid = p.pid
WHERE c.cost = (SELECT MAX(cost) FROM catalog)
LIMIT 1;

-- l
SELECT s.sName AS SupplierName
FROM suppliers s
JOIN catalog c ON s.sid = c.sid
GROUP BY s.sName
HAVING COUNT(c.pid) >= 2;
