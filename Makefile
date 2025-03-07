CC=g++
LINK=-L/opt/homebrew/opt/xerces-c/lib -lxerces-c -lm
FLAGS = -O3 -Wno-unused-result -std=c++11 -DBOOST_NO_CXX11_RVALUE_REFERENCES -DBOOST_TIMER_ENABLE_DEPRECATED -DBOOST_ALLOW_DEPRECATED_HEADERS -DBOOST_MATH_DISABLE_STD_FPCLASSIFY -DBOOST_OPTIONAL_USE_OLD_DEFINITION_OF_NONE -DBOOST_OPTIONAL_CONFIG_USE_OLD_IMPLEMENTATION_OF_OPTIONAL -DBOOST_NO_CXX11_ALLOCATOR -DBOOST_NO_AUTO_PTR -DBOOST_OPTIONAL_SUPPRESS_OPTIONAL_87_DEPRECATION -DBOOST_DISABLE_MATH_TOOLS_HEADER -DBOOST_OPTIONAL_DISABLE_REQUIRES_COMPILATION_ERROR -I./boost_override -I/usr/local/include -I/opt/homebrew/opt/xerces-c/include

OBJFEAS=symfeatures.o featureson.o online.o
OBJMUESTRA=sample.o stroke.o
OBJPARSE=seshat.o meparser.o gparser.o grammar.o production.o symrec.o duration.o segmentation.o sparel.o gmm.o
OBJTABLA=tablecyk.o cellcyk.o hypothesis.o logspace.o
OBJRNNLIB=Random.o DataExporter.o WeightContainer.o ClassificationLayer.o Layer.o Mdrnn.o Optimiser.o
RNNLIBHEADERS=rnnlib4seshat/DataSequence.hpp rnnlib4seshat/NetcdfDataset.hpp rnnlib4seshat/Mdrnn.hpp rnnlib4seshat/MultilayerNet.hpp rnnlib4seshat/Rprop.hpp rnnlib4seshat/SteepestDescent.hpp rnnlib4seshat/Trainer.hpp rnnlib4seshat/WeightContainer.hpp
OBJS=$(OBJFEAS) $(OBJMUESTRA) $(OBJPARSE) $(OBJTABLA) $(OBJRNNLIB)

seshat: $(OBJS)
	$(CC) -o seshat $(OBJS) $(FLAGS) $(LINK)

seshat.o: seshat.cc grammar.o sample.o meparser.o
	$(CC) -c seshat.cc $(FLAGS)

production.o: production.h production.cc symrec.o
	$(CC) -c production.cc $(FLAGS)

grammar.o: grammar.h grammar.cc production.o gparser.o symrec.o
	$(CC) -c grammar.cc $(FLAGS)

meparser.o: meparser.h meparser.cc grammar.o production.o symrec.o tablecyk.o cellcyk.o logspace.o duration.o segmentation.o sparel.o sample.o hypothesis.o
	$(CC) -c meparser.cc $(FLAGS)

gparser.o: gparser.h gparser.cc
	$(CC) -c gparser.cc $(FLAGS)

sample.o: sample.h sample.cc tablecyk.o cellcyk.o stroke.o grammar.o
	$(CC) -c sample.cc $(FLAGS)

symrec.o: symrec.h symrec.cc symfeatures.o $(RNNLIBHEADERS)
	$(CC) -c symrec.cc $(FLAGS)

duration.o: duration.h duration.cc symrec.o
	$(CC) -c duration.cc $(FLAGS)

segmentation.o: segmentation.h segmentation.cc cellcyk.o sample.o gmm.o
	$(CC) -c segmentation.cc $(FLAGS)

tablecyk.o: tablecyk.h tablecyk.cc cellcyk.o hypothesis.o
	$(CC) -c tablecyk.cc $(FLAGS)

cellcyk.o: cellcyk.h cellcyk.cc hypothesis.o
	$(CC) -c cellcyk.cc $(FLAGS)

hypothesis.o: hypothesis.h hypothesis.cc production.o grammar.o
	$(CC) -c hypothesis.cc $(FLAGS)

logspace.o: logspace.h logspace.cc cellcyk.o
	$(CC) -c logspace.cc $(FLAGS)

sparel.o: sparel.h sparel.cc hypothesis.o cellcyk.o gmm.o sample.o
	$(CC) -c sparel.cc $(FLAGS)

gmm.o: gmm.cc gmm.h
	$(CC) -c gmm.cc $(FLAGS)

stroke.o: stroke.cc stroke.h
	$(CC) -c stroke.cc $(FLAGS)

symfeatures.o: symfeatures.cc online.o featureson.o
	$(CC) -c symfeatures.cc $(FLAGS)

featureson.o: featureson.cc featureson.h online.o
	$(CC) -c featureson.cc $(FLAGS)

online.o: online.cc online.h
	$(CC) -c online.cc $(FLAGS)

#rnnlib4seshat
Random.o: rnnlib4seshat/Random.cpp
	$(CC) -c rnnlib4seshat/Random.cpp $(FLAGS)

DataExporter.o: rnnlib4seshat/DataExporter.cpp
	$(CC) -c rnnlib4seshat/DataExporter.cpp $(FLAGS)

WeightContainer.o: rnnlib4seshat/WeightContainer.cpp
	$(CC) -c rnnlib4seshat/WeightContainer.cpp $(FLAGS)

ClassificationLayer.o: rnnlib4seshat/ClassificationLayer.cpp
	$(CC) -c rnnlib4seshat/ClassificationLayer.cpp $(FLAGS)

Layer.o: rnnlib4seshat/Layer.cpp
	$(CC) -c rnnlib4seshat/Layer.cpp $(FLAGS)

Mdrnn.o: rnnlib4seshat/Mdrnn.cpp
	$(CC) -c rnnlib4seshat/Mdrnn.cpp $(FLAGS)

Optimiser.o: rnnlib4seshat/Optimiser.cpp
	$(CC) -c rnnlib4seshat/Optimiser.cpp $(FLAGS)

clean:
	rm -f *.o *~ \#*\#
