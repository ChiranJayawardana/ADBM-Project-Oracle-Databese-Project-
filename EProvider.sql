------------------------------------1------------------------------------
CREATE TABLE departments1 (
  dept_id CHAR(2) PRIMARY KEY,
  dept_name VARCHAR2(20) NOT NULL,
  Manager_id NUMBER(4)
);

CREATE SEQUENCE emp_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE employees1 (
  emp_id NUMBER(4) DEFAULT emp_seq.nextval NOT NULL,
  emp_name VARCHAR2(20) NOT NULL,
  emp_city VARCHAR2(20) NOT NULL,
  emp_email VARCHAR2(40) NOT NULL,
  emp_mobile VARCHAR2(10) NOT NULL,
  emp_dob DATE,
  emp_salary NUMBER(10,2),
  dept_id CHAR(2),
  FOREIGN KEY (dept_id) REFERENCES departments1(dept_id)
);


ALTER TABLE employees1 ADD (
  CONSTRAINT emp_pk PRIMARY KEY (emp_id));
  
  
  
--------------------------------------2-----------------------------------
-- Insert records into departments1
INSERT INTO departments1 (dept_id,dept_name,Manager_id)
VALUES ('F1','Finance',0001);
INSERT INTO departments1 (dept_id, dept_name,Manager_id)
VALUES ('M1', 'Marketing',0002);
INSERT INTO departments1 (dept_id, dept_name,Manager_id)
VALUES ('M2', 'Management',0003);
INSERT INTO departments1 (dept_id, dept_name,Manager_id)
VALUES ('T1', 'Technical',0004);



-- Insert matching records into employees1 For Managers
INSERT INTO employees1 (emp_id,emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES (1,'Supun Dihan','Matara', 'supu@gmail.com', '0723456789', TO_DATE('1997-01-01', 'YYYY-MM-DD'), 490000, 'F1');
INSERT INTO employees1 (emp_id,emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES (2,'Kasun Piha','Akuressa', 'kasu@gmail.com', '0763456780', TO_DATE('1998-01-08', 'YYYY-MM-DD'), 390000, 'M1');
INSERT INTO employees1 (emp_id,emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES (3, 'Nuwan Gamage','Matara', 'nuwa@gmail.com', '0783456769', TO_DATE('2000-01-05', 'YYYY-MM-DD'), 990000, 'M2');
INSERT INTO employees1 (emp_id,emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES (4, 'Ruwani Gimhani','Galle', 'ruwan@gmail.com', '0793456789', TO_DATE('1999-05-01', 'YYYY-MM-DD'), 250000, 'T1');

--Insert Value for Normal Employees-------
INSERT INTO employees1 (emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES ('Buddhi','Matara', 'budi@gmail.com', '0703456781', TO_DATE('2002-01-08', 'YYYY-MM-DD'), 90000, 'F1');
INSERT INTO employees1 (emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES ('Chiran','Akuressa', 'chira@gmail.com', '0713456782', TO_DATE('1998-01-10', 'YYYY-MM-DD'), 80000, 'M1');
INSERT INTO employees1 (emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES ( 'Thisaru','Matara', 'thisa@gmail.com', '0744456763', TO_DATE('2000-01-20', 'YYYY-MM-DD'), 150000, 'M2');
INSERT INTO employees1 (emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES ('Dulanja','Galle', 'dula@gmail.com', '0700056784', TO_DATE('1992-05-27', 'YYYY-MM-DD'), 75000, 'T1');

INSERT INTO employees1 (emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES ('Lahiru','Matara', 'lahi@gmail.com', '0703456711', TO_DATE('2002-01-02', 'YYYY-MM-DD'), 90000, 'F1');
INSERT INTO employees1 (emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES ('Naveen','Akuressa', 'navee@gmail.com', '0713456732', TO_DATE('1988-01-15', 'YYYY-MM-DD'), 85000, 'M1');
INSERT INTO employees1 (emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES ( 'Malinga','Matara', 'mali@gmail.com', '0744456743', TO_DATE('2004-01-20', 'YYYY-MM-DD'), 160000, 'M2');
INSERT INTO employees1 (emp_name,emp_city, emp_email, emp_mobile, emp_dob, emp_salary, dept_id)
VALUES ('Dinuka','Galle', 'dinu@gmail.com', '0700056754', TO_DATE('2005-05-28', 'YYYY-MM-DD'), 65000, 'T1');


select * from employees1;
select * from departments1;

---------------------------3-----------------------------------------------
SELECT * 
FROM employees1 
WHERE emp_city = 'Matara';

SELECT emp_city, COUNT(*) 
FROM employees1 
GROUP BY emp_city;

SELECT emp_city, COUNT(*) 
FROM employees1 
GROUP BY emp_city 
HAVING COUNT(*) > 5;


SELECT * 
FROM employees1 
ORDER BY emp_name ASC;

----------------------------------4------------------------------------------------

SELECT emp_name AS Finance_Employee
FROM employees1 
WHERE (dept_id = (SELECT dept_id FROM departments1 WHERE dept_name = 'Finance'))
AND emp_salary>=100000;


SELECT emp_name AS Finance_Marketing_Employees 
FROM employees1 
WHERE dept_id IN (SELECT dept_id FROM departments1 WHERE dept_name IN ('Finance', 'Marketing'));

------------------------------------5--------------------------------------------------
SELECT employees1.emp_name, departments1.dept_name,employees1.emp_salary
FROM employees1
LEFT JOIN departments1 ON employees1.dept_id = departments1.dept_id;



SELECT employees1.emp_name, departments1.dept_name,employees1.emp_salary
FROM employees1 
RIGHT JOIN departments1 ON employees1.dept_id = departments1.dept_id;


SELECT employees1.emp_name, departments1.dept_name,employees1.emp_salary
FROM employees1
FULL OUTER JOIN departments1 ON employees1.dept_id = departments1.dept_id;

---------------------------------6---------------------------------

CREATE VIEW employees_views AS
SELECT emp_id, emp_name, emp_city
FROM employees1
WHERE emp_salary> 100000;

select * from employees_views;

--------------------------------------7------------------------------


DECLARE
  v_emp_name employees1.emp_name%TYPE;
BEGIN
  SELECT emp_name INTO v_emp_name
  FROM employees1
  WHERE emp_id = 1;
  
  DBMS_OUTPUT.PUT_LINE('Employee name: ' || v_emp_name);
END;
/

-----------------------------------8------------------------------------


DECLARE
  v_emp_id employees1.emp_id%TYPE := 4;
BEGIN
  UPDATE employees1
  SET emp_salary = emp_salary + 20000
  WHERE emp_id = v_emp_id;
  
  DBMS_OUTPUT.PUT_LINE('Record updated successfully.');
END;
/



------------------------9----------------------------


DECLARE
  v_emp_city employees1.emp_city%TYPE := 'Matara';
BEGIN
  DELETE FROM employees1
  WHERE emp_city = v_emp_city;
  
  DBMS_OUTPUT.PUT_LINE('Record deleted successfully.');
END;
/

----------------------10------------------------------


DECLARE
  v_emp_city employees1.emp_city%TYPE := 'Matara';
  v_rows_deleted NUMBER;
BEGIN
  DELETE FROM employees1
  WHERE emp_city = v_emp_city;
  
  v_rows_deleted := SQL%ROWCOUNT;
  
  DBMS_OUTPUT.PUT_LINE('Number of rows deleted: ' || v_rows_deleted);
END;
/




------------------------------------------------------------------------------------------------------------------------