setwd("E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data")
file.exists("Data Science Specialization")
dir.create("Data") # directory means folder

if(!file.exists("Data2"))
{
  dir.create("Data2")
}


#install.packages("downloader")

#download the file through the internet ..
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

#require(downloader)
#read.csv(fileURL)

#download(fileURL, "E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data", mode = "wb")


download.file(fileURL, destfile = "E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data/cameras.csv")

#list.files("E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data")

dataDownloaded <- data()
dateDownloaded <- date()
dateDownloaded


### Reading flat files .. i.e. txt file
read.csv("cameras.csv")

# you can check also, read.table(fileName) .. it reads the data into RAM .. bit ineffecient
cameraData <- read.table("E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data/cameras.csv", sep = ",", header = TRUE)
head(cameraData) 


## Working on Excel sheets ..

downloadURL <-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD&bom=true"
downloadURL
download.file(downloadURL, destfile ="E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data/cameras.xlsx")
dateDownload <- date()

install.packages(c("XLConnect"))
library("XLConnect")


### Read XML
install.packages(c("XML"))
library("XML")
fileURL <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileURL, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode) # this is the root 

#Names ..
names(rootNode)

#accessing certain block in the file ..
rootNode[[1]][[2]]

#more handsome look .. ;)
xmlApply(rootNode, xmlValue)

xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

## Read JSON file .. 
install.packages(c("jsonlite"))
library(jsonlite)
jsonData <- fromJSON("http://api.github.com/users/jtleek/repos")
jsonData
# extract the nodes 
names(jsonData)
# read spesific var ..
names(jsonData$owner)
jsonData$owner$login

## access iris dataset ..
myjson <- toJSON(iris,pretty = TRUE) # convert json to R
myjson

cat(myjson) # to print 
 
iris2 <- fromJSON(myjson) # table format
head(iris2)

## data tables ..
install.packages(c("data.table"))
library(data.table)
DF = data.frame(x=rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DF,3)

DT = data.table(x=rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DF,3)

tables() #return ALL tables stored in memory
DT[2,]
DT[DT$y == "a",] #select all rows in Y that contain "a"

DT[,c(2,3)] #subsetting datatables 

#expressions ..uniexpression
{
  x = 1
  y = 2
}
k = {print(10);5} # print 10 
print(k) # print 5 as a value of k

#calc values for vars with expressions ..
DT[,list(mean(x), sum(z))]
DT[,table(y)] #summarize Y in a table format

#adding new columns ..
DT[,w:=z^2]
DT

DT3 <- copy(DT)
DT3

#adding new column in the middle .. 
DT2 <- DT #online update 
DT[, y:= 2]
DT
DT2

#multiple operations .. 
#m = log2(x+z+5)
DT[,m:={tmp <- (x+z); log2(tmp+5)}]

DT[,a:=x>0] #boolean variable
DT

DT[, b:= mean(x+w), by = a]
#take the mean of x + w when a is true and one more time when it is false ..
#as if it is grouped by a
DT

DT[, b:= mean(x+w)]
#take the mean of x + w when a is true .. as if it is grouped by a
DT

# special variables ..
# .N ==> integer of length 1 theat carry summary i.e. count of large num ..
set.seed(123)
DT<- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x] #count the values of x grouped by x values 

## keys and join .. 

DT = data.table(x = rep(c("a", "b", "c"), each = 3), y = rnorm(9))
DT
setkey(DT,x)
DT['a']

## joins .. 
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT1
DT2 <- data.table(x=c('a', 'a', 'dt2'), z = 5:7)
DT2
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)

## end .. 

## install swirl ..
install.packages(c("swirl"))
packageVersion("swirl")
library(swirl)

## read file ..

dat <- read.csv("E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/quiz/getdata%2Fdata%2FDATA.gov_NGAP.csv", sep = ",")[18:23, 7:15]
dat
sum(dat$Zip*dat$Ext,na.rm=T) # result is Zero


## Read xml 
install.packages(c("XML"))
library("XML")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(sub("s", "", fileURL), useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode) # this is the root 

names(rootNode)

xmlApply(rootNode, xmlValue)
len <- xpathApply(xmlRoot(doc),path="count(//zipcode)",xmlValue)

## excel manipulations ..


install.packages("data.table")        # install it
library(data.table)                   # load it
example(data.table)                   # run some examples
?data.table                           # read
?fread                                # read
update.packages()                     # keep up to date


install.packages(c("fread"))
train <- fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")

#DT = data.table(x=rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(train,3)
DT <- train
DT[,mean(pwgtp15),by=SEX]

## Week # 2 ..
#Reading data from SQL file 
## Note: table is a data frame in R .. fields corresponding to column
# field c tab

setwd("E:/FCI/Research Work/Self Studying/RStudio/bin")

install.packages(c("RMySQL"))
library("RMySQL")
ucscDb <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); ##dbDisconnect(ucscDb);
head(result)

## we gonna focus on signle DB .. hg19
# open connection with this DB
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")
## get all tables in it .. 
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

dbListFields(hg19, "affyU133Plus2") # check all the fields in this particular table

#count number of rows in this dataset (table)
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

# read the table ..
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

## select specific subset ..
query <- dbSendQuery(hg19, "select * from affyU133Plus2")
affyMis <- fetch(query); quantile(affyMis$misMatches)
dbDisconnect(hg19)
##################


## Reading from HDF5 .. for storing large datasets
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5") ## load package ..

## call library ..
library(rhdf5)
created = h5createFile("example.h5")
created

## create exmpty group ..
created = h5createGroup("example.h5", "foo")
created

created = h5createFile("example.h5")
created

## create group ..
created = h5createGroup("example.h5", "baa")
created
created = h5createFile("example.h5")
created

## create subgroup ..
created = h5createGroup("example.h5", "foo/foobaa")
created
h5ls("example.h5") ## list all groups ..

## write to groups ..
A = matrix(1:10, nr = 5, nc = 2)
A
h5write(A, "example.h5", "foo/A")
h5ls("example.h5")

B = array(seq(0.1,2.0, by = 0.1), dim=c(5,2,2))
B
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

## write dataset directly ..
df = data.frame(1L:5L, seq(0,1,length.out = 5), c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
df

h5write(df, "example.h5", "df")
h5ls("example.h5")

## Reading data ..
readA = h5read("example.h5", "foo/A")
readA

## writing and reading chunks ..
h5write(c(12,13,14), "example.h5", "foo/A", index = list(1:3,1)) # write to the 1st three rows and 1st column of this DS
h5read("example.h5", "foo/A")

#### Reading from Web ..
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
con
htmlCode = readLines(con)
close(con)
htmlCode

## parsing with URL .. 
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue) #get title .. 

# read more info raletd to citation ..
xpathSApply(html,"//td[@id='col-citedby']", xmlValue)

## get data from httr .. the same way !!
## using GET command ..
library(httr); html2 = GET(url)
content2 = content(html2, as = "text")
parsedHtml = htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

## what about getting data from a website with username and pass ?! ..
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1 ## can't find a content cuase u are not authenticated !!

# let's auth. ourselves through the website ..
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg2 # congrats. now u r authenticated :) 
names(pg2) ## reading data ..

## handles .. to save the auth. through multiple websites ..
google = handle("http//google.com")
pg3 = GET(handle = google, path = "/")
pg3

pg4 = GET(handle = google, path = "search") 
pg4
# if u get through this website again, the cookes will keep u auth ..

## Reading Data from APIs (application programming interfaces) .. i.e. twitter, FB
## let's read from twitter 
myapp = oauth_app("twitter", key = "yourCustomerKeyHere", secret = "yourCustomerSecretHere")
sig =  sign_oauth1.0(myapp, token = "yourTokenHere", token_secret = "yourTokenSecretHere")
homeTL = GET("http://api.twitter.com/1.1/statuses/home_timeline.json", sig)
# now we gonna use content fun to extarct the json data ..

install.packages(c("jsonlite"))
library(jsonlite)

json1 = content(homeTL)
json1
json2 = jsonlite::fromJSON(toJSON(json1)) # to create data frame
json2
#json2[1, 1:4] # to obtain certian dim
# each row is corresponding to a tweet ..

#which url to be passed to the get fun ?! .. 
# go to https://api.twitter.com/1.1/search/tweets.json .. and then recource URL

## reading data from Github AP tutorial ==> https://developer.github.com/guides/getting-started/

## the end :)

