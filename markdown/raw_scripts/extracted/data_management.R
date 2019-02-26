## ---- eval=FALSE---------------------------------------------------------
## pool <- pool::dbPool(drv = RPostgreSQL::PostgreSQL(),
##                      dbname = "database_name",
##                      host = "cpanel.example.org",
##                      user = "smitty",
##                      password = "example")

## ------------------------------------------------------------------------
conn <- pool::poolCheckout(pool)

## ------------------------------------------------------------------------
pool::poolReturn(conn)

## ------------------------------------------------------------------------
new.object <- dbReadTable(conn, "table_name") 

