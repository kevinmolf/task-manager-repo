# COMP 441 — Lab 4 AI-Assisted RTM Comparison

## Student

**Name:** Boago Kevin Molefi
**Student ID:** 23018916
**Module:** COMP 441 — Software Analysis & Testing

## AI Assistant Used

**Assistant:** Ollama
**Model:** `gemma4:e2b-it-q4_K_M`

The AI-generated RTM was produced from the same eight requirements used for
the manually reviewed RTM. The original AI output is preserved in:

- `evidence/06_ai_generated_rtm_raw.txt`
- `evidence/07_ai_generated_rtm.md`

The AI output has been preserved as evidence rather than silently rewritten.

---

## 1. Manual RTM

The manually designed RTM contains:

- 8 supplied requirements;
- 16 designed test cases;
- at least one test case for every requirement;
- positive, negative, and boundary cases where applicable;
- system-level test classification; and
- **Not Executed** status.

The manual RTM uses the five columns required for this laboratory:

1. Requirement ID
2. Requirement Description
3. Test Case ID(s)
4. Test Level
5. Status

The manual RTM is:

`lab-4-solutions/rtm.csv`

---

## 2. AI-Generated RTM

The AI-generated RTM contains all eight supplied requirement IDs.

Its test distribution is different from the manual RTM:

| Requirement | Manual RTM | AI RTM | Observation |
|---|---:|---:|---|
| REQ-001 | 2 tests | 3 tests | AI adds an additional registration scenario |
| REQ-002 | 2 tests | 1 test | AI provides less coverage here |
| REQ-003 | 2 tests | 3 tests | AI adds a non-existent-search scenario |
| REQ-004 | 2 tests | 1 test | AI provides less explicit no-results coverage |
| REQ-005 | 2 tests | 3 tests | AI adds an unavailable-book scenario |
| REQ-006 | 2 tests | 2 tests | Same number of tests |
| REQ-007 | 2 tests | 2 tests | Same number of tests |
| REQ-008 | 2 tests | 2 tests | Same number of tests |
| **Total** | **16** | **17** | AI produces one additional test |

Therefore, both approaches cover all eight requirements, but they distribute
their test cases differently.

---

## 3. Concrete Divergences

### 3.1 REQ-001 and REQ-002 overlap

REQ-001 concerns successful registration using a unique email and a password
of at least eight characters.

REQ-002 specifically concerns rejecting an email address that is already in
use.

The AI-generated RTM places a duplicate-email scenario under REQ-001 while
REQ-002 also addresses duplicate-email rejection. This creates an overlap
between the two requirements.

The manual RTM keeps the concerns separate:

- REQ-001 → valid registration and password boundary;
- REQ-002 → duplicate-email rejection.

The manual mapping is therefore easier to audit against the supplied
requirement wording.

### 3.2 REQ-003 and REQ-004 overlap

REQ-003 requires catalogue searching by title, author, or ISBN and specifies
a two-second response requirement.

REQ-004 specifically requires `"No results found"` when a search produces no
matches.

The AI-generated RTM includes a non-existent search scenario under REQ-003,
while REQ-004 also concerns searches producing no results.

The manual RTM separates these concerns:

- REQ-003 → successful catalogue searches and the two-second performance
  requirement;
- REQ-004 → unsuccessful searches and the `"No results found"` behaviour.

This makes the manual traceability relationship more direct.

### 3.3 REQ-005 contains an AI-inferred condition

The AI adds a scenario concerning an unavailable book under REQ-005.

The requirement states that a registered user shall be able to borrow
**available books**, so this is a reasonable test consideration. However, the
requirement does not explicitly state the expected system response when a
book is unavailable.

Consequently, the AI scenario introduces an inferred behaviour that requires
human review before it can be treated as an authoritative requirement-based
test.

### 3.4 Uneven test distribution

The manual design deliberately uses two test cases for each requirement,
giving:

**8 requirements × 2 tests = 16 test cases.**

The AI generates 17 tests and distributes them unevenly across the
requirements.

The AI output also contains a test-case numbering gap: it moves from
`TC-008` to `TC-010`, with no `TC-009` in the AI-generated sequence.

This is not necessarily a functional defect in the AI output, but it is an
additional quality issue that a human reviewer would need to correct before
using the AI matrix as a controlled test artifact.

---

## 4. Strengths of the AI Approach

The AI assistant was useful for rapidly generating candidate traceability
relationships.

It:

- represented all eight supplied requirements;
- generated multiple candidate tests;
- identified positive and negative scenarios;
- considered boundary conditions;
- considered the two-second performance requirement; and
- provided a useful starting point for human review.

This demonstrates the usefulness of AI as a test-design and traceability
assistant.

---

## 5. Weaknesses of the AI Approach

The AI output still required human review because it:

- created overlapping mappings between related requirements;
- introduced an inferred behaviour for unavailable books;
- distributed test cases unevenly;
- contained a test-case numbering gap; and
- required verification against the original requirement wording.

These issues demonstrate why AI-generated test artifacts should not be treated
as automatically authoritative.

---

## 6. Which Version Would Be Trusted for an Audit?

The **manual RTM would be trusted for an audit**.

The reason is not simply that it was created manually. It is because the
manual RTM was reviewed directly against the supplied requirement baseline,
uses explicit and defensible mappings, and does not claim test execution that
did not occur.

The AI-generated RTM would be retained as supporting evidence and as a useful
drafting aid, but its mappings would require human review before being used as
the authoritative audit artifact.

---

## 7. Reflection

The comparison demonstrates that AI can improve the speed of requirements
traceability and test-case generation, but speed does not guarantee
traceability accuracy.

The AI identified all eight requirements and generated useful candidate
tests. However, some of its mappings crossed requirement boundaries or added
behaviour that was not explicitly specified.

The manual review was therefore important for distinguishing what was directly
required from what was merely a reasonable testing assumption.

The main lesson from the comparison is that AI should be treated as a
**candidate-generation tool rather than the source of truth**. A human
reviewer must verify each requirement-to-test relationship against the
original requirements before the RTM is used for an audit.

---

## Evidence

The AI model identification, prompt, raw output, and processed comparison are
preserved in the `evidence/` directory so that the comparison can be
independently reviewed.
