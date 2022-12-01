#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt


weights = np.array( [[1,2,3,4],[5,6,7,8],[9,10,11,12]], dtype=np.float32)
inputs = np.array([[0.1,0.2,0.3]], dtype=np.float32)

#
# how it's done with np's dot
#
outs = np.dot(inputs, weights)

print ("Weights (Shape):\n", weights.shape)
print ("Weights:\n", weights)
print ("Inputs:\n", inputs)
print ("Output:\n", outs)

#
# how its done in verilog's dot.sv
#
def dot(inputs,weights):
    outs = np.zeros(weights.shape[1], dtype=np.float32)
    for i in range(weights.shape[0]): # input length
        for j in range(weights.shape[1]): # output length
            outs[j] = outs[j] + weights[i][j] * inputs[i]
    return outs

# my results
print (dot(inputs[0],weights))
# reference results
print (outs[0])


import numpy as np
import struct

weights = np.array( [[1,2,3,4],[5,6,7,8],[9,10,11,12]], dtype=np.float32)
inputs = np.array([[0.1,0.2,0.3]], dtype=np.float32)
outs = np.dot(inputs, weights)
print ('='*80 + '\n Used in dot.sv \n' + '='*80)
print ('parameter ROWS = %d,' %weights.shape[0])
print ('parameter COLS = %d,' %weights.shape[1])
print ()
print ('parameter [31:0] weights [0:ROWS-1] [0:COLS-1] = \'{')
for i in range(weights.shape[0]):
    flts_hex = map( lambda x: '$shortrealtobits(' + str(x) + ')', weights[i])
    print ('\t\'{' + ','.join(flts_hex)  + '}', end='')
    print (',' if i < weights.shape[0]-1 else '')
print ('}')
    


# Used in tb_dot.sv 

print ('='*80 + '\n Used in dot_tb.sv \n' + '='*80)

import numpy as np

weights = np.array( [[1,2,3,4],[5,6,7,8],[9,10,11,12]], dtype=np.float32)
inputs = np.array([[0.1,0.2,0.3]], dtype=np.float32)
outs = np.dot(inputs, weights)

flts = inputs[0]
flts_bits = list(map( lambda x: '$shortrealtobits(' + str(x) + ')', flts))
offset=4
print ('static bit [31:0] fpHex [0:' + str(len(flts)-1) + '] = {')
for i in range(0, len(flts), offset):
    print (' ' + ', '.join(flts_bits[i:i+offset] ), end='')
    print (',' if i < len(flts) - offset else ' ')
print ('};') 
print ('static int MAX_SIZE = %d;' % len(flts))  


print ('='*80 + '\n Used in dot_tb.sv \n' + '='*80)

import numpy as np

weights = np.array( [[1,2,3,4],[5,6,7,8],[9,10,11,12]], dtype=np.float32)
inputs = np.array([[0.1,0.2,0.3]], dtype=np.float32)
outs = np.dot(inputs, weights)

flts = outs[0]
flts_bits = list(map( lambda x: '$shortrealtobits(' + str(x) + ')', flts))
offset=4
print ('static bit [31:0] fpHex [0:' + str(len(flts)-1) + '] = {')
for i in range(0, len(flts), offset):
    print (' ' + ', '.join(flts_bits[i:i+offset] ), end='')
    print (',' if i < len(flts) - offset else ' ')
print ('};') 
print ('static int MAX_SIZE = %d;' % len(flts)) 


