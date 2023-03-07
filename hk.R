install.packages("NbClust")
library(NbClust)
library(cluster)
library(mclust)

tf_idf <- read.csv('trainTFIDF.csv')
df = subset(tf_idf, select = -c(X) )

df[is.na(df)] <- 0

Matrix <- as.matrix(df)
sim <- Matrix / sqrt(rowSums(Matrix * Matrix))
sim <- sim %*% t(sim)
D_sim <- as.dist(1 - sim)

cluster1 <- hclust(Matrix, method = "average")
cut_avg <- cutree(cluster1, k = 5)
plot(cut_avg)
