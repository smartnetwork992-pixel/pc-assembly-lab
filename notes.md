# 🧪 PC Assembly Lab – Debugging & Binary Analysis Notes

## GDB Memory Examination (`x` command)

### Syntax
x/<count><format> <address>

### Parameters
- count → number of units to display
- format → how the data is displayed

### Formats
- x → hexadecimal
- s → string (used without size)
- d → signed decimal
- u → unsigned decimal
- o → octal
- t → binary
- c → character
- i → instruction (disassemble)
- a → address

### Examples
x/4x $esp
x/s 0x804a000
x/10i $eip

================================================================

## Memory Access

[var1]
→ get the value stored at the address  
→ returns the value of the given address  
→ example:  
mov eax, [var1]  
→ value of var1 is stored in EAX

var1
→ stores the address itself  
→ example:  
mov eax, var1  
→ address of var1 is stored in EAX

================================================================

## ELF Disassembly & Analysis

Disassemble the `.text` section using Intel syntax:
objdump -M intel -d -j .text index

Available sections:
- .text
- .data
- .bss

View all sections in the ELF file:
readelf -S index

Disassemble all sections:
objdump -d index

Note:
ELF is a Linux format used to organize machine code, data, and metadata.

================================================================

## What objdump Does

objdump is a binary analysis tool used to:

- Disassemble machine code (-d)
- Inspect ELF sections (-h)
- Dump raw section contents (-s -j <section>)
- List symbols (functions and variables) (-t)

Disassembly is the main use, but objdump also provides
deep inspection features for ELF binaries.

================================================================

## objdump vs objcopy

- objdump
  - Used for disassembly and analysis
  - Read-only (does NOT modify ELF files)

- objcopy
  - Used to modify ELF files
  - Can inject, remove, or edit sections

================================================================
