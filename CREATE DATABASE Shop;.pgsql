CREATE DATABASE Shop;

CREATE TABLE Manufacturers(
    id serial PRIMARY KEY,
    name varchar(20),
    info text,
    email varchar(30)
);

INSERT INTO Manufacturers(name, info, email) VALUES
('Samsung', 'Samsung Group — южнокорейская группа компаний, один из крупнейших чеболей, основанный в 1938 году.', 'samsung@gmail.com');

INSERT INTO Manufacturers(name, info, email) VALUES
('Xiaomi','Xiaomi Corporation — китайская корпорация, основанная Лэй Цзюнем в 2010 году.','xiaomi@gmail.com'),
('Apple','Apple — американская корпорация, производитель персональных и планшетных компьютеров, аудиоплееров, смартфонов, программного обеспечения и цифрового контента.','apple@gmail.com'),
('Huawei','Huawei Technologies Co. Ltd — китайская компания, одна из крупнейших мировых компаний в сфере телекоммуникаций.','huawei@gmail.com'),
('Oppo','OPPO Electronics Corporation — китайская компания, производитель потребительской электроники премиум-класса; подразделение корпорации BBK Electronics. Основана в 2001 году.','oppo@gmail.com');

SELECT * FROM Manufacturers;

CREATE TABLE Products(
    id serial PRIMARY KEY,
    userId int REFERENCES Manufacturers(id) NOT NULL,
    name varchar(60),
    info text,
    price money NOT NULL CHECK  (price >= money(0)),
    created_date date DEFAULT now() NOT NULL
);

DROP TABLE Products;

INSERT INTO Products(userId, name, info, price, created_date) VALUES
('1','SAMSUNG Galaxy A23','4/64GB White/Orange','9600','2020-12-01'),
('1','SAMSUNG Galaxy M32 ','6/128GB Black/Blue','9000','2020-10-01'),
('1','SAMSUNG Galaxy A13','4/128GB Black/Blue','6700','2019-04-01'),
('2','XIAOMI Redmi 9A','2/32GB Gray/Blue','4400','2018-12-01'),
('2','XIAOMI Redmi Note 10 Pro','6/128GB Gray/Bronze','11500','2021-08-01'),
('3','APPLE iPhone 12 Mini','64GB Gray/Blue/Red','23000','2021-12-01'),
('3','APPLE iPhone 13','256GB Gray/Blue/Red/Green','43000','2022-03-01'),
('4','HUAWEI Nova 9 SE','8/128GB Black','11000','2019-06-01'),
('5','OPPO A53','4/64GB Black/Blue','8000','2019-10-01'),
('5','OPPO A96','6/128GB Blue/Pink','11000','2019-05-01');

SELECT * FROM Products;

/*1 показать информацию о каком-то производителе*/
SELECT info FROM Manufacturers WHERE name='Apple';


/*2 показать информацию о каком-то товаре*/
SELECT info FROM Products WHERE id=4;


/*3 показать информацию о товаре и указанием контантов производителя*/
SELECT Products.name, Products.info, Products.price, Manufacturers.info, Manufacturers.email
FROM Manufacturers, Products 
WHERE Products.id = 6 and Manufacturers.id=Products.userId;


/*4 показать товары зарегистрированные c 1 сентября 2022 года*/
SELECT *
FROM  Products 
WHERE Products.created_date >= '2022-09-01';


/*5 показать товары дороже 500 грн*/
SELECT *
FROM  Products 
WHERE Products.price > '500';


/*6 показать товары дешевле 200 грн и сделаные до сентября*/
SELECT * 
FROM  Products 
WHERE Products.price < '200' and Products.created_date < '2022-09-01';

/*7 показать список товаров от конкретного произователя*/
SELECT Products
FROM Manufacturers, Products 
WHERE  Manufacturers.name='Samsung' and Manufacturers.id=Products.userId;


/*8 обновить контакты у конкретного произователя*/
UPDATE Manufacturers 
SET email='newmail@gmail.com' 
WHERE id=5;


/*9 обновить цену - снизить цену на 15% для товаров у которых заканчивается срок реализации (из запроса 6)*/
UPDATE Products
SET price= price*0.85
WHERE created_date < '2020-01-01';


/*10 удалить из базы конкретный товар для конкретного произователя */
DELETE 
FROM Products 
WHERE  Products.id=7;
