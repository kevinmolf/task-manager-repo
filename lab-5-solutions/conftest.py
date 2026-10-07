import os
import re
from pathlib import Path

import pytest
from selenium import webdriver


ROOT = Path(__file__).resolve().parent
EVIDENCE_DIR = ROOT / "evidence"


@pytest.fixture
def driver(request):
    """
    Run against Selenium Grid directly or through Healenium Proxy.

    HEALENIUM=0 -> Selenium Grid :4444
    HEALENIUM=1 -> Healenium Proxy :8085
    """

    use_healenium = os.getenv("HEALENIUM", "0") == "1"

    if use_healenium:
        command_executor = "http://127.0.0.1:8085"
    else:
        command_executor = "http://127.0.0.1:4444"

    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--window-size=1280,900")

    driver = webdriver.Remote(
        command_executor=command_executor,
        options=options,
    )

    driver.set_window_size(1280, 900)

    yield driver

    run_label = os.getenv("RUN_LABEL", "unlabelled")
    safe_name = re.sub(r"[^A-Za-z0-9_.-]", "_", request.node.name)

    output_dir = EVIDENCE_DIR / run_label
    output_dir.mkdir(parents=True, exist_ok=True)

    try:
        driver.save_screenshot(
            str(output_dir / f"{safe_name}.png")
        )
    except Exception:
        pass

    driver.quit()
