# COMP 441 — Lab 4 Defect Lifecycle Log

The laboratory requires two sample defects to be moved through:

**New → Triaged → Assigned → Fixed → Verified → Closed**

These are sample defects used for defect-management practice. They are not
claims that the instructor's sample Library Management System was actually
modified and executed.

---

## DEF-001 — Duplicate email accepted

**Requirement:** REQ-002
**Severity:** High
**Priority:** High

### New

The defect was identified as a hypothetical registration failure in which an
email address already associated with an existing account is accepted rather
than rejected.

### Triaged

The defect was mapped to REQ-002.

Severity was classified as **High** because accepting duplicate registration
violates an explicit functional requirement and may result in inconsistent
account data.

Priority was classified as **High** because registration validation is a
core functional requirement.

### Assigned

The defect would be assigned to the registration implementation owner.

### Fixed

For the lifecycle exercise, the proposed correction is to validate whether the
email already exists and reject the registration when it does.

### Verified

A regression test would attempt registration using an already-registered email
and verify that registration is rejected and an appropriate error message is
displayed.

### Closed

The defect would be closed after the proposed fix passed verification.

---

## DEF-002 — Incorrect overdue fine calculation

**Requirement:** REQ-007
**Severity:** High
**Priority:** High

### New

The defect was identified as a hypothetical return-processing failure in which
the overdue fine is not calculated according to the required P2.00-per-day rule.

### Triaged

The defect was mapped to REQ-007.

Severity was classified as **High** because the defect can produce incorrect
financial calculations.

Priority was classified as **High** because incorrect charges should be
resolved before release.

### Assigned

The defect would be assigned to the return-processing implementation owner.

### Fixed

For the lifecycle exercise, the proposed correction is:

`overdue_days × P2.00`

### Verified

A regression test would use a two-day overdue return and verify an expected fine
of **P4.00**, while also checking that the return is recorded and book
availability is updated.

### Closed

The defect would be closed after the proposed fix passed verification.
