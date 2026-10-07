# COMP 441 — Lab 4 Test Design

The laboratory manual requires at least one test case for each requirement.
The course study material additionally recommends positive and negative cases.
Therefore, two test cases were designed for each requirement.

| Test ID | Requirement | Test Description | Test Type | Expected Result | Priority |
|---|---|---|---|---|---|
| TC-001 | REQ-001 | Register using a unique email and password with exactly 8 characters | Positive / Boundary | Registration succeeds | High |
| TC-002 | REQ-001 | Attempt registration with a password shorter than 8 characters | Negative / Boundary | Registration is rejected | High |
| TC-003 | REQ-002 | Register using an email already associated with an account | Negative | Registration is rejected and an error is displayed | High |
| TC-004 | REQ-002 | Register using a new unused email | Positive | Registration succeeds | High |
| TC-005 | REQ-003 | Search catalogue by an existing book title | Positive | Matching results are returned within 2 seconds | High |
| TC-006 | REQ-003 | Search catalogue using an existing ISBN | Positive | Matching book is returned within 2 seconds | High |
| TC-007 | REQ-004 | Search for a title that does not exist | Negative | "No results found" is displayed | Medium |
| TC-008 | REQ-004 | Search using a non-existent ISBN | Negative | "No results found" is displayed | Medium |
| TC-009 | REQ-005 | Registered user borrows one available book | Positive | Book is borrowed with a 14-day loan period | High |
| TC-010 | REQ-005 | Registered user borrows a third available book while having two active loans | Boundary / Positive | Third book is successfully borrowed | High |
| TC-011 | REQ-006 | User with three active loans attempts to borrow another book | Negative / Boundary | Borrowing is prevented | High |
| TC-012 | REQ-006 | User with an overdue item attempts to borrow an available book | Negative | Borrowing is prevented | High |
| TC-013 | REQ-007 | User returns a book before its due date | Positive | Return is recorded and book becomes available | High |
| TC-014 | REQ-007 | User returns a book two days late | Boundary / Calculation | Return is recorded, availability is updated, and fine is P4.00 | High |
| TC-015 | REQ-008 | Verify notification two days before the book's due date | Positive / Boundary | Reminder email is sent | Medium |
| TC-016 | REQ-008 | Verify notification for a book that is one day overdue | Positive / Boundary | Overdue email is sent | Medium |
