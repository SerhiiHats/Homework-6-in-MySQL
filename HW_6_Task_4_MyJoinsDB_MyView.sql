USE myjoinsdb;

-- 1. Создайте представления для таких заданий: Необходимо узнать контактные данные сотрудников (номера телефонов, место жительства). --

CREATE VIEW Select_1_Employees AS SELECT myjoinsdb.employees.name_emp AS name, myjoinsdb.employees.phone_emp AS phone, myjoinsdb.description_employees.address_des AS address FROM myjoinsdb.employees
INNER JOIN myjoinsdb.description_employees ON myjoinsdb.description_employees.id_emp = myjoinsdb.employees.id_emp;

SELECT * FROM myjoinsdb.Select_1_Employees;


-- 2. Создайте представления для таких заданий: Необходимо узнать информацию о дате рождения всех не женатых сотрудников и номера телефонов этих сотрудников. 

CREATE VIEW Select_2_Employees AS SELECT myjoinsdb.employees.name_emp AS name, myjoinsdb.description_employees.married_des AS married, myjoinsdb.description_employees.birthday_des AS birthday, myjoinsdb.employees.phone_emp AS phone
FROM myjoinsdb.employees
INNER JOIN myjoinsdb.description_employees ON myjoinsdb.description_employees.id_emp = myjoinsdb.employees.id_emp
WHERE myjoinsdb.description_employees.married_des = 'not married';

SELECT * FROM myjoinsdb.select_2_employees;


-- 3. Создайте представления для таких заданий: Необходимо узнать информацию о дате рождения всех сотрудников с должностью менеджер и номера телефонов этих сотрудников. 

CREATE VIEW Select_3_Employees AS SELECT myjoinsdb.employees.name_emp AS name, myjoinsdb.title_jobs.title_job, myjoinsdb.description_employees.birthday_des AS birthday, myjoinsdb.employees.phone_emp AS phone 
FROM myjoinsdb.employees
INNER JOIN myjoinsdb.description_employees ON myjoinsdb.description_employees.id_emp = myjoinsdb.employees.id_emp
INNER JOIN myjoinsdb.title_jobs ON myjoinsdb.title_jobs.id_emp = myjoinsdb.employees.id_emp
WHERE myjoinsdb.title_jobs.title_job = 'менеджер';

SELECT * FROM myjoinsdb.select_3_employees;


-- 4. УСЛОЖНЕНИЕ СВОИМ ЗАДАНИЕМ 4.1. : Создайте представления для таких заданий: Необходимо узнать имена сотрудников, их должность, возраст и номера телефонов, которые старше 30 лет 
-- (т.к. у нас есть только дата рождения - возраст предстоит вычеслить).

CREATE VIEW Select_4_employees AS SELECT myjoinsdb.employees.name_emp AS name, myjoinsdb.title_jobs.title_job, timestampdiff(year,  myjoinsdb.description_employees.birthday_des, CURDATE()) AS age, myjoinsdb.employees.phone_emp AS phone FROM myjoinsdb.employees
INNER JOIN myjoinsdb.description_employees ON myjoinsdb.employees.id_emp = myjoinsdb.description_employees.id_emp
INNER JOIN myjoinsdb.title_jobs ON myjoinsdb.title_jobs.id_emp = myjoinsdb.description_employees.id_emp
WHERE timestampdiff(year, myjoinsdb.description_employees.birthday_des, CURDATE()) >= 30;

SELECT * FROM myjoinsdb.select_4_employees;


-- 5. УСЛОЖНЕНИЕ СВОИМ ЗАДАНИЕМ 5.1. : Создайте представления для таких заданий: Необходимо узнать имена сотрудников, их возраст, дату рождения и номера телефонов, 
-- возраст которых выше среднего (т.к. у нас есть только дата рождения - возраст предстоит вычеслить) и воспользоваться встроинным запросом для вычисления среднего.

CREATE VIEW Select_5_employees AS SELECT myjoinsdb.employees.name_emp AS name, myjoinsdb.description_employees.birthday_des AS birthday, timestampdiff(year, myjoinsdb.description_employees.birthday_des, CURDATE()) AS age,  myjoinsdb.employees.phone_emp AS phone FROM myjoinsdb.employees
INNER JOIN myjoinsdb.description_employees ON myjoinsdb.employees.id_emp = myjoinsdb.description_employees.id_emp
WHERE timestampdiff(year, myjoinsdb.description_employees.birthday_des, CURDATE()) >= (SELECT AVG(timestampdiff(year, myjoinsdb.description_employees.birthday_des, NOW())) AS age FROM myjoinsdb.description_employees);

SELECT * FROM myjoinsdb.select_5_employees;

SELECT AVG(timestampdiff(year, myjoinsdb.description_employees.birthday_des, NOW())) AS age FROM myjoinsdb.description_employees;


EXPLAIN SELECT * FROM myjoinsdb.select_1_employees;
EXPLAIN SELECT * FROM myjoinsdb.select_2_employees;
EXPLAIN SELECT * FROM myjoinsdb.select_3_employees;


-- DROP VIEW myjoinsdb.select_1_employees;
-- DROP VIEW myjoinsdb.select_2_employees;
-- DROP VIEW myjoinsdb.select_3_employees;
-- DROP VIEW myjoinsdb.select_4_employees;
-- DROP VIEW myjoinsdb.select_5_employees;