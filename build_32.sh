#!/bin/sh


# files required
 #1) asm_io.inc & asm_io.asm
 #2) cdecl.h & driver.c 
############
RUN_AFTER_BUILD=1

# handle optional -d flag
if [ "$1" = "-d" ]; then
    RUN_AFTER_BUILD=0
    shift
fi

# check argument
if [ -z "$1" ]; then
    echo "Usage: ./build_32.sh [-d] <file_without_extension>"
    exit 1
fi

ARG1="$1"

# assemble asm_io
nasm -f elf32 -d ELF_TYPE asm_io.asm -o asm_io.o || exit 1

# assemble target file
nasm -f elf32 "$ARG1.asm" -o "$ARG1.o" || exit 1

# compile C driver
gcc -m32 -c driver.c -o driver.o || exit 1

# link (IMPORTANT: disable PIE)
#gcc -m32 -no-pie -o "$ARG1" driver.o "$ARG1.o" asm_io.o || exit 1
gcc -m32 -no-pie -Wl,-z,noexecstack -o "$ARG1" driver.o "$ARG1.o" asm_io.o || exit 1
# cleanup unwanted objects
rm -f asm_io.o driver.o "$ARG1.o"

echo "[+] Build finished: $ARG1"

# run by default unless disabled
if [ "$RUN_AFTER_BUILD" -eq 1 ]; then
    echo "[+] Running ./$ARG1"
    echo "---------------------"
    ./"$ARG1"
fi
