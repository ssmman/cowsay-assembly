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
    cmp     ecx, 0
    je      done
    jmp     rpt
    
done:                       ; end of repeat
    ret                     ; if we repeated everything just return back

    
slen:                       ; string length calculating function
    push    ebx             ; save the value in ebx to the stack for later
    mov     ebx, eax        ; move the value at eax into ebx
    
nextchar:
    cmp     byte [eax], 0   ; compare byte at eax with 0 (end of string)
    jz      finished        ; if we are at zero jump to finished
    inc     eax             ; move one byte over in eax (only if we arent at 0 yet)
    jmp     nextchar        ; jump back to nextchar
    
finished:
    sub     eax, ebx        ; subtract ebx from eax
    pop     ebx             ; restore ebx from the stack
    ret                     ; return back to where the function was called initially
    
    
sprint:                     ; string printing function
    push    edx             ; push all the registers to the stack
    push    ecx
    push    ebx
    push    eax
    call    slen            ; time to get the length of the string
    
    mov     edx, eax        ; move the length into edx
    pop     eax             ; restore eax
    mov     ecx, eax        ; move the string into ecx
    mov     ebx, 1          ; STDOUT
    mov     eax, 4          ; sys_write (4)
    int     80h             ; call the kernel
    
    mov     eax, ecx
    pop     ebx             ; restore all registers from the stack
    pop     ecx
    pop     edx
    ret                     ; return
