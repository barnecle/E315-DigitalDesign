import cEMA
import sys

x = [2000, 2370, 1537, 2995, 1297, 3308, 1416, 3234, 1892, 2845]
expect_y1= [1250, 1529, 1530, 1895, 1744, 2135, 1954, 2273, 2177, 2343]
expect_y3= [1015, 1054, 1106, 1184, 1263, 1360, 1452, 1555, 1650, 1747]

y3 = []

print("Input X:", x)

print("\nComputing Simple EMA (Y1) (one-by-one)")
y1 = []
cEMA.reset()
for v in x:
    y1.append( cEMA.ema(v))
    
print("\nSimple EMA (Y1): ", y1) 


print("\nChecking Simple EMA (Y1): ", end="")
for i in range(len(y1)):
    if y1[i] != expect_y1[i]:
        print(f"FAILED!\n\tFound Mismatch at Index: {i}")
        print(f"\tExpected: {expect_y1[i]}")
        print(f"\tFound: {y1[i]}")
        sys.exit(-1)
print ("PASSED!")

print("\nComputing Simple EMA (Y1) (list)")
y1 = cEMA.ema_all(x)
    
print("\nSimple EMA (Y1): ", y1) 

print("\nChecking Simple EMA (Y1): ", end="")
for i in range(len(y1)):
    if y1[i] != expect_y1[i]:
        print(f"FAILED!\n\tFound Mismatch at Index: {i}")
        print(f"\tExpected: {expect_y1[i]}")
        print(f"\tFound: {y1[i]}")
        sys.exit(-1)
print ("PASSED!")

print("\nCompute Triple EMA (Y3)")
# run ema two more times on the results
y2 = cEMA.ema_all(y1)
y3 = cEMA.ema_all(y2)

print("\nTriple EMA (Y3): ", y3) 

print("\nChecking Triple EMA (Y3): ", end="")
for i in range(len(y3)):
    if y3[i] != expect_y3[i]:
        print(f"FAILED!\n\tFound Mismatch at Index: {i}")
        print(f"\tExpected: {expect_y3[i]}")
        print(f"\tFound: {y3[i]}")
        exit(1);
        sys.exit(-1)
print("PASSED!")



