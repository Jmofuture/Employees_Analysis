USE EMPLOYEES_MOD

# Tarea 1

/*
 * Create a visualization that provides a breakdown between the male and female 
 * employees working in the company each year, starting from 1990. 
 * */

SELECT YEAR(TDE.FROM_DATE) AS CALENDAR_YEAR
,TD.DEPT_NAME 
,TE.GENDER
,COUNT(TE.EMP_NO) AS NUM_OF_EMPLOYEES
FROM T_EMPLOYEES TE 
INNER JOIN T_DEPT_EMP TDE ON TE.EMP_NO = TDE.EMP_NO
INNER JOIN T_DEPARTMENTS TD ON TDE.DEPT_NO = TD.DEPT_NO 
GROUP BY 1,2,3
HAVING CALENDAR_YEAR >= 1990
ORDER BY 1 


# Tarea 2

/*
 * Compare the number of male managers to the number of female managers 
 * from different departments for each year, starting from 1990.
 * */

SELECT 
TD.DEPT_NAME
,TE2.GENDER
,TDM.EMP_NO 
,TDM.FROM_DATE 
,TDM.TO_DATE 
,E.CALENDAR_YEAR
,CASE
	WHEN YEAR(TDM.TO_DATE) >= CALENDAR_YEAR AND YEAR(TDM.FROM_DATE) <= E.CALENDAR_YEAR THEN 1
	ELSE 0
END AS ACTIVE
FROM(SELECT 
		YEAR(HIRE_DATE) AS CALENDAR_YEAR
		FROM T_EMPLOYEES TE 
		GROUP BY 1) E
	CROSS JOIN T_DEPT_MANAGER TDM 
	JOIN T_DEPARTMENTS TD ON TDM.DEPT_NO = TD.DEPT_NO  
	JOIN T_EMPLOYEES TE2 ON TDM.EMP_NO = TE2.EMP_NO 
	ORDER BY TDM.EMP_NO,CALENDAR_YEAR
	

	
# Tarea 3
	
/* 
 * Compare the average salary of female versus male employees in the entire company until year 2002, 
 * and add a filter allowing you to see that per each department.
 * 
 */
	
	

SELECT TE.GENDER 
,TD.DEPT_NAME 
,ROUND(AVG(TS.SALARY),2) AS SALARY 
,YEAR(TS.FROM_DATE) AS CALENDAR_YEAR
FROM T_SALARIES TS 
	INNER JOIN T_EMPLOYEES TE ON TS.EMP_NO = TE.EMP_NO 
	INNER JOIN T_DEPT_EMP TDE ON TDE.EMP_NO = TE.EMP_NO 
	INNER JOIN T_DEPARTMENTS TD ON TD.DEPT_NO = TDE.DEPT_NO 
GROUP BY TD.DEPT_NO, TE.GENDER, CALENDAR_YEAR
HAVING CALENDAR_YEAR <= 2002
ORDER BY TD.DEPT_NO
	
	
# Tarea 4	
	
/*
 * Create an Query that will allow you to obtain the average male and female 
 * salary per department within a certain salary range. Let this range be defined by two values the user can insert when calling the procedure.

Finally, visualize the obtained result-set in Tableau as a double bar chart. 
 * */	


SELECT TE.GENDER 
,TD.DEPT_NAME
,ROUND(AVG(TS.SALARY), 2) AS AVG_SALARY
FROM T_SALARIES TS 
	INNER JOIN T_EMPLOYEES TE ON TS.EMP_NO = TE.EMP_NO 
	INNER JOIN T_DEPT_EMP TDE ON TDE.EMP_NO = TE.EMP_NO 
	INNER JOIN T_DEPARTMENTS TD ON TD.DEPT_NO = TDE.DEPT_NO 
WHERE TS.SALARY BETWEEN 50000 AND 90000
GROUP BY 2, 1 


