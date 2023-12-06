Include File.inc
.data
	uni byte "---------------------------------Welcome to University Managment System--------------------------------",0dh,0ah,0
	menu BYTE "Press 1 to Register a new Course",0dh,0ah,
	      "Press 2 for transport information",0dh,0ah,
		  "Press 3 for Cafetria information",0dh,0ah,
		  "Press 4 for course description",0dh,0ah,
		  "Press 5 for course schedule",0dh,0ah,
		  "Press 6 to view exam schedule",0dh,0ah,
		  "Press 7 to view grade system",0dh,0ah,
		  "Press 8 to view attendance system",0dh,0ah,
		  "Enter your Choice: ",0
	  invalid BYTE "Invalid number entered!",13,10,0
	choice DWORD ?

.code

FacultyMenu PROC

call Clrscr
call LoginFaculty

call CLRSCR

again:

mov eax,cyan(black*16)    ;welcoming the user to unversity
call settextcolor
mov edx,offset uni
call writestring
call crlf
call crlf

	
mov edx,offset menu
call writeString

call readDec
mov choice,eax
.IF choice==1
		Invoke AddCourse
		call crlf
		call waitmsg

.ELSEIF choice==2
		INVOKE Transport
		call crlf
		call waitmsg

.ELSEIF choice==3
		INVOKE Cafeteria
		call crlf
		call waitmsg

.ELSEIF choice==4
        Invoke description
		call crlf
		call waitmsg

.ELSEIF choice==5
		 Invoke schedule
		 call crlf
		 call waitmsg

.ELSEIF choice==6
		 Invoke examings
		 call crlf
		 call waitmsg

.ELSEIF choice==7
	    Invoke gradest
		call crlf
		call waitmsg

.ELSEIF choice==8
		Invoke takeAttendance
        call crlf
		call waitmsg

	
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
nop

INVOKE main


ret
FacultyMenu ENDP
END