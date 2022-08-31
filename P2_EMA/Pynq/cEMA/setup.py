from distutils.core import setup, Extension

def main():
    setup(name="cEMA",
          version="0.0.1",
          description="Python interface for Exp.Mov.Avg.",
          author="<your name>",
          author_email="your_email@gmail.com",
          ext_modules=[Extension("cEMA", 
            ["cEMA.c","ema.c" ])])

if __name__ == "__main__":
    main()

