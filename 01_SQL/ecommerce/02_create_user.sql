--create vendor_staff
--rollback;
begin;

    insert into 
users
        (email, password, user_role)
    values
        ('ankit@gmail.com', 'ankit123', 'vendor_staff');

    insert into 
vendor_staffs
        (staff_username, user_id)
    values
        ( 'ankit',
            (select user_id
            from users
            where email='ankit@gmail.com') );

    commit;

    --create customer
    --rollback;
    begin;

        insert into 
users
            (email, password, user_role)
        values
            ('mohan@gmail.com', 'mohan123', 'customer');

        insert into 
customers
            (first_name, last_name, contact, address, user_id)
        values
            ( 'Mohan', 'Adhikari', '9851235438', 'New Baneshwor',
                (select user_id
                from users
                where email='mohan@gmail.com') );

        commit;