# Sample Makefile for compiling Fortran programs using ARPREC library.
# Make sure the script arprec-config (installed during "make install") 
# is in your path.

# Fortran compiler.  Should be whatever  "arprec-config --fc"  returns.
FC=$(shell arprec-config --fc)

# C++ compiler.  Used for linking.
# Should be whatever  "arprec-config --cxx"  returns.
CXX=$(shell arprec-config --cxx)

# Fortran compiler flags.  Should be whatever  "arprec-config --fcflags"  
# returns, but some items (like optimization levels) # can be 
# tweaked if desired.
FCFLAGS=$(shell arprec-config --fcflags)

# Linker flags.  Includes the Quad-Double library and any Fortran
# libraries that needs to be linked in.  Should be whatever  
# "arprec-config --fclibs"  returns
FCLIBS=$(shell arprec-config --fclibs) $(shell arprec-config --fmainlib)

# Your main program.  Note that you main program should be declared
# as "subroutine f_main", not "program myprog", since the C++ linker
# must find the C++ main entry.
f_main: RungeKutta.o f_main.o
	$(CXX) -O3 $^ $(FCLIBS) -o $@

%.o: %.f90
	$(FC) -c $(FCFLAGS) $<