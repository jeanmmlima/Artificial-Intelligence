#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Feb  1 10:57:17 2019

@author: jean
"""

from pybrain.tools.shortcuts import buildNetwork
from pybrain.datasets import SupervisedDataSet
from pybrain.supervised.trainers import BackpropTrainer
from pybrain.structure.modules import SoftmaxLayer
from pybrain.structure.modules import SigmoidLayer


n_neurons_in = 2
n_neurons_hidden = 3
n_neurons_out = 1 


#### CONCEPTS #####

#construindo rede (N_neuronios_ENTRADA, N_neuronios_OCULTA, 
#N_neurons_SAIDA, outclass=SoftmaxLayer, hiddenclass=SigmoidLayer,
#bias = false)
#outclass=SoftmaxLayer: Camada de saida deixa de ser linear e passa a ser soft max
#bias = false: Retira a camda de bias da rede
nn = buildNetwork(2, 3, 1, outclass=SoftmaxLayer, hiddenclass=SigmoidLayer)

print(nn['in'])
#Primeira camada oculta - hidden0 - Sigmoide por padrão
print(nn['hidden0'])
#Camada de saída linear por padrão
print(nn['out'])
print(nn['bias'])

##### BUILDING NETWORK AND DATASET ####


nn = buildNetwork(2,3,1)
'''Base exemplo do XOR
2 Atributos previsores e 1 classe
'''
base = SupervisedDataSet(2,1)
#adicionando elementos base de dados XOR
base.addSample((0,0),(0,))
base.addSample((0,1),(1,))
base.addSample((1,0),(1,))
base.addSample((1,1),(0,))

#checando base de dados
print(base['input'])
print(base['target'])

##### TRAINING #####

trein = BackpropTrainer(nn,dataset=base,learningrate=0.01,
                        momentum=0.0)

epochs = 30000

for i in range(epochs):
    erro = trein.train()
    if i % 1000 == 0:
        print("Erro: %s" % erro)

'''Para usar a rede neural treinada
chama-se a funcao activate(). Essa funcao
recebe como parametro as entradas da rede
e gera um saida que é a estimativa da rede
'''
print(nn.activate([0,0]))
print(nn.activate([0,1]))
print(nn.activate([1,0]))
print(nn.activate([1,1]))



