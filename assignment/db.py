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
from pathlib import Path

DATABASE = Path(__file__).parent / "items.db"


def get_items():
    """Return all items (list of rows)."""
    raise NotImplementedError("TODO: SELECT all rows from your table")


def get_item(item_id):
    """Return one item by id, or None if it does not exist."""
    raise NotImplementedError("TODO: SELECT one row WHERE id = ?")


def add_item(name, category, year):
    """
    Insert a new item.

    TODO: change the parameters to match your columns.
    """
    raise NotImplementedError("TODO: INSERT a row")


def update_item(item_id, name, category, year):
    """
    Update an existing item.

    TODO: change the parameters to match your columns.
    """
    raise NotImplementedError("TODO: UPDATE a row WHERE id = ?")


def delete_item(item_id):
    """Delete an item by id."""
    raise NotImplementedError("TODO: DELETE a row WHERE id = ?")
