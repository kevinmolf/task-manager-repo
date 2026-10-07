# COMP 441 — Lab 6: AI-Generated Test Cases & Coverage Delta

**Student:** Boago Kevin Molefi
**Student ID:** 23018916

## Objective

Compare AI-generated and independently written tests for three functions in `app/storage.py` using PyTest and coverage analysis.

## Selected Functions

- `format_task_report()`
- `days_until_due()`
- `build_query()`

## Test Results

| Suite | Tests | Passed | Failed | Coverage |
|---|---:|---:|---:|---:|
| AI-only | 6 | 5 | 1 | 94% |
| Manual-only | 6 | 5 | 1 | 94% |
| Combined | 12 | 10 | 2 | 94% |

The failing report tests expose the same application defect in `format_task_report()`. The failures are reported honestly and are not treated as passing tests.

## Assertion Comparison

- **AI-only:** 6 tests, 12 assertions
- **Manual-only:** 6 tests, 9 assertions
- **Combined:** 12 tests, 21 assertions

The AI-generated suite has more assertions overall, but its multiple-task report test is less specific because it checks expected content and newline structure rather than validating the complete expected output.

The manually written tests provide stronger semantic checks for the selected functionality.

## Coverage Analysis

Both the AI-only and manual-only suites achieved **94% statement coverage**. Combining both suites also achieved **94% coverage**, indicating that the additional tests did not increase statement coverage for the selected module.

The coverage report identifies one uncovered statement in the analysed code.

## Evidence

- `evidence/01_ai_only_coverage.txt`
- `evidence/02_manual_only_coverage.txt`
- `evidence/03_combined_coverage.txt`
- `evidence/04_lab6_test_run.txt`
- `evidence/05_final_combined_coverage.txt`
- `reports/combined-html/index.html`
- `reports/COMP441_Lab6_Submission_Report_FINAL.docx`

## Conclusion

AI-generated tests can provide useful functional coverage quickly, but coverage percentage alone does not establish test quality. The comparison shows the importance of assertion specificity and independent review when evaluating AI-generated tests.
