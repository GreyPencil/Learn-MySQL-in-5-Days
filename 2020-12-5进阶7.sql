#进阶7：子查询 号称最有难度的查询
/*
含义：
出现在其他语句中的select语句，称为子查询或内查询

外部的查询语句，称为主查询或外查询

分类：
按子查询出现的位置
	select后面：
		仅仅支持标量子查询
	from后面
		支持表子查询
	where或having后面（❤）
		标量子查询（单行） √
		列子查询  （多行）√ 
		
		行子查询
		
	exists后面（相关子查询）
		表子查询

按功能\结果集的行列数不同：
	标量子查询：结果集只有一行一列
	列子查询：结果集只有一列多行
	行子查询：结果集可以有一行多列
	表子查询：结果集一般为多行多列
*/

#一、where或having后面
#1. 标量子查询（单行子查询）
#2. 列子查询（多行子查询）
#3. 行子查询（多列多行）
/*
特点：
1. 子查询放在小括号内
2. 字长逊一般放在条件的右侧
3. 标量子查询，一般搭配着单行操作符使用
> < >= <= <>
4. 子查询的执行优先于主查询执行

列子查询，一般搭配着多行操作符使用
IN   ANY\SOME  ALL   


#非法使用标量子查询：
子查询结果不是一行一列

*/

#1. 标量子查询：
#案例1：谁的工资比Abel高？

SELECT *
FROM employees
WHERE salary>(
	SELECT salary
	FROM employees
	WHERE last_name = 'Abel'
);

#case2:返回job_id与141号员工相同，salary比143号员工多的员工 姓名、job_id 和工资

SELECT last_name, job_id, salary
FROM employees
WHERE job_id=(
	SELECT job_id
	FROM employees
	WHERE employee_id=141
)
AND salary>(
	SELECT salary
	FROM employees
	WHERE employee_id=143
);

#case3:返回公司工资最少的员工的last_name, job_id 和salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary=(
	SELECT MIN(salary)
	FROM employees
);

#case4: 查询最低工资大于50号部门最低工资的部门id和其最低工资

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary)>(
	SELECT MIN(salary)
	FROM employees
	WHERE department_id=50
);

#2. 列子查询（多行子查询）
#案例：返回location_id是1400或1700的部门中的所有员工姓名

SELECT last_name, location_id
FROM employees e
LEFT OUTER JOIN departments d
ON e.`department_id`=d.`department_id`
WHERE d.`location_id` IN (1400, 1700);


SELECT last_name
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id IN (1400, 1700)
);

#或
SELECT last_name
FROM employees
WHERE department_id = ANY(
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id IN (1400, 1700)
);


#case2: 返回其他工种比job_id为‘IT_PROG’部门任一工资低的员工的工号、姓名、job_id 和 salary

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary<ANY(
	SELECT DISTINCT salary
	FROM employees
	WHERE job_id='IT_PROG'
)AND job_id<>'IT_PROG';

#或

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary<(
	SELECT MAX(salary)
	FROM employees
	WHERE job_id='IT_PROG'
)AND job_id<>'IT_PROG';

#案例3：返回其他工种比job_id为‘IT_PROG’部门所有工资都低的员工的工号、姓名、job_id 和 salary

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary<ALL(
	SELECT DISTINCT salary
	FROM employees
	WHERE job_id='IT_PROG'
)AND job_id<>'IT_PROG';

#或

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary<(
	SELECT MIN(salary)
	FROM employees
	WHERE job_id='IT_PROG'
)AND job_id<>'IT_PROG';


#3. 行子查询（结果集——一行多列或多行多列）

#案例：查询员工编号最小而且工资最高的员工信息
SELECT *
FROM employees
WHERE (employee_id, salary)=(
	SELECT MIN(employee_id), MAX(salary)
	FROM employees
);



#二：select 后面, 仅仅支持标量子查询

#案例：查询每个部门的员工个数：
SELECT d.*, (
	SELECT COUNT(*)
	FROM employees e
	WHERE e.`department_id`=d.department_id) AS 个数
FROM departments d;


#案例2：查询员工号=102的部门名
SELECT (
	SELECT department_name
	FROM departments d
	INNER JOIN employees e
	ON e.department_id=d.department_id 
	WHERE e.employee_id=102
	) 部门名;

#三：from后面
/*
将子查询结果充当一张表，要求这张表必须起别名
*/

#案例：每个部门的平均工资的工资等级


SELECT DISTINCT avg_dep.*, g.`grade_level` 工资等级 
FROM (
	SELECT AVG(salary) AVG, department_id
	FROM employees
	GROUP BY department_id
) avg_dep
INNER JOIN job_grades g
ON avg_dep.avg BETWEEN `lowest_sal` AND `highest_sal`;



#四：exists后面（相关子查询）

SELECT EXISTS(SELECT employee_id FROM employees); #结果为布尔类型：1 表示true； 若为0，表示false

#案例：查询有员工的部门名

SELECT department_name
FROM departments d
WHERE EXISTS(
	SELECT *
	FROM employees e
	WHERE d.department_id=e.`department_id`
);


SELECT department_name
FROM departments d
WHERE d.`department_id` IN (
	SELECT department_id
	FROM employees
);

#案例2：没有女朋友的男神信息

SELECT bo.*
FROM boys bo
WHERE NOT EXISTS(
	SELECT boyfriend_id
	FROM beauty b
	WHERE b.boyfriend_id = bo.id
);


#习题：
#1. 查询和Zlotkey相同的部门的员工姓名和工资
SELECT last_name, salary
FROM employees 
WHERE department_id=(
	SELECT department_id
	FROM employees 
	WHERE last_name='Zlotkey'
);

#2. 查询工资比公司平均工资高的员工的员工号，姓名和工资
SELECT employee_id, last_name, salary
FROM employees
WHERE salary>(
	SELECT AVG(salary)
	FROM employees
);

#3. 查询各个部门中工资比本部门平均工资高的员工的员工号，姓名和工资

SELECT employee_id, last_name, salary
FROM employees e
INNER JOIN (
	SELECT AVG(salary) ag, department_id
	FROM employees
	GROUP BY department_id
) AS ag_salary
ON e.`department_id`=ag_salary.department_id
WHERE e.salary>ag_salary.ag;


#4. 查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名

/*
select employees.*
from employees 
where last_name like '%u%'
*/

SELECT employee_id, last_name
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM employees 
	WHERE last_name LIKE '%u%'
);

#5. 查询在部门的location_id为1700的部门工作的员工的员工号

/*
select department_id
from departments
where location_id=1700
*/

SELECT employee_id
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id
	FROM departments
	WHERE location_id=1700
);

#6.查询管理者是king的员工姓名和工资

SELECT last_name, salary
FROM employees e
WHERE `manager_id`IN(
	SELECT manager_id
	FROM employees
	WHERE last_name='K_ing'
);

#7.查询工资最高的员工的姓名，要求first_name last_name显示为一列，列名为 姓.名
SELECT CONCAT(first_name, '.', last_name) AS '姓.名'
FROM employees
WHERE salary=(
	SELECT MAX(salary)
	FROM employees
) 