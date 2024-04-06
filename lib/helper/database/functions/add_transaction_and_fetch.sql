CREATE OR REPLACE FUNCTION add_transaction(
    p_customer_id INT,
    p_supplier_id INT,
    p_bill_number VARCHAR,
    p_order_date DATE,
    p_bill_amount DECIMAL,
    p_discount_amount DECIMAL,
    p_tax_amount DECIMAL,
    p_payment_status payment_status,
    p_product_qty INT
)
RETURNS TABLE (
    transaction_id INT,
    customer_id INT,
    supplier_id INT,
    order_date DATE,
    bill_amount DECIMAL,
    discount_amount DECIMAL,
    tax_amount DECIMAL,
    payment_status payment_status,
    bill_number VARCHAR,
    product_qty INT
)
AS $$
DECLARE
    inserted_row transactions%ROWTYPE;
BEGIN
    INSERT INTO transactions (customer_id, supplier_id, bill_number, order_date, bill_amount, discount_amount, tax_amount, payment_status, product_qty)
    VALUES (p_customer_id, p_supplier_id, p_bill_number, p_order_date, p_bill_amount, p_discount_amount, p_tax_amount, p_payment_status, p_product_qty)
    RETURNING * INTO inserted_row;

    RETURN QUERY SELECT * FROM transactions WHERE transactions.transaction_id = inserted_row.transaction_id;
END;
$$ LANGUAGE plpgsql;
