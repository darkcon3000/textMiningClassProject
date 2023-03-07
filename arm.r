install.packages("arules")
install.packages("TSP")
install.packages("data.table")
install.packages("arulesViz", dependencies = TRUE)
install.packages("sp")
install.packages("dplyr", dependencies = TRUE)
install.packages("purrr", dependencies = TRUE)
install.packages("devtools", dependencies = TRUE)
install.packages("tidyr")
library(viridis)
library(arules)
library(TSP)
library(data.table)
#library(ggplot2)
#library(Matrix)
library(tcltk)
library(dplyr)
library(devtools)
library(purrr)
library(tidyr)

install_github("mhahsler/arulesViz")
capabilities()["tcltk"]
library(arulesViz)

df <- read.transactions("traintransaction.csv",
                                rm.duplicates = FALSE, 
                                format = "basket",  ##if you use "single" also use cols=c(1,2)
                                sep=",",  ## csv file
                                cols=1) ## The dataset HAS row numbers
#inspect(df)

FrulesK = arules::apriori(df, parameter = list(support=.07, 
                                                       confidence=.07, minlen=2))
inspect(FrulesK)
itemFrequencyPlot(df, topN=20, type="absolute")
SortedRulesK <- sort(FrulesK, by="confidence", decreasing=TRUE)
inspect(SortedRulesK)
(summary(SortedRulesK))


trumpRules <- apriori(data=df,parameter = list(supp=.001, conf=.01, minlen=2),
                     appearance = list(default="lhs", rhs="trump"),
                     control=list(verbose=FALSE))
trumpRules <- sort(trumpRules, decreasing=TRUE, by="confidence")
inspect(trumpRules[1:4])

tRules <- apriori(data=df,parameter = list(supp=.001, conf=.01, minlen=2),
                      appearance = list(default="rhs", lhs="trump"),
                      control=list(verbose=FALSE))
tRules <- sort(tRules, decreasing=TRUE, by="support")
inspect(tRules[1:4])



subrulesK <- head(sort(SortedRulesK, by="lift"),50)
plot(subrulesK)

plot(subrulesK, method="graph", engine="interactive")
plot(subrulesK, method="graph", engine="htmlwidget")
