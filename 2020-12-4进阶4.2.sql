#二、分组函数
/*
功能：用作统计使用，又称为聚合函数或统计函数或组函数

分类：
sum、avg、max、min、count

特点：
1. sum, avg一般处理数值类型
   max，min，count可以处理任何数据类型
2. 以上分组函数均忽略null：
3. 可以和distinct搭配实现去重的运算
4. 一般用count(*)来统计行数
5. 和分组函数一同查询的字段要求是group by 后的字段

*/

#1. 简单的使用：
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

SELECT SUM(salary) 和, ROUND(AVG(salary),2) 平均 FROM employees

#2. 参数支持哪些类型 count 计算非空的个数，
SELECT MAX(last_name),MIN(last_name) FROM employees;

SELECT MAX(`hiredate`),MIN(`hiredate`) FROM employees;

#3. 是否忽略null
#4. 和distinct搭配
SELECT COUNT(DISTINCT salary), COUNT(salary) FROM employees; #57, 107

#5. count函数的详细介绍
SELECT COUNT(*) FROM employees; #一般用来统计行数
SELECT COUNT(1) FROM employees; #一般用来统计行数，count中加任意一个常量值都可以

/*
效率：
MYISAM存储引擎下：count(*)的效率高
INNODB存储引擎下，count(*)和count(1)效率差不多，但是比count(字段)要高一些
*/

#6. 和分组函数一同查询的字段有限制

SELECT DATEDIFF(MAX(hiredate), MIN(hiredate))AS DIFFERENCE FROM employees;

SELECT COUNT(*) FROM employees
WHERE department_id = 90;







