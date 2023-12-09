INCLUDE File.inc

.data

buffersize DWORD ?
file BYTE "hostelrecord.txt",0
roomallow BYTe "A room has been allocated to you.",13,10,0
buffer BYTE 5000 DUP (?)
filehandle DWORD ?
bytesread DWORD 0
bytesWritten DWORD ?
newLine byte "!",13,10,0
id BYTE 20 DUP(?)
idmssg BYTE "Enter id:",0
len DWORD ?
errMsg byte "Unable to open File",13,10,0

.code

Hostel PROC

INVOKE createFile, ADDR file,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	  mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF

	mov edx,offset idmssg
	call writestring

	mov edx,offset id
	mov ecx,lengthof id
	call readstring
	mov len,eax

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset id, len,
		ADDR bytesWritten, 0				;writing the id of the user in the authentication file



		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0


		mov edx,offset roomallow
		call writestring

	quit:
	mov eax,filehandle
	call closefile

ret
Hostel ENDP
END