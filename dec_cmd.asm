_decode_cmd:
    pusha
    mov bp, sp

    mov si, bx
    mov di, gcls
    mov cx, 0x0003
    cld
    repe cmpsb
    je __cls_call

    mov si, bx
    mov di, gstart
    mov cx, 0x0005
    repe cmpsb
    je __start_call

    mov si, bx
    mov di, gshutdwn
    mov cx, 0x0007
    repe cmpsb
    je __shutdwn_call

    mov ax, 0xffff
    jmp __end_decode_cmd

__cls_call:
    mov ax, 0x0000
    jmp __end_decode_cmd

__start_call:
    mov ax, 0x0001
    jmp __end_decode_cmd

__shutdwn_call:
    mov ax, 0x0002
    
__end_decode_cmd:
    mov [bp + 18], ax
    std
    popa
    ret

gcls: db "cls", 0           ; cls command as string
gstart: db "start", 0       ; start command as string
gshutdwn: db "shutdwn", 0   ; shutdown command as string