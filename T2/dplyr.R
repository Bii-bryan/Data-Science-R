The following code demonstrates the dplyr package for data manipulation in R, which provides a cleaner, more intuitive syntax than base R.

Setup & Data Loading
#Install the packages: 
#install.packages("hflights")
#install.packages("dplyr")
library(hflights)
library(dplyr)
data(hflights)
flights <- tbl_df(hflights)  # Convert to tibble (modern data frame)
#Loads the hflights dataset (Houston flight data)
#tbl_df() creates a tibble - prints nicely and shows data types

1. FILTER - Subsetting Rows
# Base R (messy)
flights[flights$Month==1 & flights$DayofMonth==1, ]

# dplyr (clean)
filter(flights, Month==1 & DayofMonth==1)

# OR condition
filter(flights, UniqueCarrier=="AA" | UniqueCarrier=="UA")
#filter() selects rows based on conditions - much cleaner than base R bracket notation!

2. SELECT - Choosing Columns
# Base R
flights[, c("DepTime", "ArrTime", "FlightNum")]

# dplyr
select(flights, DepTime, ArrTime, FlightNum)

# Advanced selection
select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))
#select() chooses columns by name.

3. CHAINING & PIPING (%>%)
flights %>%                           # 1. Take the data
  select(UniqueCarrier, DepDelay) %>% # 2. Select columns
  filter(DepDelay > 60)               # 3. Filter rows
#The pipe operator %>% chains operations together:

4. ARRANGE - Sorting Data
# Ascending order
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay)

# Descending order
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay))
#arrange() sorts data. Use desc() for descending order.

5. MUTATE - Creating New Variables
# Create Speed variable (mph)
flights %>% mutate(Speed = Distance/AirTime*60)

# Store the new variable permanently
flights <- flights %>% mutate(Speed = Distance/AirTime*60)
#mutate() adds new columns based on calculations from existing columns.

6. SUMMARISE - Aggregating Data
Basic Summarise
flights %>%
  group_by(Dest) %>%                              # Group by destination
  summarise(avg_delay = mean(ArrDelay, na.rm=TRUE))  # Calculate mean
#Calculates average arrival delay for each destination.

Summarise Multiple Columns
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(mean, min(., na.rm=T), max(., na.rm=T)), 
                 Cancelled, Diverted)
#summarise_each() applies multiple functions to multiple columns
#Calculates mean, min, max for Cancelled and Diverted columns for each carrier

Using Pattern Matching
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(min(., na.rm=TRUE), max(., na.rm=TRUE)), 
                 matches("Delay"))
#Finds min/max of all columns containing "Delay" for each carrier.

7. MORE ADVANCED USES
Creating Tables
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table()
#Shows count of cancelled vs. not cancelled flights by destination.

8. WINDOW FUNCTIONS - Ranking Within Groups
Top N per Group (Method 1)
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  filter(min_rank(desc(DepDelay)) <= 10) %>%  # Top 10 delays per carrier
  arrange(UniqueCarrier, desc(DepDelay))
#min_rank() ranks values within each group
#Shows the 10 worst delays for each airline

Top N per Group (Method 2)
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  top_n(2) %>%                                # Top 2 per carrier
  arrange(UniqueCarrier, DepDelay)
#top_n() is a shortcut for selecting top N values per group.
