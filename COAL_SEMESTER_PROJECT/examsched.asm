INCLUDE File.inc

.data

buffersize=50000
comps BYTE "compexam.txt",0
boys BYTE "bioexam.txt",0
chems BYTE "chemexam.txt",0
elecs BYTE "elecexam.txt",0
buffer BYTE buffersize DUP (?)
filehandle DWORD ?
errorMsg BYTE "File cannot be opened!",0dh,0ah,0
comp BYTE "1. Computer Science",13,10
 BYTE "2. Electrical Engineering",13,10
 BYTE "3. Biomedical Engineering",13,10
 BYTE "4. Chemical Engineering",13,10
 BYTE "Enter your choice : ",0
invalid BYTE "Invalid number entered!",13,10,0

.code

examings PROC 

mov edx,offset comp
call writestring
call readdec

.IF eax==1

mov eax,cyan+(black * 16)
call settextcolor

mov edx,offset comps
call openinputfile
mov filehandle,eax

.IF eax == INVALID_HANDLE_VALUE              ;invalid file-handle
	  mov edx,OFFSET errorMsg		
	  call WriteString
	  jmp  quit
	.ENDIF

mov edx,offset buffer
mov ecx,lengthof buffer
call readfromfile
mov edx,offset buffer
call writestring
mov eax,filehandle
call closefile
jmp quit

.ELSEIF eax==2

mov eax,lightgreen+(black * 16)
call settextcolor

mov edx,offset elecs
call openinputfile
mov filehandle,eax

.IF eax == INVALID_HANDLE_VALUE              ;invalid file-handle
	  mov edx,OFFSET errorMsg		
	  call WriteString
	  jmp  quit
	.ENDIF

mov edx,offset buffer
mov ecx,lengthof buffer
call readfromfile
mov edx,offset buffer
call writestring
mov eax,filehandle
call closefile
jmp quit

.ELSEIF eax==3

mov eax,lightgreen+(black * 16)
call settextcolor

mov edx,offset boys
call openinputfile
mov filehandle,eax

.IF eax == INVALID_HANDLE_VALUE              ;invalid file-handle
	  mov edx,OFFSET errorMsg		
	  call WriteString
	  jmp  quit
	.ENDIF

mov edx,offset buffer
mov ecx,lengthof buffer
call readfromfile
mov edx,offset buffer
call writestring
mov eax,filehandle
call closefile

.ELSEIF eax==4

mov eax,lightgreen+(black * 16)
call settextcolor

mov edx,offset chems
call openinputfile
mov filehandle,eax

.IF eax == INVALID_HANDLE_VALUE              ;invalid file-handle
	  mov edx,OFFSET errorMsg		
	  call WriteString
	  jmp  quit
	.ENDIF

mov edx,offset buffer
mov ecx,lengthof buffer
call readfromfile
mov edx,offset buffer
call writestring
mov eax,filehandle
call closefile

.ELSE 

mov eax,red+(black * 16)
call settextcolor
mov edx,offset invalid
call writestring

.ENDIF

quit:
mov eax,white+(black * 16)
call settextcolor

nop 

ret
examings ENDP

END