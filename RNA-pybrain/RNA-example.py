#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 18 14:30:46 2018

@author: jean
"""

from pybrain.tools.shortcuts import buildNetwork
from pybrain.datasets import SupervisedDataSet
from pybrain.supervised.trainers import BackpropTrainer

from pybrain.structure import TanhLayer


import numpy as np
import norm as n

ds = SupervisedDataSet(1,1)

x1 = range(100)
x1 = np.array(x1)
y1 = x1+x1

#parametros
epocas = 100

#normalizacao
maxX1 = np.max(x1)
minX1 = np.min(x1)
maxY1 = np.max(y1)
minY1 = np.min(y1)
nX1 = n.normalize01(x1)
nY1 = n.normalize01(y1)

for i in range(len(nX1)):
    ds.addSample((nX1[i]),(nY1[i]))

nn = buildNetwork(ds.indim,30,ds.outdim, hiddenclass=TanhLayer, bias=True) 

trainer = BackpropTrainer(nn,ds,0.1,1)

for i in range(epocas):
    print(trainer.train())
    
#teste
    
valor = ([5.5])
nV = n.normalize4Test(valor,minX1,maxX1)

res = nn.activate(nV)

dRes = n.deNormalize4Test(res,valor,minY1,maxY1)
    


    