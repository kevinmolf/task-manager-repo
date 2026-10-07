import csv
from pathlib import Path

import pytest

from pages.login_page import LoginPage


TEST_DATA = Path(__file__).resolve().parents[1] / "test_data" / "test_data.csv"


def load_test_data():
    with TEST_DATA.open(newline="", encoding="utf-8") as file:
        return list(csv.DictReader(file))


@pytest.mark.parametrize(
    "test_case",
    load_test_data(),
    ids=lambda row: row["test_id"],
)
def test_login_data_driven(driver, test_case):
    """
    Five UI scenarios are supplied entirely by CSV test data.
    """

    target_url = __import__("os").environ.get(
        "TARGET_URL",
        "http://host.docker.internal:8001/login.html"
    )

    login_page = LoginPage(driver)

    login_page.login(
        username=test_case["username"],
        password=test_case["password"],
        url=target_url,
    )

    actual_message = login_page.flash_message()

    assert test_case["expected_result"] in actual_message
