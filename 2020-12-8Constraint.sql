#常见约束

/*

含义：一种限制，用于限制表中的数据，为了保证表中的数据的准确和可靠性

分类：六大约束
	not null：非空，用于保证爱字段的值不能为空
		比如姓名、学号等
	DEFAULT：默认约束，用于保证该字段有默认值
		比如性别，减少操作
	PRIMARY KEY:主键约束，用于保证该字段的值具有唯一性，并且非空
		比如学号，身份证号，员工编号
	UNIQUE:唯一，用于保证该字段的值具有唯一性，可以为空
		比如座位号
	CHECK: 检查约束【mysql中不支持】
		比如年龄大于18小于60
	FOREIGN KEY：外键：用于限制两个表的关系，用于保证该字段的值必须来自于主表的关联列的值
		在从表添加外键约束，用于引用主表中某列的值
		比如学生表的抓也变好，员工表的部门编号、工种编号
添加约束的时机：
	1. 创建表时
	2. 修改表时
约束的添加分类：
	列级约束：
		六大约束语法上都支持，但外键约束没有效果
	表级约束
		除了非空、默认，其他的都支持


create table 表名(
	字段名 字段类型 列级约束，
	字段名 字段类型，
	表级约束
);

主键和唯一的大对比

	保证唯一性		是否允许为空		一个表中可以有几个	是否允许组合
主键	√			    x			至多有一个		可以  但不推荐
唯一	√ （两个null都不行）	    √			可以有多个		可以  但不推荐



外键：
	1. 要求在从表设置外键关系
	2. 从表的外键列的类型和主表的关联列一致或兼容，名称无需求
	3. 主表的关联列必须是一个key（一般是主键或唯一）
	4. 插入数据时，先插主表；删除数据时，先删从表




*/
#一、创建表时添加约束：
#1. 添加列级约束
/*
语法：

直接在字段名和类型后面追加 约束类型即可
只支持：默认、非空、主键、唯一
*/

CREATE DATABASE students;

USE students;

CREATE TABLE stuinfo(
	id INT PRIMARY KEY,
	stuName VARCHAR(20) NOT NULL,
	gender CHAR(1) CHECK(gender IN ('男','女')),
	seat INT UNIQUE,
	age INT DEFAULT 18,
	majorid INT REFERENCES major(id)
);


CREATE TABLE major(
	id INT PRIMARY KEY,
	majorName VARCHAR(20)
);

DESC stuinfo;
SHOW INDEX FROM stuinfo;

#2. 添加表级约束
/*

语法：在各个字段的最下面
【contraint 约束名】 约束类型（字段名）
*/

DROP TABLE IF EXISTS stuinfo;

CREATE TABLE stuinfo(
	id INT,
	stuname VARCHAR(20),
	gender CHAR(1),
	seat INT,
	age INT,
	majorid INT,
	
	CONSTRAINT pk PRIMARY KEY(id),
	CONSTRAINT uq UNIQUE (seat),
	CONSTRAINT ck CHECK(gender = '男' OR gender = '女'),
	CONSTRAINT fk FOREIGN KEY(majorid) REFERENCES major(id)
);

#通用写法：
CREATE TABLE IF NOT EXISTS stuinfo(
	id INT PRIMARY KEY,
	stuName VARCHAR(20) NOT NULL,
	gender CHAR(1) ,
	seat INT UNIQUE,
	age INT DEFAULT 18,
	majorid INT,
	
	CONSTRAINT fk_stu_major FOREIGN KEY (majorid) REFERENCES major(id)
);


#二、修改表时添加约束
/*
1.添加列级约束
alter table 表名modify column 字段名 字段类型 新约束；
2. 添加表级约束
alter table 表名 add【constraint 约束名】 约束类型（字段名） 【外键的引用】

*/


DROP TABLE stuinfo;

CREATE TABLE IF NOT EXISTS stuinfo(
	id INT ,
	stuName VARCHAR(20),
	gender CHAR(1) ,
	seat INT ,
	age INT,
	majorid INT
	
);
#1. 添加非空约束
ALTER TABLE stuinfo MODIFY COLUMN stuname VARCHAR(20) NOT NULL;
#2. 添加默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT DEFAULT 18;
#3. 添加主键
ALTER TABLE stuinfo MODIFY COLUMN id INT PRIMARY KEY;
# or
ALTER TABLE stuinfo ADD PRIMARY KEY(id);

#4. 添加唯一
ALTER TABLE stuinfo MODIFY COLUMN seat INT UNIQUE;
ALTER TABLE stuinfo ADD UNIQUE (seat);

#5. 添加外键
ALTER TABLE stuinfo ADD CONSTRAINT fk_stuinfo_major FOREIGN KEY(majorid) REFERENCES major(id);
ALTER TABLE stuinfo ADD FOREIGN KEY(majorid) REFERENCES major(id);

#三、修改表时删除约束
#1. 删除非空约束
#1删非空约束
ALTER TABLE stuinfo MODIFY COLUMN stuname VARCHAR(20);
#2删默认约束
ALTER TABLE stuinfo MODIFY COLUMN age INT;
#3删主键
ALTER TABLE stuinfo DROP PRIMARY KEY;
#4删唯一键
ALTER TABLE stuinfo DROP INDEX seat;
#5删除外键
ALTER TABLE stuinfo DROP FOREIGN KEY fk_major_stinf;
SHOW INDEX FROM FROM stuinfo;

/*
		位置			支持的约束类型				是否可以起约束名
			
列级约束	列的后面		语法都支持，但外键没有效果		不可以
表级约束	所有列的下面		默认和非空不支持，其他支持		可以（主键没有效果）

