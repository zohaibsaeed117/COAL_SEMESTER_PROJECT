INCLUDE File.inc

.code

gral PROC,
marks:DWORD

mov ebx,marks
.IF ebx==5
        mov al,'A'
        
.ELSEIF ebx==4
        mov al,'B'
        
.ELSEIF ebx==3
        mov al,'C'
        
.ELSEIF ebx==2
        mov al,'D'
        
.ELSEIF ebx==1
        mov al,'E'
        
.ELSEIF ebx==0
        mov al,'F'
     
.ENDIF

mov bl,al

ret
gral ENDP
END