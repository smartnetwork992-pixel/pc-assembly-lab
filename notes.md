================================================================ 
x/<count><format> address

count -> count in bytes
format 
    x -> hexa
    s -> string # note: we use it without size 
    d -> signed decimal
    u -> unsigned decimal
    o -> octal
    t -> binary
    c -> character
    i -> instruction (disassemble)
    a -> address 
================================================================ 
Memory Access
================================================================ 
[var1] -> get the value of specifc address in the memory -> return the value of the given address => mov eax, [name] => store the value of name in eax
var1   -> store the address instead of getting the value => mov eax, name => address of the name will store in eax
================================================================ 
objdump -M intel -d -j .text index // this will give you  the disassembly instrction of index elf .
// -j can be [.text|.bss|.data]
// to check all functins used > readelf -S index // this will read elf file and extract from it all the sections of assembly
// > objdump -d index // this will show all the sections and disassemble it
// elf is organized by linux to organized machine code

1️⃣ What objdump does

objdump is primarily a binary analysis tool. Its main purpose is:

Disassemble machine code into assembly (-d)

Inspect sections (-h to list .text, .data, .bss, etc.)

Dump section contents (-s -j <section> shows raw bytes)

List symbols (-t shows function/variable names and addresses)

So yes, disassembly is the main use, but it also gives other inspection features.

note:
  objdumb is used to disassembly and anlyze elf code but objcopy is also command but here it update the elf file like injecting code into the sections etc..
================================================================

