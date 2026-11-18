# Assignment — Your Own Flask CRUD App

Build a small Flask app that creates, reads, updates, and deletes rows for a dataset **you** choose.

You already practiced the pattern in the lab (stages 1–8). This assignment is that same pattern, applied to your data.

## Requirements

### Database (built outside Flask)

- Pick a domain you care about (recipes, trails, cameras, courses, plants, …).
- Create a SQLite database with an external tool (DB Browser for SQLite, TablePlus, the `sqlite3` CLI, Pandas, etc.).
- Your main table should have:
  - a primary key `id`
  - **at least 3** meaningful columns
  - **at least 15** rows to start
- Save the `.db` file in this folder (for example `items.db`) and point `DATABASE` in `db.py` at it.

### Flask helpers (`db.py`)

Implement these functions (rename columns/parameters to match your schema if needed):

| Function | Purpose |
|----------|---------|
| `get_items()` | return all rows |
| `get_item(item_id)` | return one row, or `None` |
| `add_item(...)` | insert a row |
| `update_item(item_id, ...)` | update a row |
| `delete_item(item_id)` | delete a row |

Use parameterized SQL (`?` placeholders). Do not build queries with f-strings from user input.

### Flask app

Your app must support full CRUD in the browser:

| Action | Behavior |
|--------|----------|
| **List** | home page shows all items in a table |
| **Detail** | click an item to see a detail page |
| **Create** | form to add an item, then return to the list |
| **Update** | form pre-filled with the current values |
| **Delete** | remove an item with a **POST** form (not a plain link) |

Starter files give you the layout and placeholder functions. Fill them in and adjust names/fields for your dataset.

## How to work

```bash
# from the project root (same venv as the lab)
source .venv/bin/activate
cd assignment

# 1. Create your .db with an external tool and put it in this folder
# 2. Implement db.py helpers and wire up app.py + templates
python app.py
```

Open http://127.0.0.1:5000/

Tip: keep `db.py` responsible for SQL and `app.py` responsible for routes/forms — same split as lab stage 8.

## TA checklist

| Check | Expectation |
|-------|-------------|
| Database | SQLite file exists; ≥15 rows; ≥3 useful columns |
| DB helpers | All five helpers work; parameterized queries |
| Read | List + detail pages show real data |
| Create | Form inserts a row |
| Update | Form edits a row |
| Delete | POST delete removes a row |
| Demo | Student can run the app and walk through CRUD |

## Academic honesty

You may discuss ideas with classmates. The database and code you demo must be your own.
