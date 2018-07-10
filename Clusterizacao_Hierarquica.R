

#1) applying the algorithm
cluster = hclust(dist(df[2:ncol(df)], method = 'euclidian'), method = 'ward')
#Methods:
  #a) single
  #b) complete
  #c) average
  #d) mcquitty
  #e) median
  #f) centroid
  #g) ward


#2) Ploting results
plot(cluster,             #Cluster instance 
     labels = df[,1],     #Object names
     main = 'Dendrogram', #Plot title
     xlab = 'Sample', 
     sub = '', 
     ylab = 'Distances',
     cex.main = 1,
     cex = .7,
     cex.axis = .7)
box()

#3) Cluster info
cluster
summary(cluster)

#4) Cuting dendrogram into 'n = 4' clusters
cutree(tree = cluster, k = 5)

#5) Draw borders in dendrogram's groups
rect.hclust(tree = cluster, k = 4, border = 'red')

