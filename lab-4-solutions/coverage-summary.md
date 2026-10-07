# COMP 441 — Lab 4 Coverage Summary

## Requirement Coverage

All eight supplied functional requirements have at least two associated test
cases.

| Requirement | Test Cases | Coverage |
|---|---|---|
| REQ-001 | TC-001, TC-002 | Covered |
| REQ-002 | TC-003, TC-004 | Covered |
| REQ-003 | TC-005, TC-006 | Covered |
| REQ-004 | TC-007, TC-008 | Covered |
| REQ-005 | TC-009, TC-010 | Covered |
| REQ-006 | TC-011, TC-012 | Covered |
| REQ-007 | TC-013, TC-014 | Covered |
| REQ-008 | TC-015, TC-016 | Covered |

## Coverage Result

- Requirements: 8
- Requirements covered: 8
- Coverage: 100%
- Test cases: 16
- Orphan test cases: 0
- Requirements without tests: 0

## Positive / Negative Coverage

Each requirement has at least one test case designed around the expected
behaviour. Negative and boundary cases are included where the requirement
defines rejection conditions or explicit limits.

## Risk Areas

The highest-priority requirements are REQ-001, REQ-002, REQ-003, REQ-005,
REQ-006, and REQ-007 because failures could prevent users from registering,
searching, borrowing, or correctly returning books and calculating fines.

REQ-003 also introduces a measurable performance requirement: matching results
must be returned within 2 seconds.

REQ-007 introduces a financial calculation requirement of P2.00 per overdue
day and therefore requires careful verification.

## Gaps

No requirement coverage gaps were identified in the designed RTM.

No orphan test cases were identified.

The status remains "Not Executed" because the supplied requirements are being
used for test-design and traceability work rather than claiming execution
against a completed library application.

## Final Verified Coverage

**Requirements:** 8/8 covered
**Requirement coverage:** 100%
**Test cases:** 16
**Requirements without tests:** 0
**Orphan test cases:** 0
**RTM status:** Not Executed for all 8 requirements

The 100% figure refers to requirements-to-test traceability coverage. It does
not represent code coverage or execution coverage of the Library Management
System.


**Requirements:** 8/8 covered
**Requirement coverage:** 100%
**Test cases:** 16
**Requirements without tests:** 0
**Orphan test cases:** 0
**RTM status:** Not Executed for all 8 requirements

The 100% figure refers to requirements-to-test traceability coverage. It does
not represent code coverage or execution coverage of the Library Management
System.
