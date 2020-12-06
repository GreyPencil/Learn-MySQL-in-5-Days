#进阶3：排序查询
#引入
/*
语法：和执行顺序
	3--select 查询列表
	1--from 表				①
	2--【where 筛选条件】
	4--order by 排序列表 【asc|desc】

#asc升序，desc降序

特点：
	1.asc代表的是升序，desc代表的是降序
	如果不写，默认是升序
	2. order by子句中可以支持单个字段、多个字段、表达式、函数、别名
	3. order by字句执行顺序：一般是放在查询语句的最后面，limit子句除外 
*/

#案例：查询员工星系，要求工资从高到低
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY salary ASC;
#(升序的时候asc可以省略)

#案例：查询部门编号>=的员工信息，按入职时间的先后进行排序

SELECT *
FROM employees
WHERE department_id >= 90
ORDER BY hiredate ASC;

#案例：按年薪的高低显示员工的信息和 年薪 表达式排序 【按照别名排序】
SELECT *, salary*12*(1+IFNULL(`commission_pct`,0)) AS 年薪
FROM employees
ORDER BY 年薪 DESC;

#案例：按照姓名长度显示员工的姓名和工资【按函数排序】
SELECT LENGTH(last_name) AS 名字长度, last_name, salary
FROM employees
ORDER BY 名字长度 DESC;

#案例：先按工资升序，再按员工编号降序排序
SELECT *
FROM employees
ORDER BY salary ASC, employee_id DESC;