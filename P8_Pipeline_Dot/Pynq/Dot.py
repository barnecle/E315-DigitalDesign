{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "%matplotlib inline\n",
    "import json\n",
    "import numpy as np\n",
    "import matplotlib.pyplot as plt\n",
    "import pandas as pd"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Inputs (Shape):\n",
      " (1, 3)\n",
      "Output (Shape):\n",
      " (1, 4)\n",
      "Weights (Shape):\n",
      " (3, 4)\n",
      "Inputs:\n",
      " [[0.1 0.2 0.3]]\n",
      "Weights:\n",
      " [[ 1.  2.  3.  4.]\n",
      " [ 5.  6.  7.  8.]\n",
      " [ 9. 10. 11. 12.]]\n",
      "Output:\n",
      " [[3.8000002 4.4       5.        5.6000004]]\n",
      "\n",
      "Input\t\t\t Weights\t\t\t  Output\n",
      "[0.1 0.2 0.3]    . \t [1. 2. 3. 4.] \t\t=  [3.8000002 4.4       5.        5.6000004]\n",
      "\t\t\t [5. 6. 7. 8.]\n",
      "\t\t\t [ 9. 10. 11. 12.]\n"
     ]
    }
   ],
   "source": [
    "weights = np.array( [[1,2,3,4],[5,6,7,8],[9,10,11,12]], dtype=np.float32)\n",
    "inputs = np.array([[0.1,0.2,0.3]], dtype=np.float32)\n",
    "outputs = np.dot(inputs, weights)\n",
    "\n",
    "print (\"Inputs (Shape):\\n\", inputs.shape)\n",
    "print (\"Output (Shape):\\n\", outputs.shape)\n",
    "print (\"Weights (Shape):\\n\", weights.shape)\n",
    "\n",
    "\n",
    "print (\"Inputs:\\n\", inputs)\n",
    "print (\"Weights:\\n\", weights)\n",
    "print (\"Output:\\n\", outputs)\n",
    "\n",
    "print ()\n",
    "print ('Input\\t\\t\\t Weights\\t\\t\\t  Output')\n",
    "print ( inputs[0], '   . \\t', weights[0], '\\t\\t= ', outputs[0])\n",
    "for i in range(1,3): print ('\\t\\t\\t', weights[i])\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[3.8000002 4.4       5.        5.6000004]\n",
      "[3.8000002 4.4       5.        5.6000004]\n"
     ]
    }
   ],
   "source": [
    "# how its done in dot.sv\n",
    "def pydot(inputs,weights):\n",
    "    inputs = inputs[0] # remove outer nesting\n",
    "    outs = np.zeros(weights.shape[1], dtype=np.float32)\n",
    "    for i in range(weights.shape[0]): # input length\n",
    "        for j in range(weights.shape[1]): # output length\n",
    "            outs[j] = outs[j] + weights[i][j] * inputs[i]\n",
    "    return outs\n",
    "\n",
    "# my results\n",
    "print (pydot(inputs,weights))\n",
    "# reference results\n",
    "print (np.dot(inputs, weights)[0])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "application/javascript": [
       "\n",
       "try {\n",
       "require(['notebook/js/codecell'], function(codecell) {\n",
       "  codecell.CodeCell.options_default.highlight_modes[\n",
       "      'magic_text/x-csrc'] = {'reg':[/^%%microblaze/]};\n",
       "  Jupyter.notebook.events.one('kernel_ready.Kernel', function(){\n",
       "      Jupyter.notebook.get_cells().map(function(cell){\n",
       "          if (cell.cell_type == 'code'){ cell.auto_highlight(); } }) ;\n",
       "  });\n",
       "});\n",
       "} catch (e) {};\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "application/javascript": [
       "\n",
       "try {\n",
       "require(['notebook/js/codecell'], function(codecell) {\n",
       "  codecell.CodeCell.options_default.highlight_modes[\n",
       "      'magic_text/x-csrc'] = {'reg':[/^%%pybind11/]};\n",
       "  Jupyter.notebook.events.one('kernel_ready.Kernel', function(){\n",
       "      Jupyter.notebook.get_cells().map(function(cell){\n",
       "          if (cell.cell_type == 'code'){ cell.auto_highlight(); } }) ;\n",
       "  });\n",
       "});\n",
       "} catch (e) {};\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "from pynq import Overlay\n",
    "from pynq import MMIO\n",
    "from pynq import allocate\n",
    "\n",
    "class HwDot():\n",
    "    def __init__(self, bitstream):\n",
    "        self.overlay = Overlay(bitstream)        \n",
    "        self.dma = self.overlay.axi_dma_0\n",
    "        \n",
    "        self.input_buffer = allocate(shape=(20,), dtype=np.float32)\n",
    "        self.output_buffer = allocate(shape=(10,), dtype=np.float32)\n",
    "        \n",
    "    def dot(self, inputs):\n",
    "        \n",
    "        np.copyto(self.input_buffer, inputs)\n",
    "            \n",
    "        self.dma.sendchannel.transfer(self.input_buffer)\n",
    "        self.dma.recvchannel.transfer(self.output_buffer)\n",
    "\n",
    "        self.dma.sendchannel.wait()\n",
    "        self.dma.recvchannel.wait()\n",
    "        \n",
    "        return self.output_buffer\n",
    "\n",
    "        "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[[-0.39490299 -0.45582341 -0.33740613 -0.46385369 -0.32445234  0.29448395\n",
      "   1.21528153 -0.15059742 -0.17037034 -0.13412056]]\n",
      "[-0.3949029  -0.4558233  -0.33740613 -0.4638537  -0.32445237  0.294484\n",
      "  1.2152815  -0.15059741 -0.17037027 -0.13412057]\n",
      "[True, True, True, True, True, True, True, True, True, True]\n",
      "Equal:  True\n"
     ]
    }
   ],
   "source": [
    "with open('weights.json') as f:\n",
    "    weights= np.array(json.load(f))\n",
    "with open('inputs.json') as f:\n",
    "    inputs= json.load(f)\n",
    "\n",
    "# software\n",
    "sw_outputs = np.dot( [inputs], weights)\n",
    "print (sw_outputs)\n",
    "\n",
    "unpipe_dot = HwDot('unpipelined.bit')\n",
    "\n",
    "unpipe_outputs = unpipe_dot.dot(inputs)\n",
    "print (unpipe_outputs)\n",
    "\n",
    "def approx_equal( v0, v1, error = 1E-6):\n",
    "    results = []\n",
    "    for (x, y) in zip (v0, v1):\n",
    "        if (abs(x-y) < error):  \n",
    "            results.append(True)\n",
    "        else: results.append(False)\n",
    "    return results\n",
    "\n",
    "equal = approx_equal(sw_outputs[0], unpipe_outputs)\n",
    "print (equal)\n",
    "\n",
    "print ('Equal: ', all(equal))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Py vs. Np: Equal:  True\n",
      "Np vs. Unpipe: Equal:  True\n",
      "\n",
      "Timing Python\n",
      "Total Time:15.018473377916962 seconds\n",
      "\n",
      "Timing Numpy\n",
      "Total Time:0.0773667530156672 seconds\n",
      "\n",
      "Timing Unpipelined Hardware\n",
      "Total Time:0.7320800370071083 seconds\n",
      "\n"
     ]
    }
   ],
   "source": [
    "import timeit as tt\n",
    "\n",
    "def py_test():  return pydot( [inputs], weights)\n",
    "    \n",
    "def np_test():  return np.dot( [inputs], weights)\n",
    "\n",
    "def unpipe_test(): return unpipe_dot.dot(inputs)\n",
    "    \n",
    "py_out = py_test()\n",
    "np_out = np_test()\n",
    "unpipe_out = unpipe_test()\n",
    "print (\"Py vs. Np: Equal: \", all(approx_equal(py_out, np_out[0])))\n",
    "print (\"Np vs. Unpipe: Equal: \", all(approx_equal(np_out[0], unpipe_out)))       \n",
    "print ()\n",
    "\n",
    "print(\"Timing Python\")\n",
    "time = tt.timeit(py_test, number=1000)\n",
    "print(\"Total Time:\" + str(time) + \" seconds\")\n",
    "print()\n",
    "\n",
    "print(\"Timing Numpy\")\n",
    "time = tt.timeit(np_test, number=1000)\n",
    "print(\"Total Time:\" + str(time) + \" seconds\")\n",
    "print()\n",
    "\n",
    "print(\"Timing Unpipelined Hardware\")\n",
    "time = tt.timeit(unpipe_test, number=1000)\n",
    "print(\"Total Time:\" + str(time) + \" seconds\")\n",
    "print()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Update your Bitstream with a Pipelined Dot, then run this block"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Pipe vs. UnPipe: Equal:  True\n",
      "Timing Pipelined Hardware\n",
      "Total Time:0.7323577431961894 seconds\n",
      "\n"
     ]
    }
   ],
   "source": [
    "import timeit as tt\n",
    "\n",
    "pipe_dot = HwDot('bitstream.bit')\n",
    "\n",
    "def pipe_test(): return pipe_dot.dot(inputs)\n",
    "\n",
    "pipe_out = pipe_test()\n",
    "print (\"Pipe vs. UnPipe: Equal: \", all(approx_equal(pipe_out, unpipe_out)))       \n",
    "    \n",
    "print(\"Timing Pipelined Hardware\")\n",
    "time = tt.timeit(pipe_test, number=1000)\n",
    "print(\"Total Time:\" + str(time) + \" seconds\")\n",
    "print()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.6.5"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 2
}
