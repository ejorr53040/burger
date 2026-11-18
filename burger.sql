-- Burger store sample database (SQLite).
-- Rebuild: sqlite3 burger.db < burger.sql
-- Prices are integer cents. Timestamps are ISO-8601 text (UTC).

PRAGMA foreign_keys = ON;

DROP VIEW  IF EXISTS order_totals;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  id    INTEGER PRIMARY KEY,
  name  TEXT NOT NULL UNIQUE
);

CREATE TABLE menu_items (
  id           INTEGER PRIMARY KEY,
  category_id  INTEGER NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
  name         TEXT    NOT NULL UNIQUE,
  description  TEXT,
  price_cents  INTEGER NOT NULL CHECK (price_cents >= 0),
  calories     INTEGER CHECK (calories >= 0),
  is_available INTEGER NOT NULL DEFAULT 1 CHECK (is_available IN (0, 1)),
  created_at   TEXT    NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%SZ', 'now'))
);

CREATE TABLE customers (
  id          INTEGER PRIMARY KEY,
  first_name  TEXT NOT NULL,
  last_name   TEXT NOT NULL,
  email       TEXT NOT NULL UNIQUE,
  phone       TEXT,
  created_at  TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%SZ', 'now'))
);

CREATE TABLE orders (
  id           INTEGER PRIMARY KEY,
  customer_id  INTEGER REFERENCES customers(id) ON DELETE SET NULL, -- NULL = walk-in
  status       TEXT NOT NULL DEFAULT 'pending'
               CHECK (status IN ('pending', 'preparing', 'ready', 'completed', 'cancelled')),
  order_type   TEXT NOT NULL DEFAULT 'dine_in'
               CHECK (order_type IN ('dine_in', 'takeout', 'delivery')),
  notes        TEXT,
  created_at   TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%SZ', 'now'))
);

-- unit_price_cents snapshots the menu price at order time, so later menu edits don't rewrite history.
CREATE TABLE order_items (
  id                INTEGER PRIMARY KEY,
  order_id          INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  menu_item_id      INTEGER NOT NULL REFERENCES menu_items(id) ON DELETE RESTRICT,
  quantity          INTEGER NOT NULL CHECK (quantity > 0),
  unit_price_cents  INTEGER NOT NULL CHECK (unit_price_cents >= 0),
  special_request   TEXT
);

CREATE INDEX idx_menu_items_category ON menu_items(category_id);
CREATE INDEX idx_orders_customer     ON orders(customer_id);
CREATE INDEX idx_order_items_order   ON order_items(order_id);

CREATE VIEW order_totals AS
SELECT o.id AS order_id,
       COALESCE(SUM(oi.quantity * oi.unit_price_cents), 0) AS total_cents,
       COALESCE(SUM(oi.quantity), 0) AS item_count
FROM orders o
LEFT JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id;

-- ---------- seed data ----------

INSERT INTO categories (id, name) VALUES
  (1, 'Burgers'),
  (2, 'Sides'),
  (3, 'Drinks'),
  (4, 'Desserts');

INSERT INTO menu_items (id, category_id, name, description, price_cents, calories, is_available, created_at) VALUES
  (1,  1, 'Classic Burger',       'Beef patty, lettuce, tomato, onion, pickles, house sauce', 899,  650,  1, '2026-01-05T10:00:00Z'),
  (2,  1, 'Cheeseburger',         'Classic burger with American cheese',                       999,  720,  1, '2026-01-05T10:00:00Z'),
  (3,  1, 'Double Bacon Smash',   'Two smashed patties, bacon, cheddar, caramelized onions',  1399, 1150, 1, '2026-01-05T10:00:00Z'),
  (4,  1, 'Mushroom Swiss',       'Beef patty, sauteed mushrooms, Swiss cheese, garlic aioli',1149, 780,  1, '2026-01-05T10:00:00Z'),
  (5,  1, 'Spicy Jalapeno',       'Pepper jack, jalapenos, chipotle mayo',                    1099, 760,  1, '2026-02-10T10:00:00Z'),
  (6,  1, 'Veggie Burger',        'Black bean patty, avocado, sprouts, tomato',               1049, 540,  1, '2026-01-05T10:00:00Z'),
  (7,  1, 'BBQ Ranch Burger',     'Onion rings, BBQ sauce, ranch, cheddar',                   1199, 890,  0, '2026-03-01T10:00:00Z'),
  (8,  2, 'Fries',                'Skin-on, sea salt',                                         399, 380,  1, '2026-01-05T10:00:00Z'),
  (9,  2, 'Sweet Potato Fries',   'With maple dip',                                            449, 410,  1, '2026-01-05T10:00:00Z'),
  (10, 2, 'Onion Rings',          'Beer-battered',                                             499, 480,  1, '2026-01-05T10:00:00Z'),
  (11, 2, 'Side Salad',           'Mixed greens, vinaigrette',                                 549, 150,  1, '2026-01-05T10:00:00Z'),
  (12, 3, 'Soda',                 'Cola, lemon-lime, or root beer',                            249, 200,  1, '2026-01-05T10:00:00Z'),
  (13, 3, 'Lemonade',             'Fresh-squeezed',                                            349, 180,  1, '2026-01-05T10:00:00Z'),
  (14, 3, 'Iced Tea',             'Unsweetened',                                               249, 5,    1, '2026-01-05T10:00:00Z'),
  (15, 4, 'Chocolate Shake',      'Hand-spun',                                                 599, 720,  1, '2026-01-05T10:00:00Z'),
  (16, 4, 'Vanilla Shake',        'Hand-spun',                                                 599, 680,  1, '2026-01-05T10:00:00Z'),
  (17, 4, 'Apple Pie',            'Warm, with cinnamon sugar',                                 349, 300,  1, '2026-01-05T10:00:00Z');

INSERT INTO customers (id, first_name, last_name, email, phone, created_at) VALUES
  (1, 'Ava',    'Martinez', 'ava.martinez@example.com', '555-0101', '2026-02-01T18:20:00Z'),
  (2, 'Liam',   'Chen',     'liam.chen@example.com',    '555-0102', '2026-02-14T12:05:00Z'),
  (3, 'Sofia',  'Patel',    'sofia.patel@example.com',  NULL,       '2026-03-09T19:45:00Z'),
  (4, 'Noah',   'Johnson',  'noah.j@example.com',       '555-0104', '2026-04-22T13:30:00Z'),
  (5, 'Mia',    'Okafor',   'mia.okafor@example.com',   '555-0105', '2026-06-03T17:10:00Z'),
  (6, 'Ethan',  'Brooks',   'ethan.brooks@example.com', NULL,       '2026-08-18T20:00:00Z');

INSERT INTO orders (id, customer_id, status, order_type, notes, created_at) VALUES
  (1,  1,    'completed', 'dine_in',  NULL,                     '2026-11-10T12:15:00Z'),
  (2,  2,    'completed', 'takeout',  NULL,                     '2026-11-11T18:40:00Z'),
  (3,  NULL, 'completed', 'dine_in',  'Walk-in',                '2026-11-12T13:05:00Z'),
  (4,  3,    'cancelled', 'delivery', 'Customer cancelled',     '2026-11-13T19:30:00Z'),
  (5,  4,    'completed', 'delivery', 'Leave at door',          '2026-11-15T20:10:00Z'),
  (6,  1,    'ready',     'takeout',  NULL,                     '2026-11-18T11:50:00Z'),
  (7,  5,    'preparing', 'dine_in',  'Table 4',                '2026-11-18T12:02:00Z'),
  (8,  6,    'pending',   'delivery', 'Ring bell twice',        '2026-11-18T12:10:00Z');

INSERT INTO order_items (order_id, menu_item_id, quantity, unit_price_cents, special_request) VALUES
  (1, 2,  1,  999, NULL),
  (1, 8,  1,  399, NULL),
  (1, 12, 1,  249, NULL),
  (2, 3,  2, 1399, 'No onions on one'),
  (2, 10, 1,  499, NULL),
  (2, 15, 2,  599, NULL),
  (3, 1,  1,  899, 'No pickles'),
  (3, 14, 1,  249, NULL),
  (4, 6,  1, 1049, NULL),
  (4, 11, 1,  549, NULL),
  (5, 4,  1, 1149, NULL),
  (5, 5,  1, 1099, 'Extra jalapenos'),
  (5, 9,  2,  449, NULL),
  (5, 13, 2,  349, NULL),
  (6, 2,  1,  999, NULL),
  (6, 17, 1,  349, NULL),
  (7, 6,  1, 1049, 'Gluten-free bun'),
  (7, 8,  1,  399, NULL),
  (7, 16, 1,  599, NULL),
  (8, 3,  1, 1399, NULL),
  (8, 1,  2,  899, NULL),
  (8, 8,  3,  399, NULL),
  (8, 12, 3,  249, NULL);
