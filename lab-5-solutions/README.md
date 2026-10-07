# COMP 441 Lab 5 — Test Automation Framework & Self-Healing Locators

**Student:** Boago Kevin Molefi
**Student ID:** 23018916

## Objective

Build a Selenium-based UI automation suite using the Page Object Model and
five CSV-driven test cases, then evaluate Healenium self-healing under an
intentional locator change.

## Framework

- Python
- PyTest
- Selenium
- Selenium Grid
- Healenium Proxy
- Docker Compose
- CSV test data

## Test Cases

| ID | Scenario |
|---|---|
| TC-001 | Valid credentials |
| TC-002 | Invalid password |
| TC-003 | Invalid username |
| TC-004 | Blank username |
| TC-005 | Blank password |

## Page Object Model

`pages/login_page.py` contains:

- username locator
- password locator
- login-button locator
- flash-message locator
- page actions

The test file contains no UI locator definitions.

## Data-Driven Design

All five scenarios are read from:

`test_data/test_data.csv`

The test cases are parameterized using PyTest.

## UI Drift Experiment

Baseline locator:

`id="login-submit"`

The application is intentionally modified to:

`id="login-button"`

The test automation code is NOT modified.

### Expected results

| Run | Browser target | Expected result |
|---|---|---|
| Baseline direct Selenium | Original UI | 5 PASS |
| Healenium learning run | Original UI | 5 PASS |
| Drift without Healenium | Changed locator | 5 FAIL |
| Drift with Healenium | Changed locator | 5 PASS if healing succeeds |

## Healing Analysis

Healenium is expected to detect that the original locator no longer
identifies the login button, compare the stored baseline DOM with the
current DOM, and select a suitable replacement locator.

The actual healing result, score, selected locator, and success/failure
must be taken from the Healenium report and logs rather than assumed.

## Evidence

Evidence is stored under:

`evidence/`

Important evidence:

- baseline direct Selenium output
- Healenium learning output
- drift failure output
- Healenium healing output
- screenshots
- Healenium report screenshot

## Healenium Report

After the healing run, inspect the local Healenium report and capture
the healing decision, failed locator, healed locator, score, and screenshot.

## Reflection

Self-healing is expected to work well for small DOM changes such as
renamed IDs/classes where the surrounding element structure remains
similar. It is less reliable when elements are removed, replaced by
semantically different elements, heavily restructured, or when several
candidate elements are equally similar.

A green test after healing is therefore not automatically proof that the
locator was healed correctly. The healing report must be inspected to
verify that the selected element was the intended one.

## Reproducibility

Start the local sample application and Healenium stack, then execute the
baseline, learning, drift, and healing runs described in the lab evidence.

## Completion Status

This README must only be considered complete after the actual commands
have been executed and their results recorded in `evidence/`.
