Include File.inc

.data
file BYTE "welcoming.txt",0
	buffer BYTE 5000 DUP(?)
	menu BYTE   "	How do you want to continue ?",0dh,0ah,0dh,0ah,0dh,0ah,
	  "	Press 1 For Student",0dh,0ah,0dh,0ah,0dh,0ah,
	  "	Press 2 For Faculty",0dh,0ah,0dh,0ah,0dh,0ah,
	  "	Press 0 to exit",0dh,0ah,0dh,0ah,0dh,0ah,
	  "	Enter your Choice-->",0dh,0ah,0dh,0ah,0dh,0ah,0
.code
PrintMainMenu PROC




mov eax,cyan+(black*16)
call settextcolor

mov edx,offset file
call openinputfile
mov edx,offset buffer
mov ecx,5000
call readfromfile
mov edx,offset buffer
call writestring
call closefile
call crlf
call crlf
	call CRLF
	call CRLF


mov eax,yellow+(black*16)
call settextcolor


	mov edx,offset menu
	call writeString
	call CRLF
	

	ret
printMainMenu ENDP
End