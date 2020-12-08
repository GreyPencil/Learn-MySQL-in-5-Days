#DDL
/*
数据定义语言

库和表的管理

一、库的管理
创建、修改、删除
二、表的管理
创建、修改、删除

创建：create
修改：alter
删除：drop

*/

#一、库的管理
#1.库的创建

/*
create database [if not exists]库名；
库的删除
drop database [if exists] 库名
*/

#案例：创建库Books

CREATE DATABASE IF NOT EXISTS Books;

#2. 库的修改
#一般不改名
#更改库的字符集

ALTER DATABASE books CHARACTER SET gbk;

#3. 库的删除
DROP DATABASE IF EXISTS books;

#二、表的管理
#1.表的创建（❤）
/*

create talbe 表名（
	列名 列的类型【（长度） 约束】，
	列名 列的类型【（长度） 约束】，
	列名 列的类型【（长度） 约束】，
	列名 列的类型【（长度） 约束】，
	。。。
	列名 列的类型【（长度） 约束】，

）

*/


#案例：创建表Book

CREATE TABLE book(
	id INT,
	bName VARCHAR(50),
	price DOUBLE,
	authorId INT,
	publishDate DATETIME
);

DESC book;

CREATE TABLE IF NOT EXISTS author (
	Id INT,
	au_name VARCHAR(50),
	nation VARCHAR(20)
);

DESC author;

#2.表的修改
/*
alter table 表名 add|drop|modify|change column

alter table 表名 rename to 


*/

#2-1.修改列名字 其中column可以省略

ALTER TABLE book CHANGE COLUMN publishdate pubDate DATETIME;

#2-2.修改列的类型或约束

ALTER TABLE book MODIFY COLUMN pubDate TIMESTAMP;

#2-3.添加新列

ALTER TABLE author ADD COLUMN annual DOUBLE;

#2-4.删除列

ALTER TABLE author DROP COLUMN annual;


#2-5.修改表名

ALTER TABLE author RENAME TO book_author;

#3. 表的删除

DROP TABLE IF EXISTS book_author;

SHOW TABLES;

#通用的写法：

DROP DATABASE IF EXISTS 旧库名；
CREATE DATABASE 新库名； 

DROP TABLE IF EXISTS 旧表名；
CREATE DATABASE 新表名（）;

#4.表的复制

INSERT INTO author VALUES 
(1, '村上春树','日本'),
(2, '莫言','中国'),
(3, '冯唐','中国'),
(4, '古龙','中国');

SELECT * FROM author;
DESC author;


#4-1.仅仅复制表的结构  没有数据

CREATE TABLE copy LIKE author;

#4-2.复制表的结构+数据

CREATE TABLE copy2
SELECT * FROM author;

SELECT * FROM copy2;

#4-3. 复制部分

CREATE TABLE copy3
SELECT id, au_name
FROM author
WHERE nation='中国';

SELECT *FROM copy3;


CREATE TABLE copy4
SELECT id, au_name
FROM author
WHERE 0; #or 1=2, o 代表false

DROP TABLE IF EXISTS copy4;

SELECT* FROM copy4;




