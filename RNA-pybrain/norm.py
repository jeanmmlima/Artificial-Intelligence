#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 18 15:27:53 2018

@author: jean
"""

import numpy as np

#normalizacao entre 0 e 1
def normalize01(v):
    minVal = np.min(v)
    maxVal = np.max(v)
    normalizedData = (v - minVal) / (maxVal - minVal)
    return normalizedData

#minV e maxV do conjunto de treinamento
def normalize4Test(v,minV,maxV):
    normalizedData = (v - minV) / (maxV - minV)
    return normalizedData

#DesNormalizacao entre 0 e 1
def deNormalize01(nV,v):
    minVal = np.min(v)
    maxVal = np.max(v)
    deNormalizedData = minVal + nV * (maxVal - minVal)
    return deNormalizedData

#minV e maxV do conjunto de treinamento
def deNormalize4Test(nV,v,minV,maxV):
    deNormalizedData = minV + nV * (maxV - minV)
    return deNormalizedData

#Normalizacao enter -1 e 1
def normalize11(v):
    minVal = np.min(v)
    maxVal = np.max(v)
    normalizedData = (2 * (v - minVal) / (maxVal - minVal)) - 1
    return normalizedData

#DesNormalizacao entre -1 e 1
def deNormalize11(nV,v):
    minVal = np.min(v)
    maxVal = np.max(v)
    deNormalizedData = minVal + (nV * (maxVal - minVal))/2
    return deNormalizedData