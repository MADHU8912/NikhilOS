[org 0x7c00]
[bits 16]

start:
    mov ah, 0x0e
    mov si, message

print_loop:
    lodsb
    cmp al, 0
    je halt
    int 0x10
    jmp print_loop

halt:
    jmp $

message db 'Welcome to Nikhil OS!', 0

times 510-($-$$) db 0
dw 0xaa55