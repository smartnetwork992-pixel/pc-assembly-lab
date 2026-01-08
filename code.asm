; %include "asm_io.inc"
 
%macro write_string 2 
   mov   eax, 4
   mov   ebx, 1
   mov   ecx, %1
   mov   edx, %2
   int   80h
%endmacro

%macro exit 0
   mov	eax,1       ;system call number (sys_exit)
   int	0x80        ;call kernel
%endmacro
 
%macro Integer 2  
   sub esp, 4   
   %define %1 [esp] ; this [] mean it will store the vaulue of esp address not the address and that a wrong i want to store the address how can we do that 
   mov dword %1, %2   
%endmacro

segment	.data 
   msg db "Hello World", 0xA,0
   num1 db 0xAF 
   msg_len equ $- msg  
segment .bss
   ; name resb 1 
segment	.text
   global _start    ;must be declared for linker (ld)

_start:             ;tell linker entry point
   
   ; []  means gives only the value and not the address to store it in regs
   
   mov eax, msg
   mov ebx , [eax]
   

   mov ebp,esp
 
  ; sub esp, 4

   ;mov esi, 0xF
   ;mov edi, 0xA
   ;call div
   
   ;mov eax, 8
   ;%define var1 [ebp-4]
   ;mov dword [ebp-4], eax
   
   Integer var1, 8

   Integer var2, 5
   
   mov dword var1, 0x2
   add dword var1, '0'

   ;  lea ecx, [ebp-4] is required because we need to store the address of ebp-4 in ecx and that will work fine with syscalls 
   lea ecx, var1
   write_string ecx, 4

   mov esp,ebp
  
   exit

;0x8049005

; int div()
; {
;   int a = 10;
;   int b = 20;
;   return a + b;
; }


div:
   push ebp
   mov ebp,esp

   sub esp, 0x8 ; allocate 8 byte

   mov dword [ebp-4], esi
   mov dword [ebp-8], edi

   mov eax, [ebp-4]
   sub eax, [ebp-8]

   mov esp,ebp
   pop ebp
   ret 

; int sum()
; {
;   int a = 10;
;   int b = 20;
;   int result = a + b;
;   return result;
; }

sum:
    ; function prologue
    push ebp
    mov  ebp, esp
    sub  esp, 12        ; reserve space for 3 local ints (3 × 4 bytes)

    ; layout of stack frame:
    ; [ebp-4]  = a
    ; [ebp-8]  = b
    ; [ebp-12] = result

    ; a = 10
    mov dword [ebp-4], 10

    ; b = 20
    mov dword [ebp-8], 20

    ; result = a + b
    mov eax, [ebp-4]    ; load a
    add eax, [ebp-8]    ; eax = a + b
    mov [ebp-12], eax   ; store result on stack

    ; return result
    mov eax, [ebp-12]   ; eax = result

    ; function epilogue
    mov esp, ebp
    pop ebp
    ret
 
mysum: 
   mov eax, esi
   add eax, edi 
   ret 
   ; eax = esi
   ; eax += edi 

