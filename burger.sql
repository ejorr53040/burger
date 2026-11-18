-- Burger store sample database (SQLite), used by assignment/db.py.
-- Rebuild: sqlite3 assignment/items.db < burger.sql

DROP TABLE IF EXISTS Burger;

CREATE TABLE Burger (
  id        INTEGER PRIMARY KEY,
  name      TEXT    NOT NULL UNIQUE,
  category  TEXT    NOT NULL,
  year      INTEGER CHECK (year BETWEEN 1900 AND 2100) -- year the item joined the menu
);

INSERT INTO Burger (id, name, category, year) VALUES
  (1,  'Classic Burger',     'Burgers',  2018),
  (2,  'Cheeseburger',       'Burgers',  2018),
  (3,  'Double Bacon Smash', 'Burgers',  2022),
  (4,  'Mushroom Swiss',     'Burgers',  2020),
  (5,  'Spicy Jalapeno',     'Burgers',  2024),
  (6,  'Veggie Burger',      'Burgers',  2021),
  (7,  'BBQ Ranch Burger',   'Burgers',  2026),
  (8,  'Fries',              'Sides',    2018),
  (9,  'Sweet Potato Fries', 'Sides',    2021),
  (10, 'Onion Rings',        'Sides',    2019),
  (11, 'Side Salad',         'Sides',    2023),
  (12, 'Soda',               'Drinks',   2018),
  (13, 'Lemonade',           'Drinks',   2019),
  (14, 'Iced Tea',           'Drinks',   2020),
  (15, 'Chocolate Shake',    'Desserts', 2018),
  (16, 'Vanilla Shake',      'Desserts', 2018),
  (17, 'Apple Pie',          'Desserts', 2022);
