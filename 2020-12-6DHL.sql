#DML语言 Data Manipulation Language
/*
数据操作语言：
insert
update
delete

*/
#一. insert
#方式一：经典的插入
/*
语法
inser into 表名（列名1,...）values(值1,...);
*/
SELECT * FROM beauty;

#1. 插入的值的类型要与列的类型一致或兼容
INSERT INTO beauty(id, NAME, sex, borndate, phone, photo, boyfriend_id)
VALUES (13,'唐艺昕','女','1990-4-23','18988888888',NULL, 2);


#2. 不可以为null的列必须插入值； 可以为null的列如何插入值
#方式一：
INSERT INTO beauty(id, NAME, sex, borndate, phone, photo, boyfriend_id)
VALUES (13,'唐艺昕','女','1990-4-23','18988888888',NULL, 2);

#方式二：
INSERT INTO beauty(id, NAME, sex, phone)
VALUES (15,'娜扎','女','18988888888');

#3. 列的顺序是否可以调换
INSERT INTO beauty (NAME, id, sex, phone)
VALUES ('蒋欣',16,'女','13313331333');
 
#4.列数和值的个数必须一致（column must match value count）
INSERT INTO beauty (id, NAME, sex, phone, boyfriend_id)
VALUES(17,'关晓彤','女','18888899998',8);

#5. 可以省略列名，默认所有列，并且列的顺序和表中列的顺序一致
INSERT INTO beauty
VALUES(18,'张飞','男',NULL,'119',NULL,NULL);

#方式二：
/*

语法：
insert into 表名
set 列名=值，列名=值。。。
*/

SELECT * FROM beauty;

INSERT INTO beauty
SET id=19, NAME='刘涛', borndate='1977-07-07',phone='999';


#两种方式大pk

#方式1支持插入多行，但是方式2不支持

INSERT INTO beauty
VALUES
(20, '李易峰1', '男', '1999-12-12', '112',NULL, NULL),
(21, '李易峰2', '女', '1980-11-11', '113',NULL, 3),
(22, '李易峰3', '男', '1954-3-4', '114',NULL,NULL);


#方式1支持子查询，方式2不支持

INSERT INTO beauty(id, NAME, phone)
SELECT 26, '宋茜', '12341234';

#二：修改语句
/*
1.修改单表的记录(❤)

语法：
update 表名
set 列=新值，列=新值...
where 筛选条件；

2. 修改多表的记录【补充】

语法：
sql92语法：
update 表1 别名， 表2 别名
set 列=值
where 连接条件
and 筛选条件

sql99语法：
update 表1 别名
inner[left] right join 表2 别名
on 连接条件
set 列=值...


*/

#1.修改单表的记录
#案例1：修改beauty表中姓唐的女神的电话为13899888899

UPDATE beauty 
SET phone='13899888899'
WHERE NAME LIKE '唐%';

#案例2：修改boys表中id号为2的名称为张飞，魅力值 10
UPDATE boys SET boyname='张飞', usercp=10
WHERE id=2;

#2.修改多表的记录：
#案例1：修改张无忌的女朋友的手机号为114

UPDATE boys bo
INNER JOIN beauty b
ON bo.`id`=b.`boyfriend_id`
SET b.`phone` = '114'
WHERE bo.`boyName`='张无忌';

#3.修改没有男朋友的女神的男朋友编号都为2号

UPDATE boys bo
RIGHT OUTER JOIN beauty b ON bo.`id`= b.`boyfriend_id`
SET b.`boyfriend_id`=2
WHERE b.`boyfriend_id` IS NULL;

SELECT * FROM beauty;

#三、删除语句
/*

方式一：delete
语法：

1.单表的删除【❤】
delete from 表名 where 筛选条件

2. 多表的删除【补充】

sql92语法：
delete 表1的别名，表2的别名
from 表1 别名，表2 别名
where 连接条件
and 筛选条件；


sql99语法：（❤）
delete 表1的别名，表2的别名
inner|left|right join 表2 别名 on 连接条件
where 筛选条件；



方式二：truncate
语法：truncate table 表名
*/

#方式一：delete
#1.单表的删除
#案例1：删除手机号以9结尾的女神信息

DELETE FROM beauty WHERE phone LIKE '%9';
SELECT * FROM beauty;

#2.多表的删除
#案例：删除张无忌的女朋友的信息
DELETE b
FROM beauty b
INNER JOIN boys bo ON b.`boyfriend_id`=bo.`id`
WHERE bo.`boyName`='张无忌';


#删除黄晓明的信息以及他女朋友的信息
DELETE b, bo
FROM beauty b
INNER JOIN boys bo ON b.`boyfriend_id`=bo.`id`
WHERE bo.`boyName`='黄晓明';

#方式二：truncate语句 清空数据

#案例：将魅力值>100的男神信息删除
TRUNCATE TABLE boys; #不能加类似where的条件

/*
delete VS truncate

1. delete 可以加where条件，
2. truncate删除，效率高一丢丢
3. 假如要删除的表中有自增长列，如果用delete 删除后，在插入数据，自增长列的值从断点开始
   而truncate删除后，从0开始
4. truncate删除没有返回值，delete 有返回值
5. truncate删除不能回滚，delete删除可以回滚

*/








