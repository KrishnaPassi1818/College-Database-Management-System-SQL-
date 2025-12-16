#creating database
create database college_db;
use college_db;

create table departments(
	department_id int auto_increment primary key,
    department_name varchar(50) not null,
    building varchar(50)
);
insert into departments(department_name, building)
Values
	("computer science and engineering", "block a"),
	("electronics and communication", "block b"),
	("mechanical engineering", "block c"),
	("civil engineering", "block d"),
	("information technology","block e");
    
create table students(
	student_id int auto_increment primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(50) unique not null,
    phone varchar(15) not null,
    department_id int not null,
    foreign key (department_id) references departments(department_id),
    admission_year year not null
);
insert into students(first_name, last_name, email, phone, department_id, admission_year)
values
	("rahul", "mehra", "rahul.mehra@college.com","9876543210", 1, 2023),
    ("ananya", "sharma", "ananya.sharma@college.com","9876501234", 1, 2024),
    ("kabir", "singh", "kabir.singh@college.com","9823456712", 1, 2023),
    ("meera", "nair", "meera.nair@college.com","9811122233", 1, 2022),
    ("arjun", "patel", "arjun.patel@college.com","9898989898", 1, 2024);
    
create table instructors(
	instructor_id int auto_increment unique primary key not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(50) unique not null,
    phone varchar(15) not null,
    department_id int not null,
    foreign key (department_id) references departments(department_id)
);
insert into instructors(first_name, last_name, email, phone, department_id)
values
	("neha","verma", "neha.verma@college.com", "9876100001", 1),
	("rohan","sinha", "rohan.sinha@college.com", "9876100002", 1),
	("priya","iyer", "priya.iyer@college.com", "9876100003", 1),
	("amit","rao", "amit.rao@college.com", "9876100004", 1),
	("kavita","patel", "kavita.patel@college.com", "9876100005", 1);
update instructors
set department_id = 2 where instructor_id = 3;
update instructors
set department_id = 3 where instructor_id = 4;
update instructors
set department_id = 5 where instructor_id = 5;

create table courses( 
	course_id int auto_increment primary key, 
    course_name varchar(100) not null, 
    course_code varchar(20) unique, 
    department_id int not null, 
    foreign key (department_id) references departments(department_id), 
    instructor_id int not null, 
    foreign key (instructor_id) references instructors(instructor_id),
    credits int not null,
    semester int );
insert into courses(course_name, course_code, department_id, instructor_id, credits, semester)
values 
	("programming fundamentals", "cse101", 1, 1, 4, 1), 
	("data structures", "cse201", 1, 2, 4, 3), 
	("database management system", "cse301", 1, 1, 4, 4), 
	("operating system", "cse302", 1, 1, 4, 4), 
	("basic electronics", "ece101", 2, 3, 4, 1), 
	("digital logic design", "ece201", 2, 3, 3, 2), 
	("microprocessors and design", "ece301", 2, 3, 4, 4), 
	("engineering mechanics", "me101", 3, 4, 4, 1), 
	("thermodynamics", "me201", 3, 4, 4, 3), 
	("strength of materials", "me301", 3, 4, 3, 4),  
	("web development basics", "it101", 5, 5, 3, 2), 
	("computer networks", "it201", 5, 5, 4, 3), 
	("cloud computing fundamentals", "it301", 5, 5, 3, 4);

select course_id, course_name from courses;

create table enrollments(
	enrollment_id int auto_increment primary key,
    student_id int not null,
    foreign key (student_id) references students(student_id),
    course_id int not null,
    foreign key (course_id) references courses(course_id),
    enrollment_date date not null,
    grade varchar(5)
);
-- student 1 rahul cse
-- student 2 ananya cse
-- student 3 kabir cse
-- student 4 meera cse
-- student 5 arjun cse
insert into enrollments(student_id, course_id, enrollment_date)
values
	(1, 1, '2024-01-10'),
	(1, 2, '2024-01-10'),
	(1, 3, '2024-01-10'),
	(1, 4, '2024-01-10'),
	(2, 1, '2024-02-15'),
	(2, 2, '2024-02-15'),
	(2, 3, '2024-02-15'),
	(3, 1, '2024-01-12'),
	(3, 2, '2024-01-12'),
	(3, 4, '2024-01-12'),
	(4, 11, '2024-02-20'),
	(4, 12, '2024-02-20'),
	(4, 13, '2024-02-20'),
	(5, 1, '2024-03-10'),
	(5, 3, '2024-03-10'),
	(5, 11, '2024-03-10');

create table classrooms(
	classroom_id int auto_increment primary key,
    room_no varchar(20),
    building varchar(20),
    capacity int
);
insert into classrooms(room_no, building, capacity)
values
	("a101", "block b", 60),
	("a102", "block a", 40),
	("b201", "block b", 50),
	("c310", "block c", 45),
	("e105", "block e", 30);

create table class_schedules(
	schedule_id int auto_increment primary key,
    course_id int not null,
    foreign key (course_id) references courses(course_id),
    instructor_id int not null,
    foreign key (instructor_id) references instructors(instructor_id),
    classroom_id int not null,
    foreign key (classroom_id) references classrooms(classroom_id),
    day_of_week varchar(10),
    start_time time,
    end_time time
);
insert into class_schedules(
	course_id,
    instructor_id,
    classroom_id,
    day_of_week,
    start_time,
    end_time
)
values
	(1, 1, 1, "monday", '09:00', '10:30'),
	(2, 2, 1, "wednesday", '11:00', '12:30'),
	(3, 1, 2, "friday", '13:00', '14:30'),
	(5, 3, 3, "tuesday", '10:00', '11:30'),
	(6, 3, 3, "thursday", '12:00', '13:30'),
	(8, 4, 4, "monday", '14:00', '15:30'),
	(9, 4, 4, "friday", '09:00', '10:30'),
	(11, 5, 5, "wednesday", '15:00', '16:30'),
	(12, 5, 5, "saturday", '11:00', '12:30');
-- adding new student
insert into students(
	first_name,
	last_name, 
    email, 
    phone, 
    department_id, 
    admission_year
)
values
("sia", "kapoor", "sia.kapoor@college.com", "9876123456", 5, '2024');

-- DML Section
-- adding new instructor
insert into instructors(
	first_name,
    last_name,
    email,
    phone,
    department_id
)
values
("rakesh", "yadav", "rakesh.yadav@college.com", "9899001122", 3);

-- adding new course
insert into courses(
	course_name,
    course_code, 
    department_id,
    instructor_id,
    credits,
    semester
)
values
("algorithms", "cse401", 1, 2, 4, 5);

-- adding enrollment for new student ie sia kapoor
select student_id from students where email = 'sia.kapoor@college.com'; -- student id is 6
select course_id from courses where course_code = 'cse401'; -- course id is 14
-- enrollment date of new student is 2024-04-10
insert into enrollments(
	student_id,
    course_id,
    enrollment_date
)
values
(6, 14, '2024-04-10');

-- Simple select queries
select student_id, first_name, last_name, email
from students
order by first_name;

select course_name, course_code, semester, credits
from courses
where semester = 4;

select instructor_id, first_name, last_name, email
from instructors
where department_id = 3;

select room_no, building, capacity
from classrooms
where capacity > 40;

select first_name, last_name, admission_year
from students
where admission_year = '2024';

-- Intermediate Queries (GROUP BY, DISTINCT, HAVING, Aggregates)

select department_id, count(*)
from students
group by department_id;

select semester, count(*)
from courses
group by semester;

select admission_year, count(*) as total
from students
group by admission_year
having total > 1;

select department_id, count(*) as total
from instructors
group by department_id;

select course_id, count(*) as total
from enrollments
group by course_id
order by total desc;
	
-- advance sql queries
select
	students.student_id,
    students.first_name,
    students.last_name,
    departments.department_name
from students
join departments 
	on students.department_id = departments.department_id;

select
	students.student_id,
    students.first_name,
    students.last_name,
    courses.course_name,
    courses.course_code,
    enrollments.enrollment_date
from students
join enrollments on students.student_id = enrollments.student_id
join courses on enrollments.student_id = courses.course_id;

select
	c.course_name,
	concat(i.first_name,' ',i.last_name) as instructor_name,
    cl.building,
    cl.room_no,
    cs.day_of_week,
    cs.start_time,
    cs.end_time
from class_schedules cs
join courses c on cs.course_id = c.course_id
join instructors i on cs.instructor_id = i.instructor_id
join classrooms cl on cs.classroom_id = cl.classroom_id;

select
	concat(s.first_name,' ', s.last_name) as student_name,
    c.course_name,
    concat(i.first_name,' ', i.last_name) as instructor_name,
    cs.day_of_week,
    cs.start_time,
    cs.end_time,
    cl.building,
    cl.room_no
from enrollments e
join students s on s.student_id = e.enrollment_id
join courses c on e.course_id = c.course_id
join class_schedules cs on cs.course_id = c.course_id
join instructors i on cs.instructor_id = i.instructor_id
join classrooms cl on cs.classroom_id = cl.classroom_id
order by s.first_name;

-- inserting student with no enrollment
insert into students(
	first_name,
    last_name,
    email,
    phone,
    department_id,
    admission_year
)
values('aman','gupta','aman.gupta@college.com','9876998877',3,2024);

select
	students.student_id,
    concat(students.first_name, " ", students.last_name) as student_name,
    students.email
from students
left join enrollments
on students.student_id = enrollments.student_id
where enrollments.student_id is null;

select
	instructors.instructor_id,
    concat(instructors.first_name," ", instructors.last_name) as instructor_name,
    count(courses.course_id) as total_courses
from instructors
join courses
	on instructors.instructor_id = courses.instructor_id
group by instructors.instructor_id
having count(courses.course_id) > 1;

select
	classrooms.classroom_id,
    classrooms.building,
    classrooms.room_no
from classrooms
join class_schedules
	on classrooms.classroom_id = class_schedules.classroom_id
where class_schedules.classroom_id = null;

SELECT course_id, course_name
FROM courses
WHERE course_id IN (
    SELECT course_id
    FROM enrollments
    GROUP BY course_id
    HAVING COUNT(student_id) < 2
);


-- creating view table
create view student_timetable_view as
select
	concat(students.first_name,' ',students.last_name) as student_name,
    courses.course_name,
    concat(instructors.first_name,' ',instructors.last_name) as instructor_name,
    class_schedules.day_of_week,
    class_schedules.start_time,
    class_schedules.end_time,
    classrooms.building,
    classrooms.room_no
from enrollments
join students 
	on enrollments.student_id = students.student_id
join courses
	on enrollments.course_id = courses.course_id
join class_schedules
	on courses.course_id = class_schedules.course_id
join instructors
	on class_schedules.instructor_id = instructors.instructor_id
join classrooms
	on class_schedules.classroom_id = classrooms.classroom_id;
    
select * from student_timetable_view;






