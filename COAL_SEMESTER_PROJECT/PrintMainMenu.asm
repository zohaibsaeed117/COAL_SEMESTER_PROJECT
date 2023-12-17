Include File.inc

.data
		uni byte "---------------------------------Welcome to University Managment System--------------------------------",0dh,0ah,0
	menu BYTE   "	How do you want to continue",0dh,0ah,0dh,0ah,0dh,0ah,
	  "	Press 1 For Student",0dh,0ah,0dh,0ah,0dh,0ah,
	  "	Press 2 For Faculty",0dh,0ah,0dh,0ah,0dh,0ah,
	  "	Press 0 to exit",0dh,0ah,0dh,0ah,0dh,0ah,
	  "	Enter your Choice-->",0dh,0ah,0dh,0ah,0dh,0ah,0
.code
PrintMainMenu PROC




mov eax,cyan(black*16)
call settextcolor
	mov edx,offset uni
	call writeString
	call CRLF
	call CRLF

mov eax,yellow(black*16)
call settextcolor


	mov edx,offset menu
	call writeString
	call CRLF
	

	ret
printMainMenu ENDP
End