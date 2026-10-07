from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class LoginPage:
    """
    Page Object Model for the COMP 441 login sample application.

    The login button locator is intentionally kept as:
        id="login-submit"

    Lab 5 later changes the application DOM to:
        id="login-button"

    The test code is deliberately NOT changed during the drift experiment.
    This allows Selenium failure and Healenium recovery to be compared.
    """

    USERNAME = (By.ID, "username")
    PASSWORD = (By.ID, "password")

    # INTENTIONAL BASELINE LOCATOR
    LOGIN_BUTTON = (By.ID, "login-submit")

    FLASH = (By.ID, "flash")

    def __init__(self, driver):
        self.driver = driver
        self.wait = WebDriverWait(driver, 10)

    def open(self, url):
        self.driver.get(url)
        self.wait.until(
            EC.visibility_of_element_located(self.USERNAME)
        )

    def enter_username(self, username):
        field = self.wait.until(
            EC.visibility_of_element_located(self.USERNAME)
        )
        field.clear()
        field.send_keys(username)

    def enter_password(self, password):
        field = self.wait.until(
            EC.visibility_of_element_located(self.PASSWORD)
        )
        field.clear()
        field.send_keys(password)

    def click_login(self):
        button = self.wait.until(
            EC.element_to_be_clickable(self.LOGIN_BUTTON)
        )
        button.click()

    def login(self, username, password, url):
        self.open(url)
        self.enter_username(username)
        self.enter_password(password)
        self.click_login()

    def flash_message(self):
        flash = self.wait.until(
            EC.visibility_of_element_located(self.FLASH)
        )
        return flash.text
