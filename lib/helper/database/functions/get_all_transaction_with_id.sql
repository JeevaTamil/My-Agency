CREATE OR REPLACE FUNCTION get_transaction_info(t_id int)
RETURNS TABLE (
    transaction_id INT,
    customer_id INT,
    supplier_id INT,
    order_date DATE,
    bill_amount DECIMAL,
    discount_amount DECIMAL,
    tax_amount DECIMAL,
    payment_status payment_status,
    bill_number varchar,
    product_qty int,
    customer_name varchar,
    customer_city varchar,
    supplier_name varchar,
    supplier_city varchar,
    logistic_id INT,
    transport_name varchar,
    lr_number varchar,
    lr_date DATE,
    number_of_bundles INT
)
AS $$
BEGIN
    RETURN QUERY
    SELECT t.*, c.name AS customer_name, c.city as customer_city, s.name AS supplier_name, s.city as supplier_city, l.logistic_id, l.transport_name, l.lr_number, l.lr_date, l.number_of_bundles
FROM transactions t
INNER JOIN customers c ON t.customer_id = c.customer_id
INNER JOIN suppliers s ON t.supplier_id = s.supplier_id
INNER JOIN logistics l ON l.transaction_id = t.transaction_id
where t.transaction_id = t_id;
END;
$$ LANGUAGE plpgsql;
