#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 24 10:42:56 2019

@author: jeanmarioml
"""

import numpy as np

#importando a base de dados da machine learning repository

from sklearn import datasets




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

base = datasets.load_breast_cancer()

#vetores simples
inputs = base.data
vTargets = base.target

#transformar em inputs e targets em matrizes

targets = np.empty([569,1],dtype=int)
for i in range(569):
    targets[i] = vTargets[i]
    
    
neurons_hl = 10
epochs = 10000
learning_rate = 0.2
momentum = 1


wIn = 2*np.random.random((30,neurons_hl))-1
wOut = 2*np.random.random((neurons_hl,1))-1


for j in range(epochs):
    
    ##### FEED FORWARD ####
    
    InLayer = inputs
    sumSinapse0 = np.dot(InLayer, wIn)
    HiddenLayer = sigmoide(sumSinapse0)
    sumSinapse1 = np.dot(HiddenLayer, wOut)
    OutLayer = sigmoide(sumSinapse1)
    
    error = targets - OutLayer
    meanError = np.mean(error)
    meanAbs = np.mean(np.abs(error))
    print("Erro: "+str(meanAbs))
    
    ##Calculo do delta - Saida
    
    deltaOut = error * sigmoideDerivada(OutLayer)
    
    ##Calculo delta - Hidden Layer
    # DELTA HL = pesos * Delta da Saída * Derivada da Sigmoide.
    
    wOutT = wOut.T
    deltaOutxPesos = deltaOut.dot(wOutT)
    deltaHL =  deltaOutxPesos * sigmoideDerivada(HiddenLayer)
    
    #### BACKPROP #####
    
    ## peso (n+1) = (peso(n) * momento) + (entrada * delta * taxaAprendizagem)
    
    ## SAIDA -> CAMADA OCULTA
    
    
    HiddenLayerT = HiddenLayer.T
    nWOut = HiddenLayerT.dot(deltaOut)
    wOut = (wOut * momentum) + (nWOut * learning_rate)
    
    ## CAMADA OCULTA -> ENTRADA
    
    InLayerT = InLayer.T
    nWIn = InLayerT.dot(deltaHL)
    wIn = (wIn * momentum) + (nWIn * learning_rate)