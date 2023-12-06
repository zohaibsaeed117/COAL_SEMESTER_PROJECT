INCLUDE file.inc

.data
buffersize=50000
filehandle dd 0
buffer DWORD buffersize DUP(?)
scomp BYTE "compsched.txt",0
bios BYTE "bioschedule.txt",0
chems BYTE "chemsched.txt",0
elecs  BYTE "elecshed.txt",0
comp BYTE "1. Computer Science",13,10
 BYTE "2. Electrical Engineering",13,10
 BYTE "3. Biomedical Engineering",13,10
 BYTE "4. Chemical Engineering",13,10,0
invalid BYTE "Invalid number entered!",13,10,0
selectcourse BYTE "Enter your choice: ",0
	errMsg byte "Unable to open File",0
bytesWritten DWORD ?
bytesRead DWORD 0



.code

stuschedule PROC
mov edx,offset comp
call writestring
mov edx,offset selectcourse
call writestring
call readdec
cmp eax,1									    	;User input comparison
je cse
cmp eax,2
je el
cmp eax,3
je bio
cmp eax,4
je chem
jmp quitn											;wronguser input jump

cse:												;Computer sciene description

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR scomp,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

mov filehandle,eax

.IF eax == INVALID_HANDLE_VALUE						;invalid file-handle
	  mov  edx,OFFSET errMsg		
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
mov eax,white+(black * 16)
call settextcolor
jmp quit

el:												;Electrical department decription

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR elecs,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

mov filehandle,eax
.IF eax == INVALID_HANDLE_VALUE					;invalid fil-handle
	  mov  edx,OFFSET errMsg		
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

bio:										;Biomedical schedule

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR bios,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

mov filehandle,eax
.IF eax == INVALID_HANDLE_VALUE				;invalid file-handle
	  mov  edx,OFFSET errMsg		
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

chem:									;chemical engineering schedule

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR chems,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

mov filehandle,eax

.IF eax == INVALID_HANDLE_VALUE			   ;invalid file-handle
	  mov  edx,OFFSET errMsg		
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

quitn:										;wrong user input

mov eax,red+(black * 16)
call settextcolor

mov edx,offset invalid
call writestring

quit:										;exit

mov eax,white+(black * 16)					;setting back to default color
call settextcolor

nop

ret
stuschedule ENDP
END