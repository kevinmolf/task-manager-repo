# COMP 441 — Lab 4 Requirements Baseline

The following requirements are the supplied/sample Library Management System
requirements used as the basis for the Lab 4 Requirements Traceability Matrix.

| REQ-ID | Area | Requirement | Priority |
|---|---|---|---|
| REQ-001 | User registration | The system shall allow a new user to register with a unique email address and a password of at least 8 characters. | High |
| REQ-002 | User registration | The system shall reject registration when the email address is already in use and display an error message. | High |
| REQ-003 | Book search | The system shall allow users to search the catalogue by title, author, or ISBN and return matching results within 2 seconds. | High |
| REQ-004 | Book search | The system shall display "No results found" when a search returns no matches. | Medium |
| REQ-005 | Book borrowing | A registered user shall be able to borrow up to 3 available books at a time for a 14-day loan period. | High |
| REQ-006 | Book borrowing | The system shall prevent borrowing when the user already has 3 books on loan or an overdue item. | High |
| REQ-007 | Return processing | The system shall record a return, update book availability, and calculate any overdue fine at P2.00 per day. | High |
| REQ-008 | Overdue notifications | The system shall email the user 2 days before the due date and again on each day the book is overdue. | Medium |
