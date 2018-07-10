

#################################################1º) K-MEANS


# Determine number of clusters using a function
Cluster.Number = function(x) {
  
    #Verifying if all vectors are numeric
    for(i in 1:ncol(x)) {
      if (is.numeric(x[,1]) == FALSE) {
        print('All elements from sample vectors must be numeric')
      }  
      break
    }
      
    #Calculating the initial within square sum
    wss = sum(apply(x, 2, var)) * (nrow(x)-1)
    #Calculus of others SS
    for(i in 2:(nrow(x)-1)) { wss[i] = sum(kmeans(x, centers = i, iter.max = 500)$withinss) }
    
    return(wss)
}
wss = Cluster.Number(x)

#Ploting the within square sum of the clusters
plot(1:length(wss), wss, type = 'b',
     xlab = 'Number of Clusters', 
     ylab = 'Within groups sum square',
     main = 'Number of cluster versus SS within groups',
     cex.main = 1.2, cex.axis = 0.8, cex.lab = 1)
grid()

#Applying the K-MEANS algorithm
Kme = kmeans(x, centers = 5, iter.max = 100, 
             algorithm = 'MacQueen', nstart = 4)

#Algorithm methods:
#a) Hartigan-Wong
#b) Lloyd
#c) Forgy
#d) MacQueen

#Printing data with the calculate clusters
data.frame(x, ncluster$cluster)



