#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Sep 23 15:04:34 2018

@author: jeanmarioml
"""

#Perceptron de UMA camada

inputs = [-1, 7, 5]
weights = [0.8, 0.1, 0]

def soma(_input, _weight):
    s = 0
    for i in range(3):
       # print(inputs[i])
       # print(weights[i])
       s += _input[i] * _weight[i]
    return s
        
        
s = soma(inputs,weights)

def stepFunction(_sum):
    if(_sum >= 1):
        return 1
    return 0

result = stepFunction(s)