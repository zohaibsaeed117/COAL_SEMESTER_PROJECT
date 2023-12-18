Include file.inc
.code
ForceCLS  PROC
    PUSH ECX
        mov dl,0
        mov dh,0
        call gotoxy
        mov ecx,50
        NewLine:
            PUSH ECX
                mov ecx,115
                BLANKS:
                       MOV EAX, " "
                       CALL  WriteChar
                    Loop BLANKS
            POP  ECX
            call CRLF
            Loop NewLine
    POP  ECX

    mov dl,0
        mov dh,0
        call gotoxy
    RET
ForceCLS ENDP
END