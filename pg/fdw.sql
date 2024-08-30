-- Install the FDW extension
CREATE EXTENSION postgres_fdw;

-- Create a foreign server for the other database
CREATE SERVER foreign_log_db
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'pg-dev-do-user-14070403-0.b.db.ondigitalocean.com', dbname 'log', port '25060');