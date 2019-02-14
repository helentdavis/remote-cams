## This makes tables


install.packages(c("dplyr", "rlist"))
packagelist <- c("dplyr", "rlist")  
lapply(packagelist, require, character.only = TRUE)

table_cols <- function ()
{
  n <- readline(prompt = "Enter number of columns of data per page ")
  return(n)
}
row_first_pg <- function ()
{
  n <- readline(prompt = "Enter number of rows that will fit on first page ")
  return(n)
}
row_rest_pg <- function ()
{
  n <- readline(prompt = "Enter number of rows on the rest of the pages ")
  return(n)
}
total_rows <- function ()
{
  n <- readline(prompt = "Enter total number of rows ")
  return(n)
}
total_cols <- function ()
{
  n <- readline(prompt = "enter total number of columns ")
  return(n)
}

table_cols <- as.numeric(print(table_cols()))
row_first_pg <- as.numeric(print(row_first_pg()))
row_rest_pg <- as.numeric(print(row_rest_pg()))
total_rows <- as.numeric(print(total_rows()))
total_cols <- as.numeric(print(total_cols()))

dat <- read_excel("P:/goea/Reports/Summary Report/Appendices/HAFB/remote cam data 2015.xlsx")

## first page table
result <- list()

for(i in 0:(nrow(dat))){
  result[[i+1]] <- dat[((i*row_first_pg)+1):((i*row_first_pg)+row_first_pg),]
}


bind <- list.cbind(result)

rows <- list()

for(i in 0:(nrow(bind))){
  rows[[i+1]] <- bind[,((i*(total_cols*table_cols))+1):((i*(total_cols*table_cols))+(total_cols*table_cols))]
}

rowbind <- list.rbind(rows)

firstpage <- rowbind[1:row_first_pg,]


## For other pages

dat2 <- dat[((row_first_pg*table_cols)+1):total_rows,]

restresult <- list()

for(i in 0:(nrow(dat2))){
  restresult[[i+1]] <- dat2[((i*row_rest_pg)+1):((i*row_rest_pg)+row_rest_pg),]
}


restbind <- list.cbind(restresult)

restrows <- list()

for(i in 0:(nrow(restbind))){
  restrows[[i+1]] <- restbind[,((i*(total_cols*table_cols))+1):((i*(total_cols*table_cols))+(total_cols*table_cols))]
}

restrowbind <- list.rbind(restrows)

final <- rbind(firstpage,restrowbind)
