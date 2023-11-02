_print_func:
    pusha
    xor si, si
    xor ax, ax
__read_byte:
    mov al, [bx + si]
    cmp al, 0x00
    je __end_print

    mov ah, 0x0e
    int 0x10
    inc si
    jmp __read_byte

__end_print:
    mov al, 0x0d
    mov ah, 0x0e
    int 0x10

    mov al, 0x0a
    mov ah, 0x0e
    int 0x10

    popa
    ret