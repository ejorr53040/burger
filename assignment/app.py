"""
Flask routes for your CRUD app.

TODO:
  1. Import your helpers from db.py once they are implemented.
  2. Fill in each route (follow lab stages 4-8).
  3. Update form field names to match your dataset columns.
"""

from flask import Flask, redirect, render_template, request, url_for  # noqa: F401

# from db import get_items, get_item, add_item, update_item, delete_item

app = Flask(__name__)


@app.route("/")
def home():
    """List all items."""
    # TODO: items = get_items()
    # TODO: return render_template("index.html", items=items)
    raise NotImplementedError("TODO: show the item list")


@app.route("/items/<int:item_id>")
def item_detail(item_id):
    """Show one item."""
    # TODO: item = get_item(item_id)
    # TODO: if item is None: return redirect(url_for("home"))
    # TODO: return render_template("detail.html", item=item)
    raise NotImplementedError("TODO: show one item")


@app.route("/items/new", methods=["GET", "POST"])
def create_item():
    """
    GET  → show an empty form
    POST → read request.form, call add_item(...), redirect home
    """
    # TODO: implement create
    raise NotImplementedError("TODO: create an item")


@app.route("/items/<int:item_id>/edit", methods=["GET", "POST"])
def edit_item(item_id):
    """
    GET  → show a form filled with get_item(item_id)
    POST → call update_item(...), redirect home
    """
    # TODO: implement edit
    raise NotImplementedError("TODO: edit an item")


@app.route("/items/<int:item_id>/delete", methods=["POST"])
def remove_item(item_id):
    """Delete an item, then redirect home."""
    # TODO: item = get_item(item_id)
    # TODO: if item is not None: delete_item(item_id)
    # TODO: return redirect(url_for("home"))
    raise NotImplementedError("TODO: delete an item")


if __name__ == "__main__":
    app.run(debug=True)
