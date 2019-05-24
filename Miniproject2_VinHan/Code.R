
library(readr)
hcov <- read.csv("hcare_cov.csv")
hspend <- read.csv("hcare_spend.csv")
View(hcov)
View(hspend)

library(dplyr)
spending2014 <- hspend %>%
  select(Location, X2014__Total.Health.Spending)
coverage2014 <- hcov %>%
  select(Location, X2014__Total)
spending2013 <- hspend %>%
  select(Location, X2013__Total.Health.Spending)
coverage2013 <- hcov %>%
  select(Location, X2013__Total)

Total <- spending2013 %>% right_join(coverage2013, by = "Location") %>% right_join(spending2014, by = "Location") %>% right_join(coverage2014, by = "Location")
Total_ind <- Total %>% slice(2:52)   
ggplot(data=Total_ind) + geom_point(mapping = aes( x= X2014__Total.Health.Spending, y=X2014__Total, color="2014")) + geom_point(mapping = aes( x= X2013__Total.Health.Spending, y=X2013__Total, color="2013")) + labs(x="Total Spending", y="Total Coverage") + geom_smooth(mapping = aes( x= X2014__Total.Health.Spending, y=X2014__Total, color="2014"))+ geom_smooth(mapping = aes( x= X2013__Total.Health.Spending, y=X2013__Total, color="2013"))

hcov_medic <- hcov %>% select(c(1, 4, 11)) %>% right_join(spending2014, by = "Location")
hcov_2 <- hcov_medic %>% arrange(desc(X2014__Total.Health.Spending)) %>% slice(2:11)
hcov_3 <- hcov_2 %>% select(c(1,2,3))
hcov_3 %>% gather("Type","Coverage",-Location) %>% 
  ggplot(aes(fill=Type,x=Location,y=Coverage)) + geom_col( position = "dodge") + coord_flip()



---
This data set gave us location, the amount of spending for different subcategories of healthcare, and total coverage costs for each subcategory of healthcare. 
The first graph depicts the relationship between total spending and total coverage. 
In this graph, we added a trend line graphic to better understand the trend of the data between the years of 2013 and 2014. 
Further, the last graph depicts the specific increase of medicaid heathcare coverage between 2013 and 2014. 
We chose these years in particular, because we wanted to verify the claim that during the year of 2014, medicaid increased their healthccare coverage. 
This graph and data set support this claim.

https://www.hccmis.com/blog/insurance/changes-in-healthcare-in-2013/?fbclid=IwAR3_sLfSY4FRcdLbV3SMbZlxoOeA7CDrGdpqOM-kxYxE0iJE3frSY2ztqkM
---