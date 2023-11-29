Include File.inc
.data
	menu byte "---------------------------------Welcome to University Managment System--------------------------------",0dh,0ah,
	  "Press 1 to Register a new Course",0dh,0ah,
	  "Press 0 to exit",0dh,0ah,
	  "Enter your Choice: ",0
	  invalid BYTE "Invalid number entered!",13,10,0
	choice DWORD ?
.code
FacultyMenu PROC
again:
	call Clrscr
	call LoginFaculty
	call CLRSCR

	;Here we will call the facultyMenu
	
	mov edx,offset menu
	call writeString

	call readDec
	mov choice,eax
	.IF choice==1
		Invoke AddCourse
	.ELSEIF choice==2
		jmp quit
	.ELSE
		mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
		jmp again
	.ENDIF

quit:
ret
FacultyMenu ENDP
END