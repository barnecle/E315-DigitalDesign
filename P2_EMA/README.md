# P3_EMA


This project comes with a helper Python script.  We've provided a helper script
to automate several of the more complex tasks.  

To get started, please use this command (and specify with the correct Pynq IP): 

```
$ ./e315helper.py init --ip 192.168.2.99
```

You can update the Pynq's IP later with this:

```
$ ./e315helper.py setIp --ip 192.168.2.99
```

Once you've generated a bitstream and you're ready to upload it to the Pynq, run the following:

```
$ ./e315helper.py bitstream 
```

