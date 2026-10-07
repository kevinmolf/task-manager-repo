from datetime import datetime, timedelta

from app.storage import (
    format_task_report,
    days_until_due,
    build_query,
)


def test_manual_report_contains_task_information():
    tasks = [
        {"id": 1, "title": "Buy groceries"},
        {"id": 2, "title": "Study COMP 441"},
    ]

    result = format_task_report(tasks)

    assert "Buy groceries" in result
    assert "Study COMP 441" in result


def test_manual_report_empty_input():
    result = format_task_report([])

    assert result == ""


def test_manual_due_date_in_the_future():
    due_date = (datetime.now() + timedelta(days=10)).strftime("%Y-%m-%d")

    result = days_until_due(due_date)

    assert result >= 9


def test_manual_due_date_in_the_past():
    due_date = (datetime.now() - timedelta(days=10)).strftime("%Y-%m-%d")

    result = days_until_due(due_date)

    assert result <= -10


def test_manual_query_exact_structure():
    result = build_query("Study COMP 441")

    expected = "SELECT * FROM tasks WHERE title = 'Study COMP 441'"

    assert result == expected


def test_manual_query_preserves_title():
    title = "Final Year Project"

    result = build_query(title)

    assert title in result
    assert result.startswith("SELECT * FROM tasks WHERE title = ")
