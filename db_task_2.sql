-- Task 1
create table authors (
	id serial primary key, 
	first_name varchar(255),
	last_name varchar(255)
);

create table books(
	id serial primary key, 
	title varchar(255),
	author_id int,
	publication_year int,
	foreign key (author_id) references authors(id)
);

create table sales(
	id serial primary key, 
	book_id int,
	quantity int,
	foreign key (book_id) references books(id)
);

insert into authors (first_name, last_name)
	values ('Alexander', 'Pushkin'),
		   ('Anton', 'Chehov');
		  
		  
insert into books (title, author_id, publication_year)
	values ('Книга 1', 1, 1940),
		   ('Книга 2', 2, 1950);

		  	  
insert into sales (book_id, quantity)
	values (1, 20),
		   (2, 25);
	
-- Task 2
-- Добавление автора без книги
insert into authors (first_name, last_name)
	values ('Nikita', 'Zhukovsky');

insert into books (author_id)
	values (3);

-- Добавление книги без автора
insert into authors (first_name, last_name)
	values (null, null);

insert into books (title, author_id, publication_year)
	values ('Книга 4', 4, 2000);

insert into sales (book_id, quantity)
	values (4, 50);


select books.title, authors.first_name, authors.last_name
from books
inner join authors on books.author_id = authors.id 
where books.title is not null ;


select authors.first_name, authors.last_name, books.title
from authors
left join books on authors.id = books.author_id 
where authors.first_name is not null and authors.last_name is not null;


select books.title, authors.first_name, authors.last_name
from books
right join authors on books.author_id = authors.id
where books.title is not null;

-- Task 3
select books.title, authors.first_name, authors.last_name, sales.quantity
from books
inner join authors on books.author_id = authors.id 
inner join sales on books.id = sales.book_id;


select authors.first_name, authors.last_name, books.title, sales.quantity
from authors
left join books on authors.id = books.author_id
left join sales on books.id = sales.book_id;

-- Task 4
-- Добавление ещё нескольких книг имеющимся авторам 
insert into books (title, author_id, publication_year)
	values ('Книга 5', 1, 1945),
		   ('Книга 6', 2, 1952);
  	  
insert into sales (book_id, quantity)
	values (5, 45),
		   (6, 30);
		  
		  
select authors.first_name, authors.last_name, sum(sales.quantity) as total_sales
from authors
inner join books on authors.id = books.author_id
inner join sales on books.id = sales.book_id
group by authors.first_name, authors.last_name;


select authors.first_name, authors.last_name, sum(sales.quantity) as total_sales
from authors
left join books on authors.id = books.author_id
left join sales on books.id = sales.book_id
group by authors.first_name, authors.last_name;

-- Task 5
select authors.first_name, authors.last_name, sum(sales.quantity) as total_sales
from authors
inner join books on authors.id = books.author_id
inner join sales on books.id = sales.book_id
group by authors.first_name, authors.last_name
having sum(sales.quantity) = (
    select max(total_sales)
    from (
        select authors.id, sum(sales.quantity) as total_sales
        from authors
        inner join books on authors.id = books.author_id
        inner join sales on books.id = sales.book_id
        group by authors.id
    )
);

select books.title, sales.quantity
from books
inner join sales on books.id = sales.book_id
where sales.quantity > (select avg(quantity) from sales);
