#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""----------------------------------------------------------------------------
    Libraries
"""
import pandas as pd
from sklearn.preprocessing import StandardScaler #Normalozacao z-score
from sklearn.cluster import KMeans
from sklearn.manifold import TSNE
#from sklearn.datasets import make_blobs
import matplotlib.pyplot as plt

"""----------------------------------------------------------------------------
    Importando os dados
"""
link_url = "https://archive.ics.uci.edu/ml/machine-learning-databases/ecoli/ecoli.data"
df = pd.read_csv(link_url, sep = "\s+", header = None)

nomes_das_colunas = ["name","mcg","gvh","lip","chg","aac","alm1","alm2","class"]
df.columns = nomes_das_colunas
del link_url, nomes_das_colunas


"""----------------------------------------------------------------------------
    Tratando as variáveis
"""
# Extraindo dados numéricos
dados_numericos = df[["mcg","gvh","lip","chg","aac","alm1","alm2"]]
# Criando vetor de Dummies
classes = df["class"].str.get_dummies()
# Concatenando os dados
dados = pd.concat([dados_numericos, classes], axis = 1)
del classes,dados_numericos
# Instanciando o Scaler de dados
scaler = StandardScaler()
dados_normalizados = scaler.fit_transform(dados)


"""----------------------------------------------------------------------------
    Identificacao do numero de clusters
"""
# Função para calcular a 
def clusterizacao_kmeans(numero_de_clusters, dados):
    # Instancia e Treina o modelo
    modelo = KMeans(n_clusters=numero_de_clusters)
    modelo.fit(dados)
    
    return [numero_de_clusters, modelo.inertia_]

# Gerando os erros
resultados = [clusterizacao_kmeans(numero_de_clusters, dados_normalizados) for numero_de_clusters in range(1, 15)]

resultados = pd.DataFrame(resultados, columns=['Grupos','Inertia'])

plt.plot(resultados["Grupos"],
         resultados["Inertia"], 'ro')


"""----------------------------------------------------------------------------
    Clusterizacao dos dados
"""
modelo = KMeans(n_clusters=4)
modelo.fit(dados_normalizados)
print("Grupos {}".format(modelo.labels_) )


"""----------------------------------------------------------------------------
    Visualizando os centroides
"""
# Print dos centroides dos cluster
print(modelo.cluster_centers_)

# Visualizacao gráfica via pandas
grupos = pd.DataFrame(modelo.cluster_centers_, columns=dados.columns)
grupos
grupos.transpose().plot.bar(subplots=True,
                figsize=(25,25),
                sharex=False,
                rot=0)


# Visualando via TSNE
tsne = TSNE()
visualizacao = tsne.fit_transform(dados_normalizados)
visualizacao

plt.scatter(x=visualizacao[:,0],
            y=visualizacao[:,1])


"""
# Visualizacao via make_blobs
dados, _ = make_blobs(n_samples=1000, n_features=2, random_state=7)
dados = pd.DataFrame(dados, columns=['coluna1', 'coluna2'])
dados.head()
plt.scatter(x=dados.coluna1, y=dados.coluna2)

modelo = KMeans(n_clusters=3)
grupos = modelo.fit_predict(dados)

centroides = modelo.cluster_centers_
plt.scatter(dados.coluna1, dados.coluna2,
            c=grupos,
           cmap='viridis')

plt.scatter(centroides[:, 0], centroides[:, 1],
           marker='X', s=169, linewidths=5,
           color='g', zorder=8)
"""


