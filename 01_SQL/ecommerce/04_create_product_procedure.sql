create or replace procedure create_product
(
	category__id int,
	product__name varchar,
	product__price numeric,
	product__stock int,
	product__unit unit

)
language plpgsql
as $$
begin
    insert into products
        (category_id, product_name, price, count_in_stock, unit)
    values
        (category__id,
            product__name,
            product__price,
            product__stock,
            product__unit);

    commit;
end;$$

--calling stored procedure
call create_product
(1,'coca cola',65,24,'pcs');