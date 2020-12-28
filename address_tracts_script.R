# Posting data on stackoverflow  by CradleToGraveR
# https://www.youtube.com/watch?v=Rn6BgT15yIs&t=297s 

setwd("D:/D_Documents/GitHub-DasRotRad/ogl_params_example/")

library(tidyverse)

library(readxl)
adr <- read_excel("addresses10.xlsx") %>% 
  rename(Zip="PostalCode") %>% 
  filter(LessorID < 4)
View(adr)


# CREATE A SUBSET OF DATA
# adr_sub <-dput(adr[1:3,])  

# CREATE STRUCTURE AND DATA  
# USE ***CTL-SHIFT-A*** to clean up the structure  

adr <- structure(
    list(
      LessorID = c(1, 2, 3),
      FullName = c("David Edwards",
                   "Roland Hildebrandt", "Jerry Pica"),
      OwnerLNFN = c("Edwards, David",
                    "Hildebrandt, Roland", "Pica, Jerry"),
      LastName = c("Edwards",
                   "Hildebrandt", "Pica"),
      FirstName = c("David", "Roland", "Jerry"),
      Address = c("548 Hillview Drive", "2402 Lake Forest Drive",
                  "1969 Locust Court"),
      City = c("Chattanooga", "West Nyack", "Long Beach"),
      STATE = c("TN", "NY", "CA"),
      Zip = c("37421", "10994", "90808"),
      LessorSSN = c("256-15-7004", "060-09-8470", "607-98-7064"),
      HomePhone = c("706-891-8501", "914-261-0685", "562-405-1263")
    ),
    row.names = c(NA,-3L),
    class = c("tbl_df", "tbl", "data.frame")
  )


# mydata <- dput(head(adr))

# reports <- tibble(
#   LessorID = unique(lessors$LessorID),
#                               filename = stringr::str_c("Lessor-", LessorID, ".html"),
#                               params=purrr::map(LessorID, ~list(LessorID=.)))


reports <- tibble(
  LessorID = unique(adr$LessorID),
  filename = stringr::str_c("Owner-", LessorID, ".html"),
 params=purrr::map(LessorID, ~list(MyID = .))) 



#  Do I need to list all params?  This isn't working for me.
#  params = list(MyID=., Address= ., City=.))


reports %>% 
  select(output_file = filename, params) %>% 
  purrr::pwalk(
    rmarkdown::render, 
    input="./address10_tracts.Rmd")

