#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Sep 27 23:06:15 2018

@author: jeanmarioml
"""

import numpy as np

#PERCEPTRON DE UMA CAMADA
#1. CONSEGUE TRATAR BEM PROBLEMAS QUE SÃO
# LINEARMENTE SEPARÁVEIS EX: AND E OR. NÃO ADEQUADO PARA PROBLEMAS
#NÃO LINEARMENTE SEPARÁVEIS EX: XOR.


#PORTA AND --> LINEARMENTE SEPARAVEL
inputs = np.array([[0,0],[0,1],[1,0],[1,1]])
targets = np.array([0,0,0,1])

#PORTA OR --> LINEARMENTE SEPARAVEL
#inputs = np.array([[0,0],[0,1],[1,0],[1,1]])
#targets = np.array([0,1,1,1])

#PORTA XOR --> NÃO LINEARMENTE SEPARAVEL
#inputs = np.array([[0,0],[0,1],[1,0],[1,1]])
#targets = np.array([0,1,1,0])

weights = np.array([0.0,0.0])

learning_rate = 0.1

def stepFunction(_sum):
    if(_sum >= 1):
        return 1
    return 0

def calculateOuts(_inputs):
    #soma
    s = _inputs.dot(weights)
    return stepFunction(s)

def trein(): 
    eTotal = 1
    while (eTotal != 0):
        eTotal = 0
        for i in range(len(inputs)):
            s = calculateOuts(inputs[i])
            e = abs(targets[i] - s)
            eTotal += e
            for j in range(len(weights)):
                    weights[j] = weights[j] + (learning_rate * inputs[i,j] * e)
            print("Weights: %f e %f" % (weights[0],weights[1]))    
        print("Erro Total: %f" % e)
   

def treinMod():
    erroTotal = 1
    while (erroTotal != 0):
        erroTotal = 0
        for i in range(len(targets)):
            saidaCalc = calculateOuts(np.asarray(inputs[i]))
            erro = abs(targets[i] - saidaCalc)
            erroTotal += erro
            for j in range(len(weights)):
                weights[j] = weights[j] + (learning_rate * inputs[i][j] * erro)
                print("Peso atualizado: " + str(weights[j]))
        print('Erro Total: ' + str(erroTotal))
        
        
treinMod()
print('Rede Neural treinada!')
print(calculateOuts(inputs[0]))
print(calculateOuts(inputs[1]))
print(calculateOuts(inputs[2]))
print(calculateOuts(inputs[3]))

            

