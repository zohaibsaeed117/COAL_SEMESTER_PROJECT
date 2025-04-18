Include File.inc
.data
	uni byte "		--------------------------------- WELCOME TO UNIVERSITY MANAGEMENT SYSTEM --------------------------------",0dh,0ah,0
	menu BYTE "Press 1 to Register a new Course",0dh,0ah,
	      "Press 2 for transport information",0dh,0ah,
		  "Press 3 for Cafetria information",0dh,0ah,
		  "Press 4 for course description",0dh,0ah,
		  "Press 5 for course schedule",0dh,0ah,
		  "Press 6 to view exam schedule",0dh,0ah,
		  "Press 7 to view grade system",0dh,0ah,
		  "Press 8 to view attendance system",0dh,0ah,
		  "Press 9 to view Result",0dh,0ah,
		  "Press 0 to exit",0dh,0ah,
		  "Enter your Choice: ",0
	  invalid BYTE "Invalid number entered!",13,10,0
	choice DWORD ?

.code

FacultyMenu PROC

call forcecls
call LoginFaculty
.IF eax==0
	jmp quit
.ENDIF

call forcecls

again:

call crlf
call crlf
mov eax,cyan+(black*16)    ;welcoming the user to university
call settextcolor
mov edx,offset uni
call writestring
call crlf
call crlf
call crlf

mov eax,yellow(black*16)    
call settextcolor
mov edx,offset menu
call writeString

call readDec
mov choice,eax
.IF choice==1
		call forcecls
		Invoke AddCourse
		call crlf
		call waitmsg
		call clrscr

.ELSEIF choice==2
		call forcecls
		INVOKE Transport
		call crlf
		call waitmsg
				call clrscr


.ELSEIF choice==3
		call forcecls
		INVOKE Cafeteria
		call crlf
		call waitmsg
				call clrscr


.ELSEIF choice==4
		call forcecls
        Invoke description
		call crlf
		call waitmsg
				call clrscr


.ELSEIF choice==5
		call forcecls
		 Invoke schedule
		 call crlf
		 call waitmsg
		 		call clrscr


.ELSEIF choice==6
	   	 call forcecls
		 Invoke examings
		 call crlf
		 call waitmsg

.ELSEIF choice==7
		call forcecls
	    Invoke gradest
		call crlf
		call waitmsg
				call clrscr


.ELSEIF choice==8
		call forcecls
		Invoke takeAttendance
        call crlf
		call waitmsg
				call clrscr

.ELSEIF choice==9
		call forcecls
		call showCourseResult
        call crlf
		call waitmsg
				call clrscr

.ELSEIF choice==0
		call clrscr
	    jmp quit
	
.ELSE
		call forcecls
		mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
				call clrscr

		jmp again
	.ENDIF

quit:
nop



ret
FacultyMenu ENDP
END