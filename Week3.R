## subsetting .. means replacing cells with whatever values .. 
set.seed(123435) #random number generation ..
X <- data.frame("var1" = sample(1:5),"var2" = sample(6:10), "var3" = sample(11:15))
X
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X[,1] # get the 1st vector .. 
X[,"var2"] # get the 2nd vector 
X[1:2,"var2"] # first two cells in the 2nd vector ..

X[(X$var1 <= 3 & X$var3 > 11),]

X[(X$var1 <= 3 | X$var3 > 11),]

#dealing with NA .. 
X[which(X$var2 > 8),] # now he will ignore NA cells 

sort(X$var2)# NA will be ignored ..
sort(X$var2, na.last = TRUE) # NA will be added at the end ..

sort(X$var1, decreasing = TRUE)

#ordering -sorting- them by Var1
X[order(X$var1),]

X[order(X$var1, X$var2),]# ordering by multiple vars 
# this means that .. he will sort based on var1 values and in case of a tie .. order by var3

## ordering by plyr package ..
install.packages(c("plyr"))
library("plyr")
arrange(X, var1)
arrange(X, desc(var1))

#transformation .. adding new var to the dataset ..
X$var4 <- rnorm(5)
X
# or we can use cbind fun .. c + bind .. c for Column, or add rows via rbind 
Y <- cbind(X, rnorm(5)) # add Y to the right of x 
Y

Y <- cbind(rnorm(5), X) # add Y to the left of x 
Y

## Summarizing data .. 
## download the data .. 
fileURL <- "http://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "E:/FCI/Research Work/Self Studying/Coursera/data/resturants.csv", method = "curl")
restData <- read.csv("E:/FCI/Research Work/Self Studying/Coursera/data/resturants.csv")
head(restData, n = 3)
tail(restData, n  = 3)
summary(restData) # to summarize the data .. 
str(restData) # show the data types, dimentions that u have 


# more analysis .. 
# quantiles .. 
quantile(restData$councilDistrict, na.rm = TRUE) # NA vals are removed before calc the quantiles ..
# u can look at different percentiles .. 
quantile(restData$councilDistrict, c(0.5, 0.75, 0.9))

#another handsome view .. 
table(restData$zipCode, useNA = "ifany")

# u can contruct table between continous vars to check the relationship between those vars.. 
table(restData$councilDistrict, restData$zipCode)

#checking the missing values .. 
sum(is.na(restData$councilDistrict))
# another way .. 
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
sum(is.na(restData$zipCode))

## u can sum cols and rows to check as well ..
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

## search for spesific values inside the zipcode vector .. 
table(restData$zipCode %in% c("21212")) # is there any zip code that is = 21212?!
# i can search for more than one value ..
table(restData$zipCode %in% c("21212", "21213")) # check either one ..

## disply the rows that satisfy the condition above ..
restData[restData$zipCode %in% c("21212", "21213"),]


## back to data summaries .. 
# I can also use "Cross tabs" for data summaries .. 
data(UCBAdmissions) # this is the dataset name
DF = as.data.frame(UCBAdmissions)
summary(DF)

# let's categories the accepted members by gender .. and show their frequancy 
xt <- xtabs(Freq ~ Gender + Admit, data = DF) #gender vs admit
xt

## flat tables (for larger number of vars)
warpbreaks$replicate <- rep(1:9, len = 54) # standard R dataset 
xt = xtabs(breaks ~., data = warpbreaks) # ~. means break the warkpbreaks dataset by ALL the other var in it
xt # multiple two dim. tables which are hard to see .. 
# hence, flat-tables are required ..
ftable(xt) # summarize the data into table format


# print the size of your data set , whether in bytes or in MB 
fakeData <- rnorm(1e5)
object.size(fakeData) #in bytes
print(object.size(fakeData), units = "Mb")


## Variable Transformation "adding vars"
fileURL <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "E:/FCI/Research Work/Self Studying/Coursera/data/resturants.csv")
restData <- read.csv("E:/FCI/Research Work/Self Studying/Coursera/data/resturants.csv")
head(restData)

# first of all, we have to create sequances, this is like an index for your dataset
s1 <- seq(1, 10, by=2)
s1

s2 <- seq(1, 10, length = 4)
s2

x <- c(1, 3, 8, 25, 100); seq(along = x) #create a vector with the same length

## create new var that counts the nearby resturants ..
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

#another condition, resturns true if -ve zipcodes exist
restData$zipwrong = ifelse(restData$zipCode < 0, TRUE, FALSE) 
table(restData$zipwrong)
table(restData$zipwrong, restData$zipCode < 0)

#creating categorical variables, as if discrtization ..
# u gonna split the value according to certain values
restData$Dist = cut(restData$councilDistrict, breaks = quantile(restData$councilDistrict))
table(restData$Dist)
table(restData$Dist, restData$councilDistrict)

#another way is to use Hmisc package and call cut function ..
#install.packages(c("Hmisc"))
library(Hmisc)
restData$zipGroups = cut2(restData$councilDistrict, g = 4) # g is the # of cuts
table(restData$zipGroups)

# a 3rd way is to convert the int to factor var, is to use "factor" fun..
restData$zcf = factor(restData$councilDistrict)
restData$zcf[1:10]
class(restData$zcf)

## dealing with factor variable (i.e changing its values representation)
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE) # creaing dummy var of length 10
yesno

yesnofac = factor(yesno, levels = c("yes", "no"))
yesnofac

relevel(yesnofac, ref = "yes")
#changing the lowest value (yes) and call it 1 and the other value (no) to be 2
as.numeric(yesnofac)

## adding new variable to the whole dataframe .. 
# using mutate func from plyr package ..
library(Hmisc)
#install.packages(c("plyr"))
library(plyr)
restData2 = mutate(restData, zipGroups = cut2(councilDistrict, g = 4))
table(restData2$zipGroups)
head(restData)


## Reshaping the data .. 
install.packages(c("reshape2"))
library(reshape2)
head(mtcars)

mtcars$carname <- rownames(mtcars)
mtcars$carname
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
carMelt

#cast funct... as if u summarize vars wrt certain choosen var
cylData <- dcast(carMelt, cyl ~ variable) # default ==> count
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

# -fast- sum values ..
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum) #sum ALL distnict values 


## another way to sum, splitting then sum..
spIns = split(InsectSprays$count, InsectSprays$spray) #split each count by the spray
spIns

# then ..
sprCount <- lapply(spIns, sum)
sprCount # listted output

# the 3rd way is to unlist the elements and them apply sapply ..
# unlist the elements .. 
unlist(sprCount)
sapply(sprCount, sum)

# 4th way .. plyr package ..
library("plyr")
ddply(InsectSprays,.(spray), summarize, sum = sum(count))

## sumarize by creating new variable .. 
spraySums <- ddply(InsectSprays,.(spray), summarize, sum=ave(count, FUN = sum))
dim(spraySums)
head(spraySums) # see the sum for every value in the dataset , i.e. whenever u see A will see its sum to be 174

## extra functions ..
# acast ==> for casting multiDim arrays ..
#arrange ==> for faster reordering rather than order()
#mutate ==> adding new variables



## dplyr for dealing with dataframes ..
# install.packages(c("RDS"))
# library("RDS")
library("dplyr")
# options(width = 105)
# 
# fileURL <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/dplyr/chicago.rds?raw=true"
# download.file(fileURL, destfile = "E:/FCI/Research Work/Self Studying/Coursera/data/chicago.rds")
# 
# chicago <- readRDS("E:/FCI/Research Work/Self Studying/Coursera/data/chicago.rds")
# chicago
# str(chicago)
# 
# names(chicago)
# head(select(chicago, city: dptp))

fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data/cameras.csv")
redFile <- read.csv("E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data/cameras.csv")
head(redFile)
str(redFile)
names(redFile)

## merging data .. 
fileURL1 <- "http://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileURL2 <- "http://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileURL1, destfile = "E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data/reviews.csv")
download.file(fileURL2, destfile = "E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data/solutions.csv")
reviews = read.csv("E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data/reviews.csv")
solutions = read.csv("E:/FCI/Research Work/Self Studying/Coursera/Data Science Specialization/Data/solutions.csv")
head(reviews,2)
head(solutions,2)
names(reviews)
names(solutions)

# merge fun, by default it merges by the common columns names, but we can spesify the cols to merge by using "by" keyword
mergeData <- merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = TRUE)
# all = true, means that if one value exists in one of the cols but not in the other, include it in the merged results with NA in the other
head(mergeData)

## merge based on all common col names ==> intersect fun then merge()
# needs larger memory size than the previous fun (merge only) as ALL the elements from both tables are listed 
intersect(names(solutions), names(reviews))
mergedData2 <- merge(reviews, solutions, all = TRUE)
head(mergedData2) 

install.packages(c("plyr"))
library("plyr")
## the third way for merging is .. to use plyr package .. 
df1 = data.frame(id = sample(1:10), x=rnorm(10))
df2 = data.frame(id = sample(1:10), y = rnorm(10))
arrange(join(df1, df2), id) #merge the two DFs by id

## what if we have multiple data frames ?! .. plyr package using will be a little bit harder ..
# hence we gonna put all of them in a list and use "join_all" fun
df1 = data.frame(id = sample(1:10), x=rnorm(10))
df2 = data.frame(id = sample(1:10), y = rnorm(10))
df3 = data.frame(id = sample(1:10), z = rnorm(10))
dfList <- list(df1, df2, df3)
dfList
join_all(dfList)

## the end ..
