# Compiler and Flags
CC = gcc
CFLAGS = -fno-stack-protector -no-pie -g

# Directories
BIN_DIR = bin
SRC_DIR = src
SCRIPTS_DIR = scripts

# Targets
all: setup $(BIN_DIR)/keycard $(SCRIPTS_DIR)/exploit flag

# Create directories
setup:
	mkdir -p $(BIN_DIR)

# Compile the vulnerable program
$(BIN_DIR)/keycard: $(SRC_DIR)/keycard.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/keycard $(SRC_DIR)/keycard.c

# Compile the C exploit
$(SCRIPTS_DIR)/exploit: $(SCRIPTS_DIR)/exploit.c
	$(CC) -o $(SCRIPTS_DIR)/exploit $(SCRIPTS_DIR)/exploit.c

# Create the flag file
flag:
	echo "CTF{d34d_b33f_574ck_m4573r}" > flag.txt

# Clean up files
clean:
	rm -rf $(BIN_DIR) $(SCRIPTS_DIR)/exploit flag.txt payload.bin
