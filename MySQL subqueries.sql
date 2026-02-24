USE PWSKILLS;
CREATE TABLE Department (
    department_id VARCHAR(5),
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO Department VALUES
('D01','Sales','Mumbai'),
('D02','Marketing','Delhi'),
('D03','Finance','Pune'),
('D04','HR','Bengaluru'),
('D05','IT','Hyderabad');

CREATE TABLE Employee (
    emp_id INT,
    name VARCHAR(50),
    department_id VARCHAR(5),
    salary INT);

INSERT INTO Employee VALUES
(101,'Abhishek','D01',62000),
(102,'Shubham','D01',58000),
(103,'Priya','D02',67000),
(104,'Rohit','D02',64000),
(105,'Neha','D03',72000),
(106,'Aman','D03',55000),
(107,'Ravi','D04',60000),
(108,'Sneha','D04',75000),
(109,'Kiran','D05',70000),
(110,'Tanuja','D05',65000);


CREATE TABLE Sales (
    sale_id INT,
    emp_id INT,
    sale_amount INT,
    sale_date DATE);

INSERT INTO Sales VALUES
(201,101,4500,'2025-01-05'),
(202,102,7800,'2025-01-10'),
(203,103,6700,'2025-01-14'),
(204,104,12000,'2025-01-20'),
(205,105,9800,'2025-02-02'),
(206,106,10500,'2025-02-05'),
(207,107,3200,'2025-02-09'),
(208,108,5100,'2025-02-15'),
(209,109,3900,'2025-02-20'),
(210,110,7200,'2025-03-01');


SELECT * FROM EMPLOYEE;
SELECT * FROM SALES;
SELECT * FROM DEPARTMENT;

## Retrieve the names of employees who earn more than the average salary of all employees.

SELECT NAME,SALARY FROM EMPLOYEE
  WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);
  
## Find the employees who belong to the department with the highest average salary
   SELECT * FROM EMPLOYEE
     WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID FROM EMPLOYEE
          GROUP BY DEPARTMENT_ID 
              HAVING AVG(SALARY) = (SELECT MAX(AVG_SALARY) FROM (SELECT AVG(salary) AS avg_salary
            FROM Employee
            GROUP BY department_id
        ) t
    )
);


## List all employees who have made at least one sale.
   SELECT DISTINCT E.EMP_ID,E.NAME,S.SALE_AMOUNT FROM EMPLOYEE E
    JOIN SALES S ON
      E.EMP_ID = S.EMP_ID;
      
## Find the employee with the highest sale amount.
 SELECT E.EMP_ID,E.NAME,S.SALE_AMOUNT
 FROM SALES S
 JOIN EMPLOYEE E ON
  S.EMP_ID=E.EMP_ID
   WHERE S.SALE_AMOUNT=(SELECT MAX(SALE_AMOUNT) FROM SALES);
   
   ##  Retrieve the names of employees whose salaries are higher than Shubham’s salary.
     SELECT * FROM EMPLOYEE
      WHERE SALARY > (SELECT SALARY FROM 
         EMPLOYEE
         WHERE NAME = "SHUBHAM");
         
## Find employees who work in the same department as Abhishek.
select name,DEPARTMENT_ID from employee
where department_id =(select depARTMENT_ID from employee
 where name ="abhishek")
 AND NAME <> "ABHISHEK";
 
## List departments that have at least one employee earning more than ₹60,000.
    SELECT DEPARTMENT_ID,SALARY FROM EMPLOYEE
     WHERE SALARY > 60000;
     
### Find the department name of the employee who made the highest sale.
     SELECT E.EMP_ID,
     D.DEPARTMENT_NAME,
     E.NAME,
     S.SALE_AMOUNT
     FROM SALES S
        JOIN EMPLOYEE E ON
        E.EMP_ID = S.EMP_ID
        JOIN DEPARTMENT D ON
          E.DEPARTMENT_ID = D.DEPARTMENT_ID
          WHERE SALE_AMOUNT = (SELECT MAX(SALE_AMOUNT) FROM SALES S) ;
          
### Retrieve employees who have made sales greater than the average sale amount.
     SELECT EMP_ID,SALE_AMOUNT FROM SALES
     WHERE SALE_AMOUNT > (SELECT AVG(SALE_AMOUNT) FROM SALES);
          
 ### Find the total sales made by employees who earn more than the average salary.
 SELECT SUM(S.SALE_AMOUNT)AS TOTAL_SALES FROM EMPLOYEE E
 JOIN SALES S ON
 E.EMP_ID=S.EMP_ID
 WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);
 
 ##Find employees who have not made any sales
  SELECT E.NAME,S.SALE_AMOUNT FROM SALES S
  LEFT JOIN EMPLOYEE E ON
  S.EMP_ID=E.EMP_ID
  WHERE S.EMP_ID IS NULL;
  
  ##List departments where the average salary is above ₹55,000
  SELECT E.DEPARTMENT_ID,D.DEPARTMENT_NAME FROM EMPLOYEE E
     JOIN DEPARTMENT D ON
       D.DEPARTMENT_ID=E.DEPARTMENT_ID
       GROUP BY DEPARTMENT_ID,DEPARTMENT_NAME
        HAVING AVG(SALARY) > 55000;
        
 ###Retrieve department names where the total sales exceed ₹10,000.
  SELECT D.DEPARTMENT_NAME,SUM(S.SALE_AMOUNT) as total_sales FROM DEPARTMENT D
JOIN EMPLOYEE E ON
 D.DEPARTMENT_ID=E.DEPARTMENT_ID
 JOIN SALES S ON
 S.EMP_ID=E.EMP_ID
 GROUP BY DEPARTMENT_NAME
 having SUM(SALE_AMOUNT)>10000;
 
 ### Find the employee who has made the second-highest sale
   select e.name,s.sale_amount from employee e
   inner join sales s on
    e.emp_id=s.emp_id
    order by sale_amount desc
     limit 1
     offset 1;
     
###Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
select e.emp_id,e.name,e.salary from employee e
 where salary > (select max(sale_amount) from sales)
  order by salary desc;
   
      
             
 
 
 

           
        
     
     

  
              


