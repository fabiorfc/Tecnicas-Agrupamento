
#################################################2º) PAM - Partitioning Around Medoids
#To run the code below, first we have to install and load Cluster Package
#install.packages('cluster')
library('cluster')


#Calculus of the silhouette index for every values of cluster
si = 0
for (i in 2:(length(df[,1])-1))
{si[i] = (pam(x = df[2:length(df)], k = i, metric = 'euclidian')$silinfo)$avg.width}

#THIS CODE HAVE TO BE IMPROVED
plot(si, main = 'Silhouette Index for every values of K', cex.main = 1, #Data and main title information
     ylab = 'Index', cex.lab = 1, xlab = 'Possible values of k',        #Labels names and size
     cex = 0.7, pch = 18, cex.axis = 0.8,                               #Size and style of the points
     ylim = c(0,1))                                                     #Vertical axis limit
     grid(); abline(h = max(si), lty = 'dotted', col = 'red')           #Adding grid and a dotted line in Max Silhouette value
     leg.text = c('Best value for k - k = ', max(si))
     legend('topright', legend = as.expression(leg.text),
            bty = 'n')          #Remove the legend box
#  
     
     
Kmd = pam(x = df[2:length(df)], k = 4,
          metric = 'euclidian' #There are Euclidean and Manhattan metrics
          )

#Resume all PAM contents
summary(Kmd)

#Plot to verify the clustering
par(mfrow = c(1,2))
plot(Kmd, cex = 0.5,
     ask = TRUE #Parameter that ask about what plot user want to see
      )

#Silhouette plot interpretation
# 0.00 < 0.25: No substantial structure has been found
# 0.26 - 0.50: The structure is weak and could be artificial
# 0.51 - 0.70: A reasonable structure has been found
# 0.71 - 1.00: A strong structure has been found

