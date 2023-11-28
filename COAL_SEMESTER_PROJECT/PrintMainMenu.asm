Include File.inc

.data
		menu byte "---------------------------------Welcome to University Managment System--------------------------------",0dh,0ah,
	  0dh,0ah,0dh,0ah,0dh,0ah,"	How do you want to continue",
	  0dh,0ah,0dh,0ah,0dh,0ah,"	Press 1 For Student",
	  0dh,0ah,0dh,0ah,0dh,0ah,"	Press 2 For Faculty",
	  0dh,0ah,0dh,0ah,0dh,0ah,"	Enter your Choice-->",0
.code
PrintMainMenu PROC
	mov edx,offset menu
	call writeString
	call CRLF
	

	ret
printMainMenu ENDP
End