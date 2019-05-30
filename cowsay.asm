SECTION .data
    first   db      " __", 0h
    btop    db      "_", 0h
    bm1     db      0Ah, "< ", 0h
    bm2     db      " >", 0Ah, " --", 0h
    bbtm    db      "-", 0h
    cow     db      0Ah, "        \   ^__^", 0Ah, "         \  (oo)\_______", 0Ah, "            (__)\       )\/\", 0Ah, "                ||----w |", 0Ah, "                ||     ||", 0Ah, 0h


SECTION .text
    global _start

_start:
    pop     ecx
    pop     ecx
    pop     ecx
    mov     edx, ecx

    mov     eax, ecx
    call    slen
    mov     ecx, eax

    mov     eax, first
    call    sprint

    mov     eax, btop
    push    ecx
    call    rpt
    pop     ecx

    mov     eax, bm1
    call    sprint

    mov     eax, edx
    call    sprint

    mov     eax, bm2
    call    sprint

    mov     eax, bbtm
    call    rpt

    mov     eax, cow
    call    sprint

    mov     ebx, 0
    mov     eax, 1
    int     80h


rpt:
    call    sprint
    dec     ecx
    jnz     rpt
    ret


slen:
    push    ebx
    mov     ebx, eax

nextchar:
    inc     eax
    cmp     byte [eax], 0
    jnz     nextchar

    sub     eax, ebx
    pop     ebx
    ret


sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen

    mov     edx, eax
    pop     eax
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h

    mov     eax, ecx
    pop     ebx
    pop     ecx
    pop     edx
    ret
