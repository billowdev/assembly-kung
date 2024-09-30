section .data
    key db 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6
    state db 0x32, 0x88, 0x31, 0xe0, 0x43, 0x5a, 0x31, 0x37

    sbox db 0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5
          db 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76
          ; (Complete the S-Box for AES)

section .text
    global _start

_start:
    ; Apply SubBytes step
    mov ecx, 16         ; Number of bytes in state
    lea esi, [state]    ; Address of state array
    lea edi, [sbox]     ; Address of S-Box

sub_bytes:
    mov al, [esi]       ; Load byte from state
    mov bl, al          ; Copy to bl for indexing
    and bl, 0x0f       ; Mask for lower nibble
    mov dl, [edi + ebx] ; Get corresponding value from S-Box
    mov [esi], dl       ; Replace state byte
    inc esi             ; Move to the next byte
    loop sub_bytes      ; Repeat for all bytes

    ; Apply AddRoundKey step
    lea esi, [state]    ; Address of state array
    lea edi, [key]      ; Address of the key
    mov ecx, 16         ; Number of bytes in state

add_round_key:
    mov al, [esi]       ; Load byte from state
    xor al, [edi]       ; XOR with key byte
    mov [esi], al       ; Store the result back
    inc esi             ; Move to the next byte
    inc edi             ; Move to the next byte in key
    loop add_round_key  ; Repeat for all bytes

    ; Exit the program
    mov eax, 1          ; syscall: exit
    xor ebx, ebx        ; exit code 0
    int 0x80
