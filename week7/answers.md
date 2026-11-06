# Lab 7: Performance Task Using SQL 3 (Functions, Aliases & Filtering)
 

---

## Database Import & Setup Verification

Before attempting the tasks, the `university_db.sql` file was imported into MySQL CLI using the following steps:

```bash
cd Documents/infoman1/week7
mysql -u root -p < university_db.sql
```

### Verification SQL

```sql
SHOW DATABASES;
USE university_db;
SHOW TABLES;
SELECT COUNT(*) FROM students;
SELECT COUNT(*) FROM instructors;
SELECT COUNT(*) FROM assignments;
SELECT COUNT(*) FROM courses;
```

**Row Count Results:**
- `students`: 10 rows
- `instructors`: 6 rows
- `assignments`: 6 rows
- `courses`: 8 rows

---

## Task 1: Complex Student Roster

### Objective
Filter specific groups of students using logical operators (`IN`, `LIKE`, `NOT`).

### SQL Query

```sql
SELECT 
    first_name, 
    last_name, 
    major
FROM 
    students
WHERE 
    major IN ('Computer Science', 'Information Technology')
    AND last_name LIKE 'S%'
    AND NOT (section = 'Online');
```

### Criteria Met:
1. `major IN ('Computer Science', 'Information Technology')`: Filters students within either target major.
2. `last_name LIKE 'S%'`: Filters students whose last names start with the letter 'S'.
3. `NOT (section = 'Online')`: Excludes students enrolled in the 'Online' section.

### Evidence
- **Screenshot Location:** `week7/screenshots/task1_complex_student_roster.png`

---

## Task 2: Formatting Employee Data

### Objective
Concatenate text fields, extract initial letters, round numbers, and apply column aliases.

### SQL Query

```sql
SELECT 
    CONCAT(
        LEFT(first_name, 1), 
        '. ', 
        last_name, 
        ' ($', 
        ROUND(salary, 0), 
        ')'
    ) AS `Instructor Details`
FROM 
    instructors
LIMIT 5;
```

### Alternative SQL Query (Using SUBSTRING)

```sql
SELECT 
    CONCAT(
        SUBSTRING(first_name, 1, 1), 
        '. ', 
        last_name, 
        ' ($', 
        ROUND(salary, 0), 
        ')'
    ) AS `Instructor Details`
FROM 
    instructors
LIMIT 5;
```

### Expected Output (First 5 Rows)

| Instructor Details |
| :--- |
| J. Smith ($55000) |
| A. Johnson ($62000) |
| M. Davis ($58000) |
| R. Wilson ($71000) |
| E. Taylor ($49000) |

### Evidence
- **Screenshot/Text Output Location:** `week7/screenshots/task2_instructor_details.png`

---

## Task 3: Project Deadline Analysis

### Objective
Perform date calculations using built-in date functions (`DATEDIFF`), apply column aliases, filter calculated values, and sort the output.

### SQL Query

```sql
SELECT 
    assignment_name,
    assigned_date,
    due_date,
    DATEDIFF(due_date, assigned_date) AS Days_To_Complete
FROM 
    assignments
WHERE 
    DATEDIFF(due_date, assigned_date) > 14
ORDER BY 
    Days_To_Complete DESC;
```

### Notes on Execution:
- `DATEDIFF(due_date, assigned_date)` calculates the number of days between assignment start and due date.
- Standard SQL evaluates `WHERE` clauses before column aliasing takes effect; thus `DATEDIFF(...) > 14` is evaluated directly in the `WHERE` clause.
- `ORDER BY Days_To_Complete DESC` sorts the results from the longest completion timeframe to the shortest.

### Evidence
- **Screenshot Location:** `week7/screenshots/task3_deadline_analysis.png`

---

## Task 4: Comprehensive Data Audit

### Objective
Audit the `courses` table using `IS NULL`, `BETWEEN`, `LIKE`, explicit operator precedence (`AND` / `OR`), and alphabetical sorting.

### SQL Query

```sql
SELECT 
    course_code, 
    course_name, 
    credits
FROM 
    courses
WHERE 
    (course_description IS NULL OR credits BETWEEN 4 AND 6)
    AND course_code LIKE '%ADV%'
ORDER BY 
    course_name ASC;
```

### Explanation of Logical Operator Precedence

In SQL, the `AND` operator has a higher precedence than the `OR` operator. Without explicit grouping parentheses, a clause structured as `A OR B AND C` is evaluated as `A OR (B AND C)`. 

In this audit query:
1. We must isolate the conditions `course_description IS NULL` and `credits BETWEEN 4 AND 6` using parentheses: `(course_description IS NULL OR credits BETWEEN 4 AND 6)`.
2. This ensures the engine checks if a course meets **either** of the condition criteria (missing description OR 4–6 credits) **BEFORE** combining that result with the mandatory requirement `AND course_code LIKE '%ADV%'`.
3. Consequently, every returned record is guaranteed to contain `'ADV'` in its course code, while satisfying at least one of the two audit triggers.
4. `ORDER BY course_name ASC` organizes the resulting records alphabetically.

### Evidence
- **Screenshot Location:** `week7/screenshots/task4_data_audit.png`

---

## Repository Structure & Guidelines

To ensure full compliance with the submission requirements, structure your GitHub repository as follows:

```text
infoman1/
└── week7/
    ├── answers.md
    ├── university_db.sql
    └── screenshots/
        ├── task1_complex_student_roster.png
        ├── task2_instructor_details.png
        ├── task3_deadline_analysis.png
        └── task4_data_audit.png
```

### Recommended Git Commands for Submission

```bash
git add week7/answers.md week7/screenshots/
git commit -m "Task 1-4: Complete Lab 7 SQL queries, formatted answers.md and screenshots"
git push origin main
```