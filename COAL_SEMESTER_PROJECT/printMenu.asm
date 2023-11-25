Include File.inc

.data
		menu byte "---------------------------------Welcome to University Managment System--------------------------------",0dh,0ah,
	  "Press 1 for Login",0dh,0ah,
	  "Press 2 for Register a new Student",0dh,0ah,
	  "Press 3 for Changing password",0dh,0ah,
	  "Press 4 for Courses description",0dh,0ah,
	  "Press 5 for Courses Schedule",0dh,0ah,
	  "Press 6 for viewing grades",0dh,0ah,
	  "Press 0 to exit",0dh,0ah,
	  "Enter your Choice: ",0
.code
PrintMenu PROC
	mov edx,offset menu
	call writeString
	call CRLF
	

	ret
printMenu ENDP
End