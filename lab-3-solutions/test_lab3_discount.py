import pytest

from app.tasks import calculate_discount


@pytest.mark.parametrize(
    "price,is_premium,expected",
    [
        (100, True, 80),
        (100, False, 100),
        (0, True, 0),
        (0, False, 0),
        (0.01, True, 0.008),
        (0.01, False, 0.01),
        (1, True, 0.8),
        (1, False, 1),
        (1000, True, 800),
        (1000, False, 1000),
        (999999.99, True, 799999.992),
        (999999.99, False, 999999.99),
    ],
)
def test_calculate_discount_equivalence_and_boundaries(
    price, is_premium, expected
):
    assert calculate_discount(price, is_premium) == pytest.approx(expected)
