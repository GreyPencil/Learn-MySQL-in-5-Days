#进阶1：基础查询：
/*
语法：
select 查询列表 from 表名；

类似于：System.out.println;

特点：
1. 查询列表可以是：表中的字段、常量值、表达式、函数
2. 查询的结果是一个虚拟的表格
*/

USE myemployees;

#1. 查询表中的单个字段
SELECT last_name FROM employees;

#2. 查询表中的多个字段
SELECT last_name, salary, email FROM employees;

#3. 查询表中的所有字段(可以双击表中名字，按照点击顺序排序)
#不是单引号，是着重号，键盘上在数字1旁边，用以区分关键字
 SELECT
  `employee_id`,
  `first_name`,
  `last_name`,
  `email`,
  `phone_number`,
  `job_id`,
  `salary`,
  `commission_pct`,
  `manager_id`,
  `department_id`,
  `hiredate`
FROM
  employees;

#3.2 按照默认顺序显示table
SELECT * FROM employees;

#4. 查询常量值
SELECT 100;
SELECT 'john';

#5. 查询表达式
SELECT 100%98;

#6. 查询函数
SELECT VERSION();

#7. 为字段起别名
/*
1. 便于理解
2. 如果要查询的字段有重名的情况，使用别名可以区分开来
*/
#7-1
SELECT 100%98 AS 结果;
SELECT last_name AS 姓, first_name AS 名 FROM employees;

#7-2 使用空格
SELECT last_name 姓, first_name 名 FROM empoyees;

#案例：查询salary，显示的结果为 out put。建议使用双引号引起来，以防引起歧义
SELECT salary AS "out put" FROM employees;

#8. 去重

#案例：查询员工表中涉及到的所有的部门编号：
SELECT DISTINCT department_id FROM employees;

#9. +号的作用：
/*
java中的+号：
1. 运算符：两个操作数都为数值型
2. 连接符，只要有一个操作数为字符串

mysql中的+号：
仅仅只有一个功能：运算符

select 100+90; //190 两个操作数都为数值型，则做加法运算
select '123'+90; 其中一方为字符型，试图将字符型数值转换成数值型
				如果转换成功，则继续做加法，结果为213
select 'john'+90; 结果为90
select null+10; 只要其中一个为null，则结果为null
*/

 #案例：查询员工名和姓连接成一个字段：并显示为  姓名
 SELECT CONCAT
  (last_name, " ", first_name) AS 姓名
FROM
  employees;

#10. 显示表departments的结构，并查询其中的全部数据
DESC departments;
SELECT * FROM departments;

#习题： 显示出表employees的全部列，各个列之间用逗号连接，列头显示成 OUT_PUT
SELECT CONCAT
	(`employee_id`,",",`first_name`,",",`last_name`,",",IFNULL(`commission_pct`, 0),",",`hiredate`) AS OUT_PUT
FROM
	employees;