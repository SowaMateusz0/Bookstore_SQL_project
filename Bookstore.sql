
CREATE database bookstore;
USE bookstore;
SHOW tables;

DROP table books;
DROP table author;

SELECT * FROM books;
SELECT * FROM author;

CREATE TABLE books
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    title CHAR(50),
    publication_year INT(4),
    type CHAR(20),
    author_id INT,
    rating DEC(2,1),
	number_of_readers INT,
	number_of_reviews INT,
	FOREIGN KEY(author_id) REFERENCES author(id)	
);
    
CREATE TABLE author
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    author_name CHAR(20),
    author_surname CHAR(20)
);    
    

INSERT INTO author(author_name,author_surname) 
VALUES 
("George R.R","Martin"),
("J.K.","Rowling"),
("Margaret","Mitchell"),
("Steven","Erikson"),
("Paulo","Coelho"),
("Blanca","Miosi"),
("Ewa","Stachniak"),
("Stephen","King"),
("Carlos","Ruiz Zafón");

INSERT INTO books (title,publication_year,type,author_id,rating,number_of_readers,number_of_reviews) 
VALUES 
("A Game of Thrones",2005,"fantasy",1,8.4,64621,37297),
("A Clash of Kings",1999,"fantasy",1,8.4,41433,25477),
("A Storm of Swords: Steel and Snow",2001,"fantasy",1,8.4,36464,21959),
("Harry Potter and the Philosopher's Stone",1997,"fantasy",2,6.3,28784,17211),
("Gardens of the Moon",1999,"fantasy",4,7.6,8083,2464),
("Gone with the Wind",1976,"history",3,8.5,20677,9618),
("O Monte Cinco",2003,"history",5,5.8,8705,4944),
("La Búsqueda, el niño que se enfrentó a los nazis",2022,"history",6,9.1,32,10),
("The Winter Palace",2012,"history",7,7.1,4761,1900),
("Pet Sematary",1983,"horror",8,7.6,35827,20475),
("Carrie",1981,"horror",8,6.9,32099,19037),
("El príncipe de la niebla",2006,"horror",9,6.8,21683,12570),
("It",1987,"horror",8,6.8,21683,12570);

-- select the oldest book   
SELECT title, publication_year FROM books ORDER BY publication_year LIMIT 1 ;    
    
-- select the newest book with descending order    
SELECT title, publication_year FROM books ORDER BY publication_year DESC LIMIT 1 ;     
    
-- select book with the rating greater then 7 with descending order
SELECT title, rating FROM books WHERE rating > 7 ORDER BY rating DESC;    

-- select book with the worst rating
SELECT rating, title FROM books WHERE rating = (SELECT MIN(rating) FROM books);

-- select name and surname and concat them
SELECT DISTINCT CONCAT(author_name," ",author_surname) AS author FROM author;
    
 -- select title and rating and send feedback by rating   
 SELECT title,rating,
	CASE
		WHEN rating > 9 THEN 'positive'
		WHEN rating < 9 AND rating >= 6 THEN 'average'
		WHEN rating < 6 AND rating >= 4.0 THEN 'below average'
        ELSE 'no rating' 
	END AS "opinion"
    FROM books ORDER BY rating DESC;   
    
-- select all books with authors   
SELECT books.id, books.title, CONCAT(author_name," ",author_surname) AS "author"  FROM books RIGHT JOIN author ON books.author_id = author.id ORDER BY author;    

-- select authors and count theirs books
SELECT COUNT(*) AS "number of books", CONCAT(author_name," ",author_surname) AS author FROM books JOIN author ON books.author_id = author.id GROUP BY author;

-- select books with publication year between 2000-2005
SELECT publication_year,title FROM books WHERE publication_year BETWEEN 2000 AND 2005 GROUP BY publication_year ORDER BY publication_year;

-- select books and find authors with more then one book
SELECT CONCAT(author.author_name," ",author.author_surname) AS 'author_name', COUNT(*) AS 'books' FROM author JOIN books ON author.id = books.author_id GROUP BY author_name HAVING books > 1 ORDER BY books DESC;

-- select George R.R Martin books and display average rating of his all books
SELECT AVG(rating) FROM books JOIN author ON books.author_id = author.id WHERE CONCAT(author.author_name," ",author.author_surname) LIKE 'George R.R Martin';