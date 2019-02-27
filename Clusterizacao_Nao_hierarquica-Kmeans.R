

#################################################1º) K-MEANS


# Função para gerar a variabilidade de cada sugestão de cluster
Cluster.Number = function(x) {
  
  # Verificando se todos os dados são numéricos
  for(i in 1:ncol(x)) {
    if (is.numeric(x[,1]) == FALSE) {
      print('All elements from sample vectors must be numeric')
    }  
    break
  }
  
  #Cálculo da variabilidade inicial
  wss = sum(apply(x, 2, var)) * (nrow(x)-1)
  #Cálculo das variabilidades geral após a clusterização
  for(i in 2:20) { wss[i] = sum(kmeans(x, centers = i, iter.max = 500)$withinss) }
  
  return(wss)
}
wss = Cluster.Number(x)

#Plotando os resultados
plotaLinhas = function(vetor_de_cluster, subtitulo){
  
  # Convertendo o vetor para um dataframe
  vetor_de_cluster = as.data.frame(vetor_de_cluster)
  
  # Criando um vetor de dados para representar o número de clusters
  clusters = 1:nrow(vetor_de_cluster)
  vetor_de_cluster$clusters = clusters
  
  # Plotando o gráfico
  ggplot(vetor_de_cluster, aes(x = clusters, y = vetor_de_cluster))+
    geom_line()+
    geom_point()+
    ggtitle("Redução da variabilidade",subtitle = subtitulo)+
    ylab("Variabilidade")+
    xlab("Número de Clusters")
  
}

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



