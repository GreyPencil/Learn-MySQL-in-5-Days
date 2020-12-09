#标识列（自增长列）
/*
含义：可以不用手动的插入值，系统提供默认的序列值

特点：
1. 标识列必须和主键搭配吗？
	不一定，但要求是一个key（主键或唯一）
	
2. 一个表最多只能有一个标识列
3. 标识列的类型，只能是数值型
4. 标识列可以通过 set auto_increment_increment设置步长
   也可以同过手动插入

*/
#一、创建表时设置标识列

CREATE TABLE tab_identity(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(20)
);

INSERT INTO tab_identity VALUES (NULL,'john');
INSERT INTO tab_identity(NAME) VALUES ('Lily');

SELECT * FROM tab_identity;
SHOW VARIABLES LIKE '%auto_increment%';
SET auto_increment_increment =3; #修改步长

#二、修改表时设置标识列

CREATE TABLE tab_identity(
	id INT,
	NAME VARCHAR(20)
);

ALTER TABLE tab_identity MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;

#三、修改表时删除标识列
ALTER TABLE tab_identity MODIFY COLUMN id INT;