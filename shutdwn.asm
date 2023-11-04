_shutdwn:
    pusha
    mov bp, sp
    ; Installation check, to see if APM is supported
    mov ah, 0x53
    mov al, 0x00
    xor bx, bx
    int 0x15
    jc __APM_error

    ; Disconnect from any APM interface
    mov ah, 0x53
    mov al, 0x04
    xor bx, bx
    int 0x15
    jc __disconnect_error
    jmp __no_error

__disconnect_error:
    cmp ah, 0x03
    jne __APM_error

__no_error:
    ; Connect to the real mode interface (0x01)
    mov ah, 0x53
    mov al, 0x01
    xor bx, bx
    int 0x15
    jc __APM_error

    ; Enable power management for all devices
    mov ah, 0x53
    mov al, 0x08
    mov bx, 0x0001
    mov cx, 0x0001
    int 0x15
    jc __APM_error

    ; Set the power state to off (0x03)
    mov ah, 0x53
    mov al, 0x07
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15
    jc __APM_error

__APM_success:
    mov ax, 0x0000
    jmp __end_shutdwn

__APM_error:
    mov ax, 0xffff
    jmp __end_shutdwn

__end_shutdwn:
    mov [bp + 18], ax
    popa
    ret