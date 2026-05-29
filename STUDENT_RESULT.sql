create database  student_result_system;
use student_result_system;

create table students(student_id int auto_increment primary key,student_name varchar(100),department varchar(100),stud_year int);
create table subjects(subject_id int primary key,subject_name varchar(100),credits int);
create table marks(mark_id int primary key,student_id int,subject_id int,marks int,foreign key(student_id) references students(student_id),foreign key(subject_id) references subjects(subject_id));

insert into students(student_name,department,stud_year) values ('Arjun', 'CSE', 2),( 'Meera', 'CSE', 2),( 'Rahul', 'ECE', 3),( 'Anjali', 'ECE', 3),( 'Vivek', 'MECH', 1),( 'Sneha', 'MECH', 1),( 'Kiran', 'CSE', 2),( 'Divya', 'ECE', 3);
insert into subjects(subject_id,subject_name,credits) values (101, 'DBMS', 4),(102, 'Mathematics', 3),(103, 'Electronics', 4),(104, 'Mechanics', 3);
insert into marks(mark_id,student_id,subject_id,marks)values (1, 1, 101, 85),(2, 1, 102, 78),(3, 2, 101, 92),(4, 2, 102, 88),(5, 3, 103, 35),(6, 3, 102, 55),(7, 4, 103, 73),(8, 4, 102, 64),(9, 5, 104, 30),(10, 5, 102, 42),(11, 6, 104, 25),(12, 6, 102, 38),(13, 7, 101, 60),(14, 7, 102, 45),(15, 8, 103, 81),(16, 8, 102, 72);

-- Get top 3 students in each subject 
select s.student_id,s.student_name,su.subject_id,m.marks from marks m join students s on m.student_id=s.student_id join subjects su on m.subject_id=su.subject_id where subject_name='DBMS' group by s.student_id,s.student_name,su.subject_id,m.marks order by m.marks desc limit 3 ;
select s.student_id,s.student_name,su.subject_id,m.marks from marks m join students s on m.student_id=s.student_id join subjects su on m.subject_id=su.subject_id where subject_name='Mathematics' group by s.student_id,s.student_name,su.subject_id,m.marks order by m.marks desc limit 3 ;
select s.student_id,s.student_name,su.subject_id,m.marks from marks m join students s on m.student_id=s.student_id join subjects su on m.subject_id=su.subject_id where subject_name='Electronics' group by s.student_id,s.student_name,su.subject_id,m.marks order by m.marks desc limit 3 ;
select s.student_id,s.student_name,su.subject_id,m.marks from marks m join students s on m.student_id=s.student_id join subjects su on m.subject_id=su.subject_id where subject_name='Mechanics' group by s.student_id,s.student_name,su.subject_id,m.marks order by m.marks desc limit 3 ;
 
 -- Calculate average marks per department
select s.department,avg(m.marks) as average_mark from students s join marks m on s.student_id=m.student_id where s.department='ECE';
select s.department,avg(m.marks) as average_mark from students s join marks m on s.student_id=m.student_id where s.department='MECH';
select s.department,avg(m.marks) as average_mark from students s join marks m on s.student_id=m.student_id where s.department='CSE';

-- Find students who failed in more than 2 subjects 
select st.student_name, count(*) as failed_subjects from marks m join students st on m.student_id=st.student_id where m.marks<80 group by st.student_id,st.student_name having count(*)>2;


 
 