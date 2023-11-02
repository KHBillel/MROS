_cls:
    pusha
    mov ah, 0x00
    mov al, 0x03 ; text mode 80x25 16 colours
    int 0x10
    popa
    ret