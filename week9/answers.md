# Week 9 - Lab 9: Multi-Table Join Practical Test

Course: INFOMAN1 | Database: infoman1_canteen

## Task 1 - INNER JOIN Basics

Query: INNER JOIN between `students` and `orders` on `student_id`, ordered by `order_id`.

Result (3 rows):

| student_name | program | order_id | order_date |
|---|---|---|---|
| Ana Cruz | BSIT | 101 | 2026-08-10 |
| Ana Cruz | BSIT | 102 | 2026-08-15 |
| Dan Reyes | BSIT | 103 | 2026-08-16 |

Only Ana and Dan appear because they are the only students with matching rows in `orders`.

## Task 2 - Finding Missing Relationships

**(a) LEFT JOIN, all students** (5 rows):

| student_id | student_name | order_id |
|---|---|---|
| 1 | Ana Cruz | 101 |
| 1 | Ana Cruz | 102 |
| 2 | Ben Lim | NULL |
| 3 | Cara Yu | NULL |
| 4 | Dan Reyes | 103 |

**(b) Same join with `WHERE o.order_id IS NULL`** (2 rows):

| student_id | student_name |
|---|---|
| 2 | Ben Lim |
| 3 | Cara Yu |

Ben and Cara appear because they have no matching row in `orders`, so the LEFT JOIN fills `o.order_id` with NULL for them and `IS NULL` keeps only those rows.

## Task 3 - Four-Table Canteen Report

Query: `students` to `orders` to `order_items` to `menu_items`, with three ON conditions (`o.student_id = s.student_id`, `oi.order_id = o.order_id`, `m.menu_id = oi.menu_id`), ordered by `order_id, item_name`.

Result (4 rows):

| student_name | program | order_id | item_name | quantity | price | line_total |
|---|---|---|---|---|---|---|
| Ana Cruz | BSIT | 101 | Iced Tea | 1 | 30.00 | 30.00 |
| Ana Cruz | BSIT | 101 | Siomai Rice | 2 | 65.00 | 130.00 |
| Ana Cruz | BSIT | 102 | Burger Steak | 1 | 89.00 | 89.00 |
| Dan Reyes | BSIT | 103 | Siomai Rice | 1 | 65.00 | 65.00 |

## Task 4 - Aliases, Filters, and the Silent Inner Join

**Version A (INNER JOINs with `WHERE o.order_date >= '2026-08-01'`)**, 4 rows, newest first:

| buyer | item | line_total |
|---|---|---|
| Dan Reyes | Siomai Rice | 65.00 |
| Ana Cruz | Burger Steak | 89.00 |
| Ana Cruz | Iced Tea | 30.00 |
| Ana Cruz | Siomai Rice | 130.00 |

**Version B (LEFT JOIN from `students` with the same `WHERE`)**, 4 rows: identical to Version A. Ben Lim and Cara Yu do not appear.

**Row count comparison:** Version A returns 4 rows and Version B returns 4 rows. Without the date filter, the LEFT JOIN would return 6 rows (the 4 order lines plus Ben and Cara with NULL order, item and line_total).

**Why Version B drops students without orders:** The `WHERE` clause runs after the join. For Ben and Cara, `o.order_date` is NULL, and `NULL >= '2026-08-01'` evaluates to unknown, not true, so those rows are removed. The LEFT JOIN therefore behaves like an INNER JOIN.

**Fix:** Move the date rule into the `ON` clause of the join to `orders` (`ON o.student_id = s.student_id AND o.order_date >= '2026-08-01'`). The date then limits which orders match instead of removing students. This returns 6 rows, with Ben and Cara kept and shown with NULL item and line_total. Alternatively, keep the condition in `WHERE` and handle NULL: `WHERE o.order_date >= '2026-08-01' OR o.order_date IS NULL`.

## Task 5 - Reflection (150-200 words)



1. *When you would use INNER JOIN and when you would use LEFT JOIN for a campus report, with one example from Tasks 1 to 4.*
2. *One mistake you actually made or observed (missing ON, joining names instead of keys, ambiguous column, or WHERE breaking a LEFT JOIN).*
3. *Its symptom and how you fixed it.*

