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

print ('\n\n')

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

