create or replace procedure category
(
	name varchar
)
language plpgsql
as $$
begin
    insert into categories
        (category_name)
    values
        (name);

    commit;
end;$$

--calling the stored procedure
call category
('soft drinks');