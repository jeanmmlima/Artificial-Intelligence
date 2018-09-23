#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jun 19 10:20:11 2018

@author: jean
"""

from pybrain.structure import FeedForwardNetwork
from pybrain.structure import LinearLayer, SigmoidLayer
from pybrain.structure import FullConnection
from pybrain.datasets import SupervisedDataSet
from pybrain.supervised.trainers import BackpropTrainer
import numpy as np
import norm as no

x1 = range(400)
x1 = np.array(x1)
y1 = x1*x1

maxX1 = np.max(x1)
minX1 = np.min(x1)
maxY1 = np.max(y1)
minY1 = np.min(y1)
nX1 = no.normalize01(x1)
nY1 = no.normalize01(y1)

epocas = 3000

DS = SupervisedDataSet(1,1)
#DS.appendLinked([1],[2])
#DS.appendLinked([2],[3])
for i in range(len(nX1)):
    DS.appendLinked((nX1[i]),(nY1[i]))

#Creiando rede FF
n = FeedForwardNetwork()

#Construindo Módulos
inLayer = LinearLayer(DS.indim)
hiddenLayer = SigmoidLayer(8)
hiddenLayer2 = SigmoidLayer(12)
outLayer = LinearLayer(DS.outdim)

#Adicionando os módulos criados a rede
n.addInputModule(inLayer)
n.addModule(hiddenLayer)
n.addModule(hiddenLayer2)
n.addOutputModule(outLayer)

#Deve ser explicito como os módulos devem estar conectados

in_to_hidden = FullConnection(inLayer,hiddenLayer)
hidden_to_hidden2 = FullConnection(hiddenLayer,hiddenLayer2)
hidden2_to_out = FullConnection(hiddenLayer2,outLayer)

#Adicionar conexões criadas a Rede

n.addConnection(in_to_hidden)
n.addConnection(hidden_to_hidden2)
n.addConnection(hidden2_to_out)

#inicializando arquitetura MLP
n.sortModules()

trainer = BackpropTrainer(n,DS,0.1,1)

for i in range(epocas):
    print(trainer.train())
 #%%  
valor = ([25])
nV = no.normalize4Test(valor,minX1,maxX1)

res = n.activate(nV)

dRes = no.deNormalize4Test(res,valor,minY1,maxY1)




