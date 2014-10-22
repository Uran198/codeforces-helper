GCC = g++
FLAGS = -Wall -Wextra -ggdb
BIN = res
all: ${BIN}
	
${BIN}: main.cpp
	${GCC} ${FLAGS} $^ -o ${BIN}
run: ${BIN}
	# UGLY
	@ruby ../../lib/run_tests.rb $^ $(CURDIR)
%.o: %.cpp 
	${GCC} ${FLAGS} -c $^
clean:
	-rm ${BIN}
	-rm *.o
.PHONY: all run clean
