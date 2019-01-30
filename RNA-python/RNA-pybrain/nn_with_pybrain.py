#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jan 30 10:26:32 2019

@author: jean
"""

#importanto pacotes pybrain

from pybrain.structure import FeedForwardNetwork
from pybrain.structure import LinearLayer, SigmoidLayer, BiasUnit
#serve para fazer ligacao entre camadas
from pybrain.structure import FullConnection


nn = FeedForwardNetwork() #cria rede

#Camada de entrada. Recebe o numero de NEURONIOS na camda de ENTRADA. Ex: 2
in_layer = LinearLayer(2)

#Camada Oculta. Recebe o numero de NEURONIOS na camda de OCULTA. Ex: 3
hidden_layer = SigmoidLayer(3)

#Camada de saida. Recebe de NEURONIOS na camda de SAIDA. Ex: 1
out_layer = SigmoidLayer(1)

bias1 = BiasUnit() #para a camada oculta
bias2 = BiasUnit() #para a camda de saída

#adicionar camadas a rede

nn.addModule(in_layer)
nn.addModule(hidden_layer)
nn.addModule(out_layer)
nn.addModule(bias1)
nn.addModule(bias2)

#ligacao entre as camadas

#Cada neuronio de ENTRADA está LIGADO a TODOS os neuronios da camada OCULTA
hidden_in = FullConnection(in_layer,hidden_layer)

#Cada saida da camada OCULTA entra no(s) neuronio(s) da camada de SAIDA
hidden_out = FullConnection(hidden_layer,out_layer)

#ligacao do bias

bias_hidden = FullConnection(bias1,hidden_layer)
bias_out = FullConnection(bias2,out_layer)

#Constroi a rede
nn.sortModules()

#Prints para verificação de dados
print(nn)

#PESOS gerados entre neuronios de entrada e neuronios na camada oculta
print(hidden_in.params)
#PESOS gerados entre neuronios ocultos e neuronios na camada de saída
print(hidden_out.params)
#PESOS gerados entre bais e camda oculta
print(bias_hidden.params)
print(bias_out.params)








