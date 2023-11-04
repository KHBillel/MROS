[bits 16]   ; We are still in 16 bit real mode
[org 0x7c00]  ; The BIOS loads the boot sector to memory location 0x7c00

    call _cls

    mov bx, msg
    call _println
    
    mov bx, auth
    call _println

cmd_loop:
    mov bx, prmpt_msg
    call _print

    mov bx, cmd_buffer
    call _scan_input

    xor ax, ax
    push ax           ; This 16bits zero pushed to the stack so we will use this stack item to return value 
    call _decode_cmd
    mov bx, sp
    mov ax, [bx]

    cmp ax, 0x0000
    je _ccls

    cmp ax, 0x0002
    je _cshutdwn

    cmp ax, 0xffff
    pop ax
    jne cmd_loop

    mov bx, cmd_error
    call _println
    jmp cmd_loop

_ccls:
    call _cls
    pop ax
    jmp cmd_loop

_cstart:
    ;call _start

_cshutdwn:
    xor ax, ax
    mov bx, sp
    mov [bx], ax

    call _shutdwn
    mov bx, sp
    mov ax, [bx]

    cmp ax, 0x0000
    je _no_shutdwn_errors   
    mov bx, shutdwn_error
    call _println

_no_shutdwn_errors:
    pop ax
    jmp cmd_loop


    hlt
    jmp $

%include 'scan.asm'
%include 'print.asm'
%include 'cls.asm'
%include 'dec_cmd.asm'
%include 'shutdwn.asm'
msg: db "Bismillah", 0
auth: db "MROS by: BibalC", 0x0d, 0x0a, 0
cmd_buffer: times 36 db 0 ; buffer of 36 zeros
prmpt_msg: db "MROS(RM)>",0
shutdwn_error: db "SHUTDOWN ERROR!",0
cmd_error: db "UNKNOWN CMD!",0

times 510 -( $ - $$ ) db 0 ; Pad the boot sector out with zeros
dw 0xaa55 ; Last two bytes form the magic number ,
; so BIOS knows we are a boot sector.

