#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Sep 23 15:20:51 2018

@author: jeanmarioml
"""

#Perceptron de UMA camada

import numpy as np

inputs = np.array([1, 7, 5])
weights = np.array([0.8, 0.1, 0])

def soma(_input, _weight):
    return _input.dot(_weight) #dot -> scalar product
        
        
s = soma(inputs,weights)

def stepFunction(_sum):
    if(_sum >= 1):
        return 1
    return 0

result = stepFunction(s)