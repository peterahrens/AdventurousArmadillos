#VER=SEQ
#VER=OpenMP
#VER=MPIOpenMP
#VER=OpenACC
#VER=ComplexClass

#MODE=PROF
#MODE=RUN

#Sequential version
ifeq ($(VER), SEQ)
    EXE = gppKerSeq.ex
    SRC = gppKerSeq.cpp 
    CXXFLAGS+=-O3
endif

#OpenMP3.5 version
ifeq ($(VER), OpenMP)
    CXXFLAGS+=-fopenmp -Ofast
    LINKFLAGS+=-fopenmp
    EXE = gppOpenMP3.ex
    SRC = gppOpenMP3.cpp 
endif

#MPI version
ifeq ($(VER), MPIOpenMP)
    EXE = gppMPIOpenMP.ex
    SRC = gppMPIOpenMP3.cpp 
    CXXFLAGS+=-O3
endif

#Complex class + gpp version
ifeq ($(VER), OpenACC)
    EXE = gppOpenACC.ex
    SRC = gppOpenACC.cpp 
    CXXFLAGS+=-O3
endif

#Complex class + gpp version
ifeq ($(VER), ComplexClass)
    EXE = gppComplex.ex
    SRC = gppComplex.cpp 
    CXXFLAGS+=-O3
endif

CXX = CC
LINK = ${CXX}
#CXXFLAGS += -Wa,-adhln -g

ifeq ($(VER), OpenACC)
    CXXFLAGS+=-h pragma=acc
endif

#Profile
ifeq ($(MODE), PROF)
    CXX = scorep-CC
    CXXFLAGS+=-g
endif

OBJ = $(SRC:.cpp=.o)

$(EXE): $(OBJ)
	$(CXX) $(OBJ) -o $(EXE) $(LINKFLAGS)

$(OBJ): $(SRC)
	$(CXX) -c $(SRC) $(CXXFLAGS)

clean: 
	rm -f $(OBJ) $(EXE)

