Include File.inc

.data
	uni byte "		--------------------------------- WELCOME TO UNIVERSITY MANAGEMENT SYSTEM --------------------------------",0dh,0ah,0
	  menu BYTE "Press 1 to register Course",0dh,0ah,
	  "Press 2 To genrate attendance report",0dh,0ah,
	  "Press 3 for Courses description",0dh,0ah,
	  "Press 4 for Courses Schedule",0dh,0ah,
	  "Press 5 for viewing Exam schedule",0dh,0ah,
	  "Press 6 to give exam",0dh,0ah,
	  "Press 7 to view result",0dh,0ah,
	  "Press 8 to book a room in hostel",0dh,0ah,
	  "Press 9 to change password",0dh,0ah,
	  "Press 0 to exit",0dh,0ah,
      "Enter your Choice: ",0
	  
	choice DWORD ?
	user student <>
	invalid BYTE "Invalid number entered!",13,10,0
	msg byte ".txt",0
	result byte 100 DUP(?)
	userName byte "zohaib-saeed",0
	stu student <>
	errmsg BYTE "File cannot be opened!",13,10,0


.code
 
studentchoices PROC,
studentId:PTR BYTE

call forcecls



again:
call crlf 
call crlf
mov eax,cyan(black*16)    ;welcoming the user to unversity
call settextcolor
mov edx,offset uni
call writestring
call crlf
call crlf

mov eax,yellow(black*16)    
call settextcolor

mov edx,offset menu
call writestring
call readdec
mov choice,eax

call forcecls

.IF choice==1
    call forcecls
	Invoke registerCourse,studentId
	call crlf
	call waitmsg
	call clrscr

.ELSEIF choice==2
	call forcecls
	Invoke GenerateAttendanceReport,studentid
	call crlf
	call waitmsg
	call clrscr

.ELSEIF choice==3
	call forcecls
    INVOKE studentdescription
	call crlf
	call waitmsg
	call clrscr

.ELSEIF choice==4
   call forcecls
   INVOKE stuschedule
   call crlf
   call waitmsg
	call clrscr

.ELSEIF choice==5
	call forcecls
    INVOKE examings
	call crlf
	call waitmsg
	call clrscr


.ELSEIF choice==6
	call forcecls
    INVOKE giveExam,studentId
	call crlf
    call waitmsg
	call clrscr

.ELSEIF choice==7
	call forcecls
    INVOKE showStudentResult,studentId
	call crlf
    call waitmsg
	call clrscr

.ELSEIF choice==8
	call forcecls
    INVOKE Hostel
	call crlf
    call waitmsg
	call clrscr

.ELSEIF choice==9
	call forcecls
	call changePassword
	call forcecls
	call waitmsg
	call clrscr

.ELSEIF choice==0
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
	cmp choice,0
	jne again
quit:

ret
studentchoices ENDP
End