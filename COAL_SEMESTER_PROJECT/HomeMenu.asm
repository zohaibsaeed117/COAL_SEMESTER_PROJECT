Include File.inc

.data
	menu byte "---------------------------------Welcome to University Managment System--------------------------------",0dh,0ah,
	  "Press 1 for Login",0dh,0ah,
	  "Press 2 for Register a new Student",0dh,0ah,
	  "Press 3 for changing password",0dh,0ah,
	  "Enter your Choice: ",0
.code
homeMenu PROC
	mov edx,offset menu
	call writeString
	call CRLF

	ret
homeMenu ENDP
END