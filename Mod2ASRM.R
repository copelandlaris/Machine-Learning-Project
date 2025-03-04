#### Association Rule Mining

library(tidyverse)
library(dplyr)
library(arules)
library(arulesViz)
library(igraph)

setwd("/Users/copelandlaris/Documents/Spring 2025/Machine Learning")

df = read.transactions('FINAL_ASRM.csv', format="basket", sep=",")

rules = apriori(df, parameter=list(supp=0.05, conf=0.7, minlen=2))

length(rules)


#Top Rules by category
inspect(sort(rules, by="conf")[1:15])
inspect(sort(rules, by="supp")[1:15])
inspect(sort(rules, by="lift")[1:15])

subset(rules, confidence == 1)

# Sort and select the top 15 rules by lift
top_rules_lift <- head(sort(rules, by = "lift"), 15)

#plot
p <- plot(top_rules_lift, 
          method = "graph", 
          control = list(colors = c("#EE0000FF", "blue")), 
          engine = "ggplot2")

p + ggtitle("Association Rules Network Top Rules by Lift")


# Sort and select the top 15 rules by confidence
top_rules_conf <- head(sort(rules, by = "conf"), 15)

# Plot the graph with custom colors using the ggplot2 engine
p <- plot(top_rules_conf, 
          method = "graph", 
          control = list(colors = c("#EE0000FF", "blue")), 
          engine = "ggplot2")

# Update the plot with a title and change the legend title to "Confidence"
p + ggtitle("Association Rules Network Top Rules by Confidence") +
  labs(color = "Confidence")
