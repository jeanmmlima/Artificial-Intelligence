#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Oct 13 12:05:02 2018

@author: jeanmarioml
"""

import numpy as np

#MULTILAYER PERCEPTRON


#Fuções de Ativação

#Valores entre 0 e 1
def sigmoide(x):
    return 1 / (1 + np.exp(-x))

#derivada
def sigmoideDerivada(sig):
    return sig * (1-sig)

#Valores entre -1 e 1
def hyperbolicTang(x):
    return ((np.e - np.exp(-x))/(np.e + np.exp(-x)))

def getOuts(_inputs, _weight):
    soma = _inputs.dot(_weight)
    return sigmoide(soma)

#PORTA XOR --> NÃO LINEARMENTE SEPARAVEL
inputs = np.array([[0,0],[0,1],[1,0],[1,1]])
targets = np.array([[0],[1],[1],[0]])

#wIn = np.array([[-0.424,0.358],[-0.74,-0.577],[-0.961,-0.469]])
wIn = np.array([[-0.424, -0.74, -0.961],[0.358, -0.577, -0.469]])
wOut = np.array([[-0.017],[-0.893],[0.148]])

epochs = 100
learning_rate = 0.3
momentum = 1

for j in range(epochs):
    InLayer = inputs
    sumSinapse0 = np.dot(InLayer, wIn)
    HiddenLayer = sigmoide(sumSinapse0)
    sumSinapse1 = np.dot(HiddenLayer, wOut)
    OutLayer = sigmoide(sumSinapse1)
    
    error = targets - OutLayer
    meanError = np.mean(error)
    meanAbs = np.mean(np.abs(error))
    
    ##Calculo do delta - Saida
    
    deltaOut = error * sigmoideDerivada(OutLayer)
    
    ##Calculo delta - Hidden Layer
    # DELTA HL = pesos * Delta da Saída * Derivada da Sigmoide.
    
    wOutT = wOut.T
    deltaOutxPesos = deltaOut.dot(wOutT)
    deltaHL =  deltaOutxPesos * sigmoideDerivada(HiddenLayer)
    
    # BACKPROP
    
    ## peso (n+1) = (peso(n) * momento) + (entrada * delta * taxaAprendizagem)
    
    
    
    





#feedforward
