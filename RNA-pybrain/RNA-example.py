#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 18 14:30:46 2018

@author: jean
"""

from pybrain.tools.shortcuts import buildNetwork
from pybrain.datasets import SupervisedDataSet
from pybrain.supervised.trainers import BackpropTrainer


import numpy as np

ds = SupervisedDataSet(1,1)

x1 = range(13)
x1 = np.array(x1)
y1 = x1*x1

for i in range(len(x1)):
    print (i)
    ds.addSample((x1[i]),(y1[i]))

#ds.addSample((0.0,0.0),(0.0))
#ds.addSample((1.0,0.0),(1.0))
#ds.addSample((2.0,0.0),(4.0))

#ds.addSample((0.5,0.7),(0.5))
#ds.addSample((1.0,0.8),(0.95))

nn = buildNetwork(ds.indim,3,ds.outdim, bias=True)

trainer = BackpropTrainer(nn,ds)

for i in range(2000):
    print(trainer.train())
    


    