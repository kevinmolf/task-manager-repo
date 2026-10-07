# COMP 441 — Lab 4 Mini Test Plan

## 1. Selected Requirement

**Requirement:** REQ-007

> The system shall record a return, update book availability, and calculate any
> overdue fine at P2.00 per day.

## 2. Scope

This test-plan section verifies the return-processing behaviour described by
REQ-007.

Testing covers:

- recording a returned book;
- updating the book's availability;
- calculating overdue fines;
- verifying the P2.00-per-day calculation.

Out of scope:

- user registration;
- catalogue searching;
- borrowing eligibility;
- email notification delivery.

## 3. Test Level

System-level functional testing.

## 4. Entry Criteria

Testing may begin when:

- a test environment is available;
- a registered test user exists;
- a test book exists in the catalogue;
- the book can be associated with an active loan; and
- the return-processing feature is available.

## 5. Exit Criteria

Testing is complete when:

- all planned REQ-007 test cases have been executed;
- expected and actual results have been recorded;
- identified defects have been logged; and
- no unresolved High-severity defects remain for the selected requirement.

## 6. Test Cases

### TC-013 — On-time return

Input:
- Book is currently borrowed.
- Book is returned before the due date.

Expected:
- Return is recorded.
- Book availability is updated.
- No overdue fine is charged.

### TC-014 — Two-day overdue return

Input:
- Book is returned two days after its due date.

Expected:
- Return is recorded.
- Book availability is updated.
- Fine = 2 days × P2.00 = P4.00.

## 7. Risks

Potential risks include incorrect date calculations, incorrect availability
updates, and incorrect fine calculations.

## 8. Traceability

REQ-007 is covered by TC-013 and TC-014.
