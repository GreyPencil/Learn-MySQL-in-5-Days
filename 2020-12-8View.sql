
#视图：
/*

含义：虚拟表，和普通表一样使用
mysql 5.1版本出现的新特性，是通过表动态生成的数据

比如：一个班里面 分化出一个舞蹈班，有需要时，舞蹈班就可以直接出现
 
视图和表的PK：
1 创建语法不通 view  table
2 视图只占sql语句的字节，表占空间
3 视图一般不能增删改

 */

#一、创建视图
USE myemployees;

#1. 查询姓中包含a字符的员工名、部门名和工种信息
#创建
CREATE VIEW myvl
AS 

SELECT last_name, department_name, job_title
FROM employees e
JOIN departments d ON d.department_id=e.department_id
JOIN jobs j ON j.job_id = e.job_id;
#使用
SELECT * FROM myvl WHERE last_name LIKE '%a%';


#二、视图的修改：
#方式一：
/*
create or replace view 视图名
as
查询语句

*/

SELECT * FROM myv3

CREATE OR REPLACE VIEW myv3
AS 
SELECT AVG(salary), job_id
FROM employees
GROUP BY job_id;

#方式二：
/*
语法：
alter view 视图名
as
查询语句
*/

#三、删除视图
/*

语法：drop view 视图名1，视图名2,...;


*/
DROP VIEW myv1, myv2, myv3;

#四、查看使徒
DESC myv1;

SHOW CREATE VIEW myv1;


#五、视图的更新
#视图的修改

CREATE OR REPLACE VIEW myv1
AS
SELECT AVG(salary) AS average_salary,department_id
FROM employees
GROUP BY department_id;
 
ALTER VIEW myv1 
AS 
SELECT AVG(salary) ag,department_id
FROM employees
GROUP BY department_id;
 
#视图的删除
CREATE  VIEW myv2
AS
SELECT department_id
FROM employees
GROUP BY department_id;
 
DROP VIEW myv1, myv2;
#视图的查看
DESC myv2;
SHOW CREATE VIEW myv2;
SHOW CREATE VIEW myv2\G; #在 DOS中使用
 
#通过视图增删改原始表
 /*
在视图包含以下情况不能insert update delete包含以下sql语句：
1 分组函数、instinct、group by 、having 、union、union all
2 常量视图
3 select包含子查询
4 join
5 from一个不能更新的视图
6 where子句的子查询引用了from子句的表
 
*/


#具备以下特点的视图不允许更新：
#1. 包含以下关键字的sql语句：分组函数、distinct、group by、having、union或者union all
#2. 常量视图
#3. select中包含子查询
#4. join
#5. from一个不能更新的视图
#6. where子句的子查询引用了from子句中的表
 
