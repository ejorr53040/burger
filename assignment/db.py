"""
Database helpers for your CRUD app.

TODO:
  1. Create your SQLite database with an external tool and put the .db
     file in this folder (for example items.db).
  2. Set DATABASE to that file.
  3. Change column names / function parameters to match your table.
  4. Replace each NotImplementedError with real sqlite3 code.

Pattern from the lab:

    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    rows = conn.execute("SELECT ...", (...)).fetchall()
    conn.close()
    return rows
"""

import sqlite3
from sqlite3 import Connection, Cursor
from pathlib import Path

DATABASE = Path(__file__).parent / "items.db"


def connecting_to_database() -> tuple[Connection, Cursor]:
    conn = sqlite3.connect(DATABASE)
    cur = conn.cursor()
    return (conn, cur)


def get_items():
    """Return all items (list of rows)."""
    conn, cur = connecting_to_database()
    cur.execute("""SELECT * From Burger""")
    conn.close()


def get_item(item_id):
    """Return one item by id, or None if it does not exist."""
    conn, cur = connecting_to_database()
    cur.execute("""SELECT * From Burger WHERE id = ?""", (item_id,))
    conn.close()


def add_item(name, category, year):
    """
    Insert a new item.

    TODO: change the parameters to match your columns.
    """
    conn, cur = connecting_to_database()
    cur.execute(
        "INSERT INTO Burger (name, category, year) VALUES (?,?,?)",
        (name, category, year),
    )
    conn.commit()
    conn.close()


def update_item(item_id, name, category, year):
    """
    Update an existing item.

    TODO: change the parameters to match your columns.
    """
    conn, cur = connecting_to_database()
    cur.execute(
        "UPDATE BURGER SET name = ?, category = ?, year = ? WHERE id = ?",
        (name, category, year, item_id),
    )
    conn.commit()
    conn.close()


def delete_item(item_id):
    """Delete an item by id."""
    conn, cur = connecting_to_database()
    cur.execute("DELETE FROM Burger Where id = ?", (item_id))
    conn.commit()
    conn.close()
