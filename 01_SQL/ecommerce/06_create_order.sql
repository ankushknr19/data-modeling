create or replace procedure create_order
(
	cid int
)
language plpgsql
as $$
declare oid int;
declare row RECORD;

begin
    insert into orders
        (customer_id,total_amount)
    values
        (
            (select customer_id
            from carts
            where cart_id = cid),
            (SELECT SUM(p.price * c.qty)
            FROM cart_items c left join products p on c.product_id = p.product_id
            WHERE c.cart_id = cid)
)
    returning order_id into oid;

for row in
select c.product_id as pid,
    c.qty as q,
    p.price as pri
from cart_items c
    left join products p
    on c.product_id = p.product_id
where cart_id = cid
order by 1
	loop 
		insert into order_details
(order_id, product_id,quantity,price)
		values
(oid, row.pid, row.q, row.pri);

end loop;

delete from cart_items where cart_id = cid;
commit;
end;$$