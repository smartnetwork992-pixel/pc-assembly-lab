#!/bin/sh

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

# assemble target file (32-bit)
nasm -f elf32 "$ARG1.asm" -o "$ARG1.o" || exit 1

# link using lld (32-bit ELF, no libc)
ld -m elf_i386 -o "$ARG1" "$ARG1.o" || exit 1

echo "[+] Build finished: $ARG1"

# run by default unless disabled
if [ "$RUN_AFTER_BUILD" -eq 1 ]; then
    echo "[+] Running ./$ARG1"
    echo "---------------------"
    ./"$ARG1"
fi
