#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 18 10:58:55 2018

@author: jean
"""

from pybrain.tools.shortcuts import buildNetwork
from pybrain.datasets import SupervisedDataSet
from pybrain.supervised.trainers import BackpropTrainer

import numpy as np

def fresadora(t):
    return ((2/5) + (1/10 * np.e**(-5*t)) - ((1/2) * np.e**(-t)))

ds = SupervisedDataSet(1,1)

entradasX = np.arange(0,10,0.25)
targetsY = fresadora(entradasX)

for k in range(len(entradasX)):
    ds.addSample(entradasX[k], targetsY[k])

#buildNetwork(NUMERO DE NEURONIOS NA ENTRADA, NEURONIOS NA CAMADA OCULTA, CAMADA DE SAIDA, bias=True)
    
#PARAMETERS    
neuronsIn = 3 #neuronios na camada de entrada
neuronsHL = 4 # neuronios na camada oculta
neuronsOut = 1 # neuronios na camada de saida
epochs = 200 #epocas

#rede
nn = buildNetwork(3, 3, 1, bias=True)

#trainer
trainer = BackpropTrainer(nn,ds)

#for i in range(epochs):
#    print(trainer.train())



