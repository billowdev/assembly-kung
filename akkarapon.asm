section .data
    msg db 'Akkarapon Phikulsri', 0xA  ; The message with a newline character
    len equ $ - msg                     ; Length of the message

section .text
    global _start                       ; Entry point for the program

_start:
    ; Write the message to stdout
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, msg                        ; pointer to the message
    mov edx, len                        ; length of the message
    int 0x80                            ; call kernel

    ; Exit the program
    mov eax, 1                          ; syscall number for sys_exit
    xor ebx, ebx                        ; exit code 0
    int 0x80                            ; call kernel
