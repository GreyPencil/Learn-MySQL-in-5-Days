#进阶8：分页查询（❤）
/*

应用场景：当要显示的数据，一页显示不全，需要分页提交sql请求
语法&执行顺序：
	7-> select查询列表
	1-> from 表
	2-> 【join typejoin 表2
	3-> on连接条件
	4-> where筛选条件
	5-> group by 分组字段
	6-> having 分组后的筛选
	8-> order by 排序的字段】
	9-> limit offset, size;
	
	offset要显示条目的起始索引（起始索引从0开始）
	size要显示的条目个数
	
特点：
	1. limit语句放在查询语句最后
	2. 公式：
	要显示的页数 page，每页的条目数 size
	
	select 查询列表
	from 表
	limit （page-1）*size， size；

*/

#案例1：查询前五条员工信息

SELECT * FROM employees LIMIT 0,5;
SELECT * FROM employees LIMIT 5;

#案例2：查询第11-25

SELECT * FROM employees LIMIT 10, 15;


#案例3：有奖金的员工信息，工资较高的前十名

SELECT *
FROM employees
WHERE `commission_pct` IS NOT NULL
ORDER BY salary DESC
LIMIT 10;


#经典习题：
#1. 查询工资最低的员工信息：last_name, salary
SELECT last_name, salary
FROM employees
WHERE salary=(
	SELECT DISTINCT MIN(salary)
	FROM employees
);

#2. 查询平均工资最低的部门信息
SELECT d.*
FROM departments d
WHERE department_id=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1);




#3. 查询平均工资最低的部门信息和该部门的平均工资

SELECT d.*, ag_dev.ag
FROM departments d
INNER JOIN (
	SELECT department_id, AVG(salary) ag
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary)
	LIMIT 1) AS ag_dev
ON d.`department_id`=ag_dev.department_id;


#4.查询平均工资最高的job信息

SELECT AVG(salary),job_id
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC
LIMIT 1;

SELECT j.*
FROM jobs j
WHERE job_id=(
	SELECT job_id
	FROM employees
	GROUP BY job_id
	ORDER BY AVG(salary) DESC
	LIMIT 1
);

#5.查询平均工资高于公司平均工资的部门有哪些

SELECT AVG(salary)
FROM employees;

SELECT AVG(salary) ag,e.department_id
FROM employees e
GROUP BY e.department_id
HAVING ag>(
	SELECT AVG(salary)
	FROM employees
);



#6. 查询出公司中所有manager 的详细信息

SELECT DISTINCT m.*
FROM employees e
JOIN employees m
ON e.`manager_id`=m.`employee_id`;

#or
SELECT *
FROM employees
WHERE employee_id = ANY(
	SELECT DISTINCT manager_id
	FROM employees
);

#7. 各个部门中 最高工资中最低的那个部门的 最低工资是多少

SELECT department_id
FROM employees
GROUP BY department_id
ORDER BY MAX(salary)
LIMIT 1;

SELECT MIN(salary)
FROM employees
WHERE department_id=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY MAX(salary)
	LIMIT 1
);

#8. 查询平均工资最高的部门的manager的详细信息：last_name, department_id, email,salary

SELECT last_name, department_id, email, salary
FROM employees
WHERE department_id=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) DESC
	LIMIT 1
)
AND manager_id IS NULL;

#or
SELECT 
	last_name, d.department_id, email, salary
FROM employees e
JOIN departments d
ON e.`employee_id`=d.`manager_id`
WHERE d.department_id=(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) DESC
	LIMIT 1
);