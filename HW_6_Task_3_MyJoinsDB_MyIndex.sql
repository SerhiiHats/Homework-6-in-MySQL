DROP DATABASE MyJoinsDB;

CREATE DATABASE MyJoinsDB;

USE myjoinsdb;

CREATE TABLE Employees (
id_emp INT AUTO_INCREMENT PRIMARY KEY,               -- id_emp - является кластерезированным индексом --
name_emp VARCHAR(50) NOT NULL,
phone_emp VARCHAR(15) NOT NULL UNIQUE);              -- phone_emp - является некластерезированным индексом в упорядоченной таблице --

CREATE INDEX name_emp ON Employees (name_emp);       -- ДОБАВЛЕН ИНДЕКС - name_emp - будет являться некластерезированным индексом в упорядоченной таблице к полю (name_emp) --
                                                     -- он необходим т.к. ускорит поиск сотрудника по имени сотрудника

CREATE TABLE Title_jobs (
id_job INT AUTO_INCREMENT PRIMARY KEY,               -- id_job - является кластерезированным индексом --
id_emp INT NOT NULL,                                 -- id_job - является некластерезированным индексом --
salary_job DOUBLE NOT NULL DEFAULT 0,
title_job VARCHAR(30) NOT NULL DEFAULT 'Trenee',
FOREIGN KEY (id_emp) REFERENCES Employees (id_emp));

ALTER TABLE Title_jobs ADD                            -- ДОБАВЛЕН ИНДЕКС - title_job - будет являться некластерезированным индексом в упорядоченной таблице к полю (title_job) --
INDEX title_job (title_job);                          -- он необходим т.к. ускорит поиск сотрудника по должности сотрудника


CREATE TABLE Description_employees (
id_des INT AUTO_INCREMENT PRIMARY KEY,                  -- id_des - является кластерезированным индексом --
id_emp INT NOT NULL UNIQUE,                             -- id_emp - является некластерезированным индексом --
married_des VARCHAR (15) NOT NULL,
birthday_des DATE NOT NULL,
address_des VARCHAR(50),
FOREIGN KEY (id_emp) REFERENCES Employees (id_emp));

ALTER TABLE Description_employees ADD                   -- ДОБАВЛЕН ИНДЕКС - married_index - будет являться некластерезированным индексом в упорядоченной таблице к полю (married_des) --
INDEX married_index (married_des);                       -- он необходим т.к. ускорит поиск сотрудника по семейному положению сотрудника

-- ALTER TABLE Description_employees DROP INDEX married_index;   -- УДАЛЕНИЕ ИНДЕКСА - married_index в таблице Description_employees --

INSERT INTO Employees (name_emp, phone_emp)
VALUES
('Буюклі Л.М', '+380678514751'),
('Даниленко Д.І', '+380679548521'),
('Чекан О.В.', '+380679512575'),
('Антоненко І.А.', '+380738529614'),
('Балева Н.О.', '+380638547596');

INSERT INTO Title_jobs (id_emp, salary_job, title_job)
VALUES 
(1, 10000.5, 'головний директор'),
(2, 8000.5, 'менеджер'),
(3, 6500.5, 'робітник'),
(4, 7800.5, 'робітник'),
(5, 5895.5, 'робітник');

INSERT INTO Description_employees (id_emp, married_des, birthday_des, address_des)
VALUES 
(1, 'not married', '1988-04-15', 'Ukraine, Odessa, Bugaivska, 5'),
(2, 'married', '1995-11-21', 'Ukraine, Odessa, Ekaterininskaya, 84'),
(3, 'not married', '1980-06-10', 'Ukraine, Odessa, Nikolaevskaya doroga, 15'),
(4, 'married', '1991-10-04', 'Ukraine, Odessa, B.Khmelnitskogo, 34'),
(5, 'not married', '1987-07-27', 'Ukraine, Odessa, Kanatnaya, 19');

SELECT * FROM Description_employees;
SELECT * FROM Description_employees WHERE married_des = 'not married';
EXPLAIN SELECT * FROM Description_employees WHERE married_des = 'not married';
SHOW INDEX FROM Description_employees;


SELECT * FROM Employees;
EXPLAIN SELECT * FROM Employees WHERE phone_emp = '+380738529614';
SHOW INDEX FROM Employees;

SELECT * FROM Title_jobs;
SELECT * FROM Title_jobs WHERE id_job = 3;
EXPLAIN SELECT * FROM Title_jobs WHERE id_job = 3;
SELECT * FROM Title_jobs WHERE id_emp = 4;
EXPLAIN SELECT * FROM Title_jobs WHERE id_emp = 4;
SELECT * FROM Title_jobs WHERE title_job = 'робітник';
EXPLAIN SELECT * FROM Title_jobs WHERE title_job = 'робітник';
SHOW INDEX FROM Title_jobs;