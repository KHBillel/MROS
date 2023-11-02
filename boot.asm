[bits 16]   ; We are still in 16 bit real mode
[org 0x7c00]  ; The BIOS loads the boot sector to memory location 0x7c00

    call _cls

    mov bx, msg
    call _print_func
    
    mov bx, auth
    call _print_func

    mov bx, cmd_buffer
    call _scan_input

    call _print_func
    hlt
    jmp $

%include 'scan.asm'
%include 'print.asm'
%include 'cls.asm'
msg: db "Bismillah", 0
auth: db "MROS by: BibalC", 0
cmd_buffer: times 256 - ( $ - $$ ) db 0 ; buffer of 256 zeros

times 510 -( $ - $$ ) db 0 ; Pad the boot sector out with zeros
dw 0xaa55 ; Last two bytes form the magic number ,
; so BIOS knows we are a boot sector.

