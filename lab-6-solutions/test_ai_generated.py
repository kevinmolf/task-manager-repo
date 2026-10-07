from datetime import datetime, timedelta

from app.storage import (
    format_task_report,
    days_until_due,
    build_query,
)


def test_format_task_report_multiple_tasks():
    tasks = [
        {"id": 1, "title": "Write report"},
        {"id": 2, "title": "Submit assignment"},
    ]

    report = format_task_report(tasks)

    assert "Write report" in report
    assert "Submit assignment" in report
    assert "\n" in report


def test_format_task_report_empty_list():
    assert format_task_report([]) == ""


def test_days_until_due_future_date():
    future_date = (datetime.now() + timedelta(days=5)).strftime("%Y-%m-%d")

    result = days_until_due(future_date)

    assert 4 <= result <= 5


def test_days_until_due_past_date():
    past_date = (datetime.now() - timedelta(days=5)).strftime("%Y-%m-%d")

    result = days_until_due(past_date)

    assert -6 <= result <= -5


def test_build_query_with_title():
    query = build_query("Write report")

    assert query == "SELECT * FROM tasks WHERE title = 'Write report'"


def test_build_query_empty_title():
    query = build_query("")

    assert query == "SELECT * FROM tasks WHERE title = ''"
