--create cart
begin;

    --if cart does not exist for the customer, run this query once
    insert into carts
        (customer_id)
    values
        (3);

    --add to cart_items
    insert into  cart_items
        (cart_id, product_id, qty)
    values(
            (select cart_id
            from carts
            where customer_id=3),
            6,
            2
);

    update products
set count_in_stock = count_in_stock - 2
where product_id = 6
    ;
    commit;



    --show cart
    select first_name, product_name, price, qty
    from customers
        join carts on customers.customer_id = carts.customer_id
        join cart_items on carts.cart_id = cart_items.cart_id
        join products on cart_items.product_id = products.product_id
    where customers.customer_id = 1;