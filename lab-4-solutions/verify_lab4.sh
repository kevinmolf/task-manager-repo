#!/usr/bin/env bash

# Do NOT use "set -e".
# A failed verification check must not terminate the user's shell.

PASS_COUNT=0
FAIL_COUNT=0

pass() {
    echo "PASS: $1"
    PASS_COUNT=$((PASS_COUNT + 1))
}

fail() {
    echo "FAIL: $1"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

echo "================================================"
echo "COMP 441 — LAB 4 VERIFICATION"
echo "================================================"

echo ""
echo "Repository:"
pwd

echo ""
echo "------------------------------------------------"
echo "A. REQUIRED LAB 4 FILES"
echo "------------------------------------------------"

required_files=(
    "lab-4-solutions/README.md"
    "lab-4-solutions/requirements.md"
    "lab-4-solutions/rtm.csv"
    "lab-4-solutions/test-design.md"
    "lab-4-solutions/test-plan.md"
    "lab-4-solutions/defect-log.csv"
    "lab-4-solutions/defect-lifecycle.md"
    "lab-4-solutions/ai-comparison.md"
    "lab-4-solutions/coverage-summary.md"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        pass "$file exists"
    else
        fail "$file is missing"
    fi
done


echo ""
echo "------------------------------------------------"
echo "B. REQUIREMENTS BASELINE"
echo "------------------------------------------------"

REQ_COUNT=$(grep -oE 'REQ-[0-9]{3}' lab-4-solutions/requirements.md 2>/dev/null \
    | sort -u | wc -l)

echo "Unique requirements found: $REQ_COUNT"

if [ "$REQ_COUNT" -eq 8 ]; then
    pass "Exactly 8 requirements identified"
else
    fail "Expected 8 requirements, found $REQ_COUNT"
fi


echo ""
echo "------------------------------------------------"
echo "C. TEST DESIGN"
echo "------------------------------------------------"

TC_COUNT=$(grep -oE 'TC-[0-9]{3}' lab-4-solutions/test-design.md 2>/dev/null \
    | sort -u | wc -l)

echo "Unique test cases found: $TC_COUNT"

if [ "$TC_COUNT" -eq 16 ]; then
    pass "Exactly 16 test cases identified"
else
    fail "Expected 16 test cases, found $TC_COUNT"
fi


echo ""
echo "------------------------------------------------"
echo "D. RTM STRUCTURAL VERIFICATION"
echo "------------------------------------------------"

python3 <<'PY'
import csv
import sys
from pathlib import Path

path = Path("lab-4-solutions/rtm.csv")

try:
    with path.open(newline="", encoding="utf-8-sig") as f:
        rows = list(csv.DictReader(f))

    expected_fields = {
        "Requirement ID",
        "Requirement Description",
        "Test Case ID(s)",
        "Test Level",
        "Status",
    }

    actual_fields = set(rows[0].keys()) if rows else set()

    print(f"RTM data rows: {len(rows)}")
    print(f"RTM columns: {list(rows[0].keys()) if rows else []}")

    if actual_fields == expected_fields:
        print("PASS: RTM columns are correct.")
    else:
        print("FAIL: RTM columns do not match expected structure.")

    req_ids = {row["Requirement ID"].strip() for row in rows}

    print(f"RTM unique requirements: {len(req_ids)}")

    if req_ids == {f"REQ-{i:03d}" for i in range(1, 9)}:
        print("PASS: RTM contains REQ-001 through REQ-008.")
    else:
        print(f"FAIL: RTM requirement IDs are: {sorted(req_ids)}")

    test_cases = set()

    for row in rows:
        for tc in row["Test Case ID(s)"].split(";"):
            tc = tc.strip()
            if tc:
                test_cases.add(tc)

    print(f"RTM unique test cases: {len(test_cases)}")

    if len(test_cases) == 16:
        print("PASS: RTM maps 16 unique test cases.")
    else:
        print(f"FAIL: Expected 16 unique test cases, found {len(test_cases)}.")

    statuses = {row["Status"].strip() for row in rows}

    print(f"RTM statuses: {sorted(statuses)}")

    if statuses == {"Not Executed"}:
        print("PASS: All RTM statuses are 'Not Executed'.")
    else:
        print("FAIL: Unexpected RTM status values.")

    missing = [
        row["Requirement ID"]
        for row in rows
        if not row["Test Case ID(s)"].strip()
    ]

    if not missing:
        print("PASS: Every requirement has a test-case mapping.")
    else:
        print(f"FAIL: Requirements without test mappings: {missing}")

except Exception as exc:
    print(f"FAIL: Could not parse RTM: {exc}")
PY


echo ""
echo "------------------------------------------------"
echo "E. DEFECT LOG VERIFICATION"
echo "------------------------------------------------"

python3 <<'PY'
import csv
from pathlib import Path

path = Path("lab-4-solutions/defect-log.csv")

try:
    with path.open(newline="", encoding="utf-8-sig") as f:
        rows = list(csv.DictReader(f))

    print(f"Defect rows: {len(rows)}")

    if len(rows) == 2:
        print("PASS: Exactly 2 defects recorded.")
    else:
        print("FAIL: Expected exactly 2 defects.")

    ids = {row["Defect ID"].strip() for row in rows}

    if ids == {"DEF-001", "DEF-002"}:
        print("PASS: DEF-001 and DEF-002 present.")
    else:
        print(f"FAIL: Defect IDs found: {sorted(ids)}")

    for row in rows:
        if row["Severity"].strip() == "High":
            print(f"PASS: {row['Defect ID']} severity = High")
        else:
            print(f"FAIL: {row['Defect ID']} severity is not High")

        if row["Priority"].strip() == "High":
            print(f"PASS: {row['Defect ID']} priority = High")
        else:
            print(f"FAIL: {row['Defect ID']} priority is not High")

        if row["Status"].strip() == "Closed":
            print(f"PASS: {row['Defect ID']} status = Closed")
        else:
            print(f"FAIL: {row['Defect ID']} is not Closed")

except Exception as exc:
    print(f"FAIL: Could not parse defect log: {exc}")
PY


echo ""
echo "------------------------------------------------"
echo "F. DEFECT LIFECYCLE VERIFICATION"
echo "------------------------------------------------"

if grep -q "New → Triaged → Assigned → Fixed → Verified → Closed" \
    lab-4-solutions/defect-lifecycle.md; then
    pass "Complete defect lifecycle documented"
else
    fail "Required defect lifecycle not found"
fi

if grep -q "DEF-001" lab-4-solutions/defect-lifecycle.md &&
   grep -q "DEF-002" lab-4-solutions/defect-lifecycle.md; then
    pass "Both defects have lifecycle documentation"
else
    fail "One or more defects missing lifecycle documentation"
fi


echo ""
echo "------------------------------------------------"
echo "G. ALL CSV FILES IN REPOSITORY"
echo "------------------------------------------------"

python3 <<'PY'
import csv
from pathlib import Path

csv_files = sorted(Path(".").rglob("*.csv"))

# Ignore virtual environments because those are third-party package files.
csv_files = [
    p for p in csv_files
    if ".venv" not in p.parts
]

print(f"CSV files found: {len(csv_files)}")

bad = []

for path in csv_files:
    try:
        with path.open(newline="", encoding="utf-8-sig") as f:
            rows = list(csv.reader(f))

        if not rows:
            bad.append((path, "empty CSV"))
            continue

        header_width = len(rows[0])

        inconsistent = [
            i + 1
            for i, row in enumerate(rows[1:], start=1)
            if len(row) != header_width
        ]

        if inconsistent:
            bad.append(
                (
                    path,
                    f"inconsistent column count; bad rows: {inconsistent}"
                )
            )
        else:
            print(
                f"PASS: {path} "
                f"({len(rows)-1} data rows, {header_width} columns)"
            )

    except Exception as exc:
        bad.append((path, str(exc)))

if bad:
    print("")
    print("CSV FAILURES:")
    for path, reason in bad:
        print(f"FAIL: {path} — {reason}")
else:
    print("")
    print("PASS: Every repository CSV parsed successfully.")
PY


echo ""
echo "------------------------------------------------"
echo "H. COVERAGE / COMPLETION CLAIMS"
echo "------------------------------------------------"

if grep -q "Requirements: 8" lab-4-solutions/coverage-summary.md &&
   grep -q "Requirements covered: 8" lab-4-solutions/coverage-summary.md &&
   grep -q "Coverage: 100%" lab-4-solutions/coverage-summary.md; then
    pass "Coverage summary reports 8/8 requirements and 100%"
else
    fail "Coverage summary does not contain expected results"
fi

if grep -qE "Orphan test cases:[[:space:]]*0" lab-4-solutions/coverage-summary.md &&
   grep -qE "Requirements without tests:[[:space:]]*0" lab-4-solutions/coverage-summary.md; then
    pass "Coverage summary reports no orphan tests or uncovered requirements"
else
    fail "Coverage gap information is incomplete"
fi


echo ""
echo "------------------------------------------------"
echo "I. AI TOOL IDENTIFICATION"
echo "------------------------------------------------"

if grep -q "Ollama" lab-4-solutions/ai-comparison.md &&
   grep -q "gemma4:e2b-it-q4_K_M" lab-4-solutions/ai-comparison.md; then
    pass "AI assistant and model are explicitly identified"
else
    fail "AI assistant/model identification is incomplete"
fi

if grep -q "Boago Kevin Molefi" lab-4-solutions/ai-comparison.md &&
   grep -q "23018916" lab-4-solutions/ai-comparison.md; then
    pass "Student name and ID are present"
else
    fail "Student identification is incomplete"
fi


echo ""
echo "================================================"
echo "FINAL LAB 4 RESULT"
echo "================================================"

echo "Verification checks passed: $PASS_COUNT"
echo "Verification checks failed: $FAIL_COUNT"

if [ "$FAIL_COUNT" -eq 0 ]; then
    echo ""
    echo "==============================================="
    echo "LAB 4 STATUS: PASS"
    echo "==============================================="
    echo "Lab 4 is structurally complete and ready for"
    echo "final report/submission packaging."
else
    echo ""
    echo "==============================================="
    echo "LAB 4 STATUS: REVIEW REQUIRED"
    echo "==============================================="
    echo "Some verification checks failed."
fi

echo ""
echo "================================================"
echo "END OF LAB 4 VERIFICATION"
echo "================================================"

# Always return success so this script never kills the
# surrounding terminal process.
exit 0
