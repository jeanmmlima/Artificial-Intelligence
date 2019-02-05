#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb  4 22:40:44 2019

@author: jeanmarioml
"""

#library scikit-learn utulizando base de dados iris

from sklearn.neural_network import MLPClassifier
from sklearn import datasets

iris = datasets.load_iris()

#### DATA

inputs = iris.data
outs = iris.target

#### BUILDING AND TRAINING 

#cria rede
#verboseTrue mostra o erro de treinamento
#Se valor nao aumentar mais que o Tol em duas interações,o algoritmo para
#pois nao esta mais convergindo

#Activation altera a funcao de ativacao. Logistic é a sigmoid
nn = MLPClassifier(verbose=True, 
                   max_iter=1000,
                   tol=0.00001,
                   activation='logistic', 
                   learning_rate_init=0.001) 

#trainamento
nn.fit(inputs,outs)


#previsao
nn.predict([[5,7.2,5.1,2.2]])