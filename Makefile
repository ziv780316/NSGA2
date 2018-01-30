#=================================================
# Makefile settings
#=================================================
-include dependency.mk # - do not abort if file does not exist

.INTERMEDIATE: create_dir # ignore this target dependency check

.PHONY: depend default all clean cscope # specify phony target, do not generate file as target name

.DEFAULT_GOAL=default # specify default target if there is no target specified

VPATH=include library bin unit_test # specify directory where to check target file update to date or not


#=================================================
# Compiler settings
#=================================================
CC       = gcc
CXX      = g++
LINKER   = ${CC}
CFLAGS   = -O3 -Wfatal-errors -Wall -std=gnu99 -pthread ${DEFINES} -fPIC
CXXFLAGS = -O3 -Wfatal-errors -Wall -std=gnu99 -pthread ${DEFINES} -fPIC
LIBS     = -lm
INCLUDE  = -I./include
MOVE     = mv -f

#=================================================
# Build target
#=================================================
BIN_DIR          = bin
UNIT_TEST_DIR    = unit_test
LIBRARY_DIR      = library
NSGA2_OBJ        = random.o mt19937.o main.o
UNIT_TEST_OBJ    = unit_test_random.o random.o mt19937.o
SO_TARGET        =
NSGA2_TARGET     = nsga2
UNIT_TEST_TARGET = unit_test_random

#=================================================
# Compile implicit rules
#=================================================
%.o:%.c
	$(CC) -c $< -o $@ $(CFLAGS) $(INCLUDE)
	@$(MOVE) $@ $(LIBRARY_DIR) # @ means do not echo command

%.e:%.c
	$(CC) -E $< -o $@ $(CFLAGS) $(INCLUDE)
	@$(MOVE) $@ $(LIBRARY_DIR)

%.so:%.c
	$(CC) -c $< -o $@ -shared $(CFLAGS) $(INCLUDE)
	@$(MOVE) $@ $(LIBRARY_DIR)

%.o:%.cxx
	$(CXX) -c $< -o $@ $(CXXFLAGS) $(INCLUDE)
	@$(MOVE) $@ $(LIBRARY_DIR)

%.e:%.cxx
	$(CXX) -E $< -o $@ $(CXXFLAGS) $(INCLUDE)
	@$(MOVE) $@ $(LIBRARY_DIR)

%.so:%.cxx
	$(CXX) -c $< -o $@ -shared $(CXXFLAGS) $(INCLUDE)
	@$(MOVE) $@ $(LIBRARY_DIR)

#=================================================
# Target rules
#=================================================
default: $(NSGA2_TARGET) $(SO_TARGET) 

create_dir:
	@mkdir -p $(LIBRARY_DIR) $(BIN_DIR) $(UNIT_TEST_DIR)

all: $(NSGA2_TARGET) $(SO_TARGET) $(UNIT_TEST_TARGET)

$(NSGA2_TARGET): create_dir $(NSGA2_OBJ)
	cd $(LIBRARY_DIR);\
	$(LINKER) -o $@ $(NSGA2_OBJ) $(LIBS);\
	$(MOVE) $@ ../$(BIN_DIR)

$(UNIT_TEST_TARGET): create_dir $(UNIT_TEST_OBJ)
	cd $(LIBRARY_DIR);\
	$(LINKER) -o $@ $(UNIT_TEST_OBJ) $(LIBS);\
	$(MOVE) $@ ../$(UNIT_TEST_DIR)

clean:
	rm -f dependency.mk
	rm -rf $(LIBRARY_DIR)/*

depend:
	rm -f dependency.mk
	for file in $(shell find . -name "*.c" -o -name "*.cxx" -o -name "*.h" -o -name "*.hxx"); do $(CC) -M $(INCLUDE) $$file >> dependency.mk; done

cscope:
	find . -name "*.c" -o -name "*.cxx" -o -name "*.h" -o -name "*.hxx" > cscope.files
	cscope -Rbq -i cscope.files
