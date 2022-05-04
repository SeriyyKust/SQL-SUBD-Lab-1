/* Delete old role and old user */
drop ROLE if exists employee_role;
drop ROLE if exists boss_role;
drop USER if exists Lilo;
drop USER if exists Sergey;
drop USER if exists Petrovich;
drop USER if exists Stich;

/* Create new role and new users */
CREATE ROLE employee_role;
CREATE ROLE boss_role;
CREATE USER lilo PASSWORD 'lilo';
CREATE USER sergey PASSWORD 'sergey';
CREATE USER petrovich PASSWORD 'petrovich';
CREATE USER stich PASSWORD 'stich';

grant employee_role to lilo, sergey;
grant boss_role to petrovich, stich;

/*Удаление старых политик*/
drop policy if exists boss_select_t1 on table1;
drop policy if exists employee_select_t1 on table1;
drop policy if exists boss_select_t2 on table2;
drop policy if exists boss_update_t2 on table2;
drop policy if exists employee_select_t2 on table2;

/**/
create view boss_depts as (SELECT department_name from table1
					where fio_boss = current_user);

create view employee_depts as (SELECT department_name 
	from table2 where fio_employee = current_user);

/*Босс видит данные о своём отделе*/
create policy boss_select_t1 on table1 for select 
	to boss_role 
	using(department_name = (select department_name 
		from boss_depts));
/*Сотрудник видит данные о своём отделе*/
create policy employee_select_t1 on table1 for select 
	to employee_role
	using(department_name = (select department_name 
		from employee_depts));
/*Босс видит данные о сотрудниках своего отдела*/
create policy boss_select_t2 on table2 for select
	to boss_role
	using (department_name = (select department_name 
		from boss_depts));

create policy boss_update_t2 on table2 for update
	to boss_role
	using (department_name = (select department_name 
		from boss_depts));
/*Сотрудник видит данные о себе*/
create policy employee_select_t2 on table2 for select
	to employee_role
	using (fio_employee = current_user);

ALTER TABLE table1 ENABLE ROW LEVEL SECURITY;
ALTER TABLE table2 ENABLE ROW LEVEL SECURITY;

grant select on boss_depts to boss_role;
grant select on employee_depts to employee_role;
grant select on table1 to boss_role;
/*Сотрудник может считывать только данные поля своего раздела*/
grant select (department_name, department_number, fio_boss)
 on table1 to employee_role;
grant select on table2 to boss_role;
grant select on table2 to employee_role;
/*Босс может изменять только данные поля своих сотрудников*/	
grant update (job_title, characteristic) on table2 to boss_role;

