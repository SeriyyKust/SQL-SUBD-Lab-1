/*Create new tables */
CREATE TABLE table1(
	department_name text not null,
	department_number int not null,
	fio_boss text not null,
	number_of_stavok int not null,
	payroll int not null,
	number_of_employed_stavok int not null,
	constraint pk_table1 primary key (department_name, department_number),
	constraint ak1_table1 unique (department_number, fio_boss)
);

CREATE TABLE table2(
	fio_employee text not null,
	department_name text not null,
	department_number int not null,
	share_occupied_stavki int not null,
	job_title text not null,
	characteristic  text not null,
	constraint pk_table2 primary key (fio_employee),
	constraint fk1_table2 foreign key (department_name, department_number) references table1(department_name, department_number)
);
/* INSERT Some data */
INSERT INTO table1 (department_name, department_number, fio_boss, number_of_stavok, payroll, number_of_employed_stavok)
VALUES ('grobovichkov', 1, 'rodrigez', 50, 1000, 5);
INSERT INTO table1 (department_name, department_number, fio_boss, number_of_stavok, payroll, number_of_employed_stavok)
VALUES ('ost', 2, 'petrovich', 16, 1705, 7);
INSERT INTO table1 (department_name, department_number, fio_boss, number_of_stavok, payroll, number_of_employed_stavok)
VALUES ('ohana', 3, 'stich', 9, 98, 43);
/* Insert boss's data */
INSERT INTO table2 (fio_employee, department_name, department_number, share_occupied_stavki, job_title, characteristic)
VALUES ('petrovich', 'ost', 2, 20, 'boss', 'good');
INSERT INTO table2 (fio_employee, department_name, department_number, share_occupied_stavki, job_title, characteristic)
VALUES ('rodrigez', 'grobovichkov', 1, 30, 'boss', 'bad');
INSERT INTO table2 (fio_employee, department_name, department_number, share_occupied_stavki, job_title, characteristic)
VALUES ('stich', 'ohana', 3, 25, 'boss', 'greate');
/* Insert employee's data */
INSERT INTO table2 (fio_employee, department_name, department_number, share_occupied_stavki, job_title, characteristic)
VALUES ('sveta', 'grobovichkov', 1, 10, 'employee', 'good');
INSERT INTO table2 (fio_employee, department_name, department_number, share_occupied_stavki, job_title, characteristic)
VALUES ('sergey', 'ost', 2, 5, 'employee', 'bad');
INSERT INTO table2 (fio_employee, department_name, department_number, share_occupied_stavki, job_title, characteristic)
VALUES ('lilo', 'ohana', 3, 55, 'employee', 'greate');
/* Foreign key */
ALTER TABLE table1 add constraint fk_table1 foreign key (fio_boss) references table2(fio_employee);
