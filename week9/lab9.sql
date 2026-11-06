USE infoman1_canteen;

SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
INNER JOIN orders o ON o.student_id = s.student_id
ORDER BY o.order_id;

SELECT s.student_id, s.student_name, o.order_id
FROM students s
LEFT JOIN orders o ON o.student_id = s.student_id
ORDER BY s.student_id, o.order_id;

SELECT s.student_id, s.student_name
FROM students s
LEFT JOIN orders o ON o.student_id = s.student_id
WHERE o.order_id IS NULL;

SELECT s.student_name, s.program, o.order_id, m.item_name,
       oi.quantity, m.price, oi.quantity * m.price AS line_total
FROM students s
INNER JOIN orders o       ON o.student_id = s.student_id
INNER JOIN order_items oi ON oi.order_id  = o.order_id
INNER JOIN menu_items m   ON m.menu_id    = oi.menu_id
ORDER BY o.order_id, m.item_name;

SELECT s.student_name AS buyer, m.item_name AS item,
       oi.quantity * m.price AS line_total
FROM students s
INNER JOIN orders o       ON o.student_id = s.student_id
INNER JOIN order_items oi ON oi.order_id  = o.order_id
INNER JOIN menu_items m   ON m.menu_id    = oi.menu_id
WHERE o.order_date >= '2026-08-01'
ORDER BY o.order_date DESC, o.order_id DESC, m.item_name;

SELECT s.student_name AS buyer, m.item_name AS item,
       oi.quantity * m.price AS line_total
FROM students s
LEFT JOIN orders o        ON o.student_id = s.student_id
LEFT JOIN order_items oi  ON oi.order_id  = o.order_id
LEFT JOIN menu_items m    ON m.menu_id    = oi.menu_id
WHERE o.order_date >= '2026-08-01'
ORDER BY o.order_date DESC, o.order_id DESC, m.item_name;

SELECT s.student_name AS buyer, m.item_name AS item,
       oi.quantity * m.price AS line_total
FROM students s
LEFT JOIN orders o        ON o.student_id = s.student_id
                         AND o.order_date >= '2026-08-01'
LEFT JOIN order_items oi  ON oi.order_id  = o.order_id
LEFT JOIN menu_items m    ON m.menu_id    = oi.menu_id
ORDER BY o.order_date DESC, o.order_id DESC, m.item_name;