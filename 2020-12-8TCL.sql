#TCL
/*
Transaction Control Language 事务控制语言

事务：
一个或一组sql语句组成一个执行单元，这个执行单元要么全部执行，要么全部不执行

案例：转账

特点：（ACID）
1. 原子性（Atomicity）
原子性是指食物是一个不可分割的工作单位，事务中的操作要么都发生，要么都不发生。
2. 一致性（Consistency）
3. 隔离性（Isolation）
不被其他事物干扰
4. 持久性（Durability）
改变是永久的

事物的创建：
隐式事务：书屋没有明显的开启和结束的标记
比如insert、update、delete、

delete from 表 where id=1；

显式事务：事务具有明显的开启和结束的标记
前提：必须先设置自动提交功能为禁用:

set autocommit=0;

开启事务的语句：
update 表set 张三丰的余额=500 where name = ‘张三丰’
update 表 set 郭襄的余额 = 1500 where name =‘郭襄’

结束事物的语句：


步骤：
1. 开启事务：
set autocommit=0;
start transaction;可选的
2. 编写事务中的sql语句（select insert update delete）
语句1；
语句2；
...
3. 结束事务
commit：提交事务
rollback：回滚事务

savepoint:保存点
只搭配rollback to使用

*/

SHOW ENGINES; #显示引擎


#演示事务的使用步骤：
#开启事务：
SET autocommit =0;
START TRANSACTION;
#编写一组事务的语句
UPDATE account SET balance = 500 WHERE username='张无忌';
UPDATE account SET balance = 1500 WHERE username = '赵敏';

#结束事务：
COMMIT;
#ROLLBACK;

/*事务并发问题：
1. 脏读
2. 不可重复读
3. 幻读


设置隔离级别来避免并发问题：
事务隔离级别：
			脏读    不可重复读    幻读
 read uncommitted    	√    	    √        	√
 read committed         ×    	    √        	√
 repeatable read        ×    	    ×        	√
 serializable         	×    	    ×        	×
 
 mysql默认repeatable read
 Oracle默认read committed
 */
#查看当前隔离级别
SELECT @@tx_isolation;
#设置隔离级别
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
 
SELECT @@tx_isolation;

#演示savepoint的使用
INSERT INTO stuinfo VALUES(1,1,'s','yb');
INSERT INTO stuinfo VALUES(2,2,'x','lz');
SELECT * FROM stuinfo;
COMMIT;

SET autocommit=0;
START TRANSACTION;
DELETE FROM stuinfo WHERE id=1;
SAVEPOINT a;
DELETE FROM stuinfo WHERE id=2;
ROLLBACK TO a;
SELECT * FROM stuinfo;
COMMIT;


