section .data
    hello db 'Hello, World!', 0xA  ; The message to print, ending with a newline

section .text
    global _start                   ; Entry point for the program

_start:
    ; Write the message to stdout
    mov eax, 4                      ; syscall number for sys_write
    mov ebx, 1                      ; file descriptor 1 is stdout
    mov ecx, hello                  ; pointer to the message
    mov edx, 13                     ; length of the message (including the newline)
    int 0x80                        ; call kernel

    ; Exit the program
    mov eax, 1                      ; syscall number for sys_exit
    xor ebx, ebx                    ; exit code 0
    int 0x80                        ; call kernel
