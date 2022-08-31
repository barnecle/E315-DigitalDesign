
cEMA.cpython-36m-arm-linux-gnueabihf.so: cEMA.c ema.c ema.h
	python3 setup.py build
	pip3 install -e . 

test.o: test.c ema.h ema.c
	gcc -Wall test.c ema.c -o test.o 

ctest: test.o 
	./test.o 

pytest: test.py cEMA.cpython-36m-arm-linux-gnueabihf.so
	python3 test.py

build:  cEMA.cpython-36m-arm-linux-gnueabihf.so

clean:
	rm -rf test.o *.so
	rm -rf build  *.egg-info dist
