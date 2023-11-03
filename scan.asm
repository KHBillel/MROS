_scan_input:
    pusha
    xor si, si
__scan_byte:
    mov ah, 0x00 ; BIOS function to read a key
    int 0x16 ; Call BIOS interrupt

    cmp al, 0x0d
    je __end_input
    
    cmp al, 0x08
    jne __print_s_char

    cmp si, 0x0000
    je __scan_byte

    mov ah, 0x0e
    int 0x10

    mov al, 0x00
    mov ah, 0x0e
    int 0x10

    mov al, 0x08
    dec si
    mov ah, 0x0e
    int 0x10
    jmp __scan_byte

__print_s_char:
    mov ah, 0x0e
    int 0x10
    mov [bx + si], al ; Store the character at address stored in bx + si in al
    inc si ; si++
    jmp __scan_byte
    
__end_input:
    mov ah, 0x0e
    int 0x10

    mov al, 0x0a
    mov ah, 0x0e
    int 0x10

    mov al, 0x00
    mov byte [bx + si], al
    popa
    ret