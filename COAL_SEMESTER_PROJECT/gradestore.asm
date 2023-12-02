INCLUDE File.inc

.data

buffersize=50000
compg BYTE "gradecomp.txt",0
electrig BYTE "elecg.txt",0
biolog BYTE "biog.txt",0
chemicalg BYTE "chemg,txt",0
buffer BYTE buffersize DUP(?)
filehandle dd ?
errorMsg BYTE "File cannot be opened!",0dh,0ah,0
comp BYTE "1. Computer Science",13,10
 BYTE "2. Electrical Engineering",13,10
 BYTE "3. Biomedical Engineering",13,10
 BYTE "4. Chemical Engineering",13,10
 BYTE "Enter your choice : ",0
invalid BYTE "Invalid number entered!",13,10,0
more BYTE "Do you want to add anyother thing?",13,10,
           "Press 1 for yes and 0 for no : ",0
lala BYTE 500 DUP(?)
len DWORD ?
bytesWritten DWORD ?
bytesRead DWORD 0

.code

gradest PROC 

mov edx,offset comp
call writestring
call readdec

.IF eax==1

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR compg,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

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

call crlf

mov edx,offset more
call writestring
call readdec

.IF eax==1

mov edx,offset lala
	mov ecx,500
    call readstring
   mov len,eax

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

   INVOKE WriteFile,
	filehandle,offset lala,len,
	ADDR bytesWritten, 0	
	mov eax,filehandle
call closefile
jmp quit

.ENDIF

mov eax,filehandle
call closefile
jmp quit

.ELSEIF eax==2

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR electrig,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

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

call crlf

mov edx,offset more
call writestring
call readdec

.IF eax==1

mov edx,offset lala
	mov ecx,500
    call readstring
   mov len,eax

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

   INVOKE WriteFile,
	filehandle,offset lala,len,
	ADDR bytesWritten, 0	
	mov eax,filehandle
call closefile
jmp quit

.ENDIF

mov eax,filehandle
call closefile
jmp quit

.ELSEIF eax==3

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR biolog,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

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

call crlf

mov edx,offset more
call writestring
call readdec

.IF eax==1

mov edx,offset lala
	mov ecx,500
    call readstring
   mov len,eax

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

   INVOKE WriteFile,
	filehandle,offset lala,len,
	ADDR bytesWritten, 0	
	mov eax,filehandle
call closefile
jmp quit
.ENDIF

mov eax,filehandle
call closefile

.ELSEIF eax==4

mov eax,cyan+(black * 16)
call settextcolor

INVOKE createFile, ADDR chemicalg,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

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

call crlf

mov edx,offset more
call writestring
call readdec

.IF eax==1

mov edx,offset lala
	mov ecx,500
    call readstring
   mov len,eax

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

   INVOKE WriteFile,
	filehandle,offset lala,len,
	ADDR bytesWritten, 0	
	mov eax,filehandle
call closefile
jmp quit
.ENDIF

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
gradest ENDP

END
