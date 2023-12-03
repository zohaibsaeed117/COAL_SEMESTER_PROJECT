Include File.inc

.data
		menu byte "-------Welcome to University Managment System--------",0dh,0ah,
	  "Press 1 for Login",0dh,0ah,
	  "Press 2 for Register a new Student",0dh,0ah,
	  "Press 3 for Changing password",0dh,0ah,
	  "Press 4 for Courses description",0dh,0ah,
	  "Press 5 for Courses Schedule",0dh,0ah,
	  "Press 6 for viewing grades",0dh,0ah,0
	Next BYTE "Press 7 for viewing Exam schedule",0dh,0ah,
	  "Press 8 for viewing Transport",0dh,0ah,
	  "Press 9 for viewing Cafe",0dh,0ah,
	  "Press 0 to exit",0dh,0ah,0
mice BYTE "Enter your Choice: ",0
.code
PrintMenu PROC
	mov edx,offset menu
	call writeString
	mov edx,offset Next
	call writeString
	mov edx,offset mice
	call writestring

	call CRLF
	

	ret
printMenu ENDP
End