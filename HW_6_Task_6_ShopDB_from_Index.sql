USE Shopdb;

DROP TABLE shopdb.customers;

CREATE TABLE customers (
CustumerNo int, 
CustumerName varchar(25),
Zip varchar(10),
State varchar(35),
City varchar(35),
Address varchar(35), 
Contact_mail varchar(50),
Phone char(13),
DateInSystem date);

SHOW INDEX FROM customers;

INSERT INTO shopdb.customers (CustumerNo, CustumerName, Zip, State, City, Address, Contact_mail, Phone, DateInSystem)
VALUES 
(1, 'Sergey', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'sergew15sergjjlk@gmail.com', '+380971543578', '2021-12-02'),
(5, 'Vadim', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'mosergew0101serg@gmail.com', '+380971547777', '2021-12-15'),
(4, 'Olga', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'sergew15078415@gmail.com', '+380971541111', '2021-11-17'),
(0, 'Sergey', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'sergew0011@gmail.com', '+380971549635', '2021-10-21'),
(3, 'Evgeniy', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'ineew1785@gmail.com', '+380971547412', '2022-01-07'),
(2, 'Alex', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'sergew15@gmail.com', '+380971549632', '2022-02-02'),
(6, 'Anastasiya', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'siyasergew15@gmail.com', '+380971541245', '2021-12-02'),
(9, 'Denis', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'nisrgew1@gmail.com', '+380971549876', '2021-11-11'),
(7, 'Sergey', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'sergew15@gmail.com', '+380971541166', '2021-12-15'),
(8, 'Konstantin', '65120', 'Ukraine', 'Odessa', 'Panteleimonovskaya, 15', 'stanrgestan@gmail.com', '+380971543388', '2022-03-07');

SELECT * FROM customers;
SELECT * FROM customers WHERE CustumerName LIKE 'serg%';
EXPLAIN SELECT * FROM customers WHERE CustumerName LIKE 'serg%';

-- из-за отсутствия индексов выборка данных происходит медленно - путем полного сканирования всей таблицы, что является нерациональным и расходоресурсным --
-- при наличии в таблице большого обьема записей, время выборки может превысить допустимое время или установленные стандарты по времени получения ответа --

DROP TABLE shopdb.customers;

CREATE TABLE customers (
CustumerNo int primary key, 
CustumerName varchar(25),
Zip varchar(10),
State varchar(35),
City varchar(35),
Address varchar(35), 
Contact_mail varchar(50),
Phone char(13),
DateInSystem date);

ALTER TABLE customers ADD INDEX custumer_name_index (CustumerName);

SELECT * FROM customers;
SELECT * FROM customers WHERE CustumerName LIKE 'serg%';
EXPLAIN SELECT * FROM customers WHERE CustumerName LIKE 'serg%';

-- после добавления индекса к колонке CustumerName, выборка данных по значению поля CustumerName происходит быстро - путем поиска данных с использованием индекса в упорядоченном бинарном дереве, --
-- что является рациональным решением и ресурсноэкономным, даже при наличии в таблице большого обьема записей, время выборки очень быстрое -- 
-- т.к. структура умеет упорядоченный индекс участвующей в выборке и указывающий на место нахождения данных --





