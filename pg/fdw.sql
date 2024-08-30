-- -- Step 1: Create the role
-- CREATE ROLE local_user WITH LOGIN PASSWORD 'your_password';
--
-- -- Step 2: Grant privileges
-- GRANT ALL PRIVILEGES ON DATABASE your_database TO local_user;

-- Step 3: Install the FDW extension
-- CREATE EXTENSION postgres_fdw;

-- Step 4: Create the foreign server
CREATE SERVER tenant_foreign_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'url', dbname 'tenant', port '25060');

-- Step 5.0: Create admin user mapping
CREATE USER MAPPING FOR doadmin
    SERVER tenant_foreign_server
    OPTIONS (user 'tenant', password '');

-- Step 5: Create usage user mapping
CREATE USER MAPPING FOR payment
    SERVER tenant_foreign_server
    OPTIONS (user 'tenant', password '');

-- -- Step 6: Create the foreign table
-- CREATE FOREIGN TABLE my_foreign_table (
--     id integer,
--     name text
--     ) SERVER tenant_foreign_server
--     OPTIONS (table_name 'public.remote_table');
--
-- -- Step 7: Query the foreign table
-- SELECT * FROM my_foreign_table;

-- Step 8: Import the foreign schemaa
IMPORT FOREIGN SCHEMA public
    LIMIT TO (tenant) -- [remote_table_name]
    FROM SERVER tenant_foreign_server
    INTO public; -- [my_schema]

-- Step 8.1: Grant usage on the foreign server
GRANT USAGE ON FOREIGN SERVER tenant_foreign_server TO payment;

-- Step 8.2: Grant select privilege on the foreign table
GRANT SELECT ON public.tenant -- [remote_table_name]
    TO payment;
