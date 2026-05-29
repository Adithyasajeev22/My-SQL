create database libraryDB;
use libraryDB;

create table books(book_id int auto_increment primary key,title varchar(255) not null,author varchar(255) not null,genre varchar(100),published_year year,is_available boolean default true);
create table members(member_id int auto_increment primary key,member_name varchar(255) not null,email varchar(255),phone_number varchar(15),join_date date default (current_date));
create table librarians(librarian_id int auto_increment primary key,librarian_name varchar(255) not null,email varchar(255),phone_number varchar(15),hire_date date default(current_date));
create table borrowing(loan_id int auto_increment primary key,book_id int,member_id int,borrow_date date default(current_date),return_date date,librarian_id int,foreign key (book_id) references books(book_id),foreign key(member_id) references members(member_id),foreign key(librarian_id) references librarians(librarian_id));

insert into books(title,author,genre,published_year) values ('The Great Gatsby','F.Scott Fitzgerald', 'Fiction',1925),('1984', 'George Orwell', 'Dystopian', 1949),('To Kill a Mockingbird', 'Harper Lee', 'Classic', 1960);
insert into members (member_name, email, phone_number) values('Alen King', 'alenking@example.com', '1234567890'),('Alece Hofman', 'alecehofman@example.com', '9876543210');
insert into librarians (librarian_name, email, phone_number) values('Nail Horn', 'nail@example.com', '4567891230'),('Garden McGraw', 'garden@example.com', '7894561230');

-- 1. Borrow a Book
insert into borrowing(book_id,member_id,librarian_id) values(1,1,1);
update books set is_available=false where book_id=1;

-- 2. Return a Book
update borrowing set return_date=current_date where loan_id=1;
update books set is_available=true where book_id=1;

-- 3. List available books
select*from books where is_available=true;

-- 4. Member Loan History
select m.member_name,b.title,br.borrow_date,br.return_date from borrowing br join members m on br.member_id=m.member_id join books b on br.book_id=b.book_id where m.member_id=1;  -- jhhj 

-- 5. Overdue books (>14 days)
select m.member_name,b.title,br.borrow_date from borrowing br join members m on br.member_id=m.member_id join books b on br.book_id=b.book_id where br.return_date is null and br.borrow_date<current_date-interval 14 day; -- hfhf

-- 6. Books published after 2000 and after 1940
select title,genre,published_year from books where published_year>2000;
select book_id,title,author,published_year,is_available from books where published_year>1940;

-- 7. Books by 'George Orwell'
select title,genre,published_year from books where author='George Orwell';

-- 8. Total books in library
select count(*) as total_books from books;

-- 9. Members who borrowed '1984'
select m.member_name,br.borrow_date,br.return_date from borrowing br join members m on br.member_id=m.member_id join books b on br.book_id=b.book_id where b.title='1984';

-- 10. Bor;rowing history for member 1
select b.title,br.borrow_date,br.return_date from borrowing br join books b on br.book_id=b.book_id where br.member_id=1;

-- 11. Available Fiction books
 select title,author,published_year from books where genre='Fiction' and is_available=true;

-- 12. Total books borrowed per member
select m.member_name,count(br.loan_id)as total_books_borrowed from borrowing br join members m on br.member_id=m.member_id group by m.member_name;

-- 13. Overdue books not returned (>30 days) 
select m.member_name,b.title,br.borrow_date from borrowing br join members m on br.member_id=m.member_id join books b on br.book_id=b.book_id where br.return_date is null and br.borrow_date < current_date-interval 30 day;

-- 14. Top librarians by borrowings
select l.librarian_name,count(br.loan_id)as total_borrowings from borrowing br join librarians l on br.librarian_id=l.librarian_id group by l.librarian_name order by total_borrowings desc;

-- 15. Currently borrowed books
select m.member_name,b.title,br.borrow_date from borrowing br join members m on br.member_id=m.member_id join books b on br.book_id=b.book_id where br.return_date is null;




