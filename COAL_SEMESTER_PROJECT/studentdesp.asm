INCLUDE file.inc

.data

buffersize=50000
filehandle dd 0
compfile BYTE "comp.txt",0
buffer DWORD buffersize DUP(?)
elecfile BYTE "electrical.txt",0
biofile BYTE "biomedical.txt",0
chemfile BYTE "chemical.txt",0
selectcourse BYTE "Enter your choice : ",0
comp BYTE "1. Computer Science",13,10
 BYTE "2. Electrical Engineering",13,10
 BYTE "3. Biomedical Engineering",13,10
 BYTE "4. Chemical Engineering",13,10,0
invalid BYTE "Invalid number entered!",13,10,0
	errMsg byte "Unable to open File",0

bytesWritten DWORD ?
bytesRead DWORD 0



.code

studentdescription PROC

mov edx,offset comp
call writestring
mov edx,offset selectcourse
call writestring
call readdec
cmp eax,1								    	;input comparison
je cse										
cmp eax,2
je el
cmp eax,3
je bio
cmp eax,4
je chem
jmp quitn								    	;wrong user input jump

cse:                                         ;computer science description upto 8 semsters

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR compfile,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

mov filehandle,eax

.IF eax == INVALID_HANDLE_VALUE              ;invalid file-handle
	  mov  edx,OFFSET errMsg		
	  call WriteString
	  jmp  quit
	.ENDIF

mov edx,offset buffer
mov ecx,lengthof buffer
call readfromfile
mov edx,offset buffer
call writestring                          ; displaying file

mov eax,filehandle
call closefile
jmp quit

el:                                           ;Electrical engineering description upto 8 semsters

mov eax,cyan+(black * 16)      
call settextcolor

INVOKE createFile, ADDR elecfile,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

mov filehandle,eax			

	.IF eax == INVALID_HANDLE_VALUE          ;invalid file-handle
	  mov  edx,OFFSET errMsg		
	  call WriteString
	  jmp  quit
	.ENDIF

mov edx,offset buffer
mov ecx,lengthof buffer
call readfromfile
mov edx,offset buffer
call writestring                          ; displaying file

mov eax,filehandle
call closefile
jmp quit

bio:                                           ;biomedical engineering description upto 8 semsters

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR biofile,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

mov filehandle,eax

.IF eax == INVALID_HANDLE_VALUE					;invalid file-handle
	  mov  edx,OFFSET errMsg		
	  call WriteString
	  jmp  quit
	.ENDIF

mov edx,offset buffer
mov ecx,lengthof buffer
call readfromfile
mov edx,offset buffer
call writestring                          ; displaying file
 

mov eax,filehandle
call closefile
jmp quit

chem:                                        ;chemical enginering description upto 8 semsters

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR chemfile,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

mov filehandle,eax

.IF eax == INVALID_HANDLE_VALUE              ;invalid file-handle
	  mov  edx,OFFSET errMsg		
	  call WriteString
	  jmp  quit
	.ENDIF

mov edx,offset buffer
mov ecx,lengthof buffer
call readfromfile
mov edx,offset buffer
call writestring                 ; displaying file

mov eax,filehandle
call closefile
jmp quit

quitn:										;error mmeaasge if wrong number is entered

mov eax,red+(black * 16)
call settextcolor

mov edx,offset invalid
call writestring

quit:									   ;exit

mov eax,white+(black * 16)				   ;setting back to default color
call settextcolor

nop
ret 
studentdescription ENDP

END