Include File.inc
.data

	uni byte "		--------------------------------- WELCOME TO UNIVERSITY MANAGEMENT SYSTEM --------------------------------",0dh,0ah,0
	menu byte 0dh,0ah,0dh,0ah,0dh,0ah,"	What do you want to do?",
	  0dh,0ah,0dh,0ah,0dh,0ah,"	Press 1 For Login",
	  0dh,0ah,0dh,0ah,0dh,0ah,"	Press 2 For Register a new Student",
	  0dh,0ah,0dh,0ah,0dh,0ah,"	Press 0 to exit",
	  0dh,0ah,0dh,0ah,0dh,0ah,"	Enter your Choice-->",0
.code
printLoginMenu Proc

mov eax,cyan+(black*16)    ;welcoming the user to university
call settextcolor
mov edx,offset uni
call writestring
call crlf
call crlf

mov eax,yellow+(black*16)    
call settextcolor
	mov edx,offset menu
	call writeString
ret
printLoginMenu ENDP
END