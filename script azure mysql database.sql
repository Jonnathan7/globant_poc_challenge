use dbbeneficiosuat;

CREATE TABLE `globant_departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


CREATE TABLE `globant_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `globant_hired_employees` (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_time` datetime,
  `department_id` int(11) ,
  `job_id` int(11) ,
  PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*
Drop table globant_hired_employees;
Drop table globant_departments;
drop table globant_jobs;
*/

ALTER TABLE globant_hired_employees ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES globant_departments(id);
ALTER TABLE globant_hired_employees ADD CONSTRAINT fk_job FOREIGN KEY (job_id) REFERENCES globant_jobs(id);

Select * from globant_departments;
Select * from globant_jobs;
Select * from globant_hired_employees;

Select  d.department, j.job, 
	sum(case when QUARTER(h.date_time) = 1 then 1 else 0 end) as Q1,
	sum(case when QUARTER(h.date_time) = 2 then 1 else 0 end) as Q2,
	sum(case when QUARTER(h.date_time) = 3 then 1 else 0 end) as Q3,
	sum(case when QUARTER(h.date_time) = 4 then 1 else 0 end) as Q4
from globant_departments d inner join globant_hired_employees h 
	on d.id = h.department_id inner join globant_jobs j
    on h.job_id = j.id
where year(h.date_time) = 2021
order by d.department, j.job;

Select h.department_id, d.department, count(department_id) as hired
from globant_departments d inner join globant_hired_employees h 
	on d.id = h.department_id
where year(h.date_time) = 2021
group by h.department_id, d.department
order by hired desc;

