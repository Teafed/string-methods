# Define directories
OBJ_DIR = ./obj
EXTERNAL_FUNCTIONS_DIR = ./external-functions

# List source files
SRCS = $(wildcard *.s)

# List object files
EXTERNAL_OBJS = $(wildcard $(EXTERNAL_FUNCTIONS_DIR)/*.o)

# Generate object files from source files
OBJS = $(patsubst %.s,$(OBJ_DIR)/%.o,$(SRCS))

# Pattern rule to assemble source files into object files
$(OBJ_DIR)/%.o: %.s
	as -g $< -o $@

# Rule to link object files into the driver executable
driver: $(OBJS) $(EXTERNAL_OBJS)
	ld -o driver /usr/lib/aarch64-linux-gnu/libc.so -dynamic-linker /lib/ld-linux-aarch64.so.1 $(OBJS) $(EXTERNAL_OBJS)

# Rule to clean up object files and executable
clean:
	rm -f $(OBJ_DIR)/*.o driver

.PHONY: clean
