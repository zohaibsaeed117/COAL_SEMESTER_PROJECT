Include File.inc

.data
	choice DWORD ?
	user student <>
	thanks byte "ThankYou for using University Management System",0
	invalid BYTE "Invalid number entered!",13,10,0
	msg byte ".txt",0
	result byte 100 DUP(?)
	userName byte "zohaib-saeed",0
	stu student <>



.code
 
studentchoices PROC,
studentId:PTR BYTE


again:

call forcecls
mov eax,cyan(black*16)    ;welcoming the user to unversity
call settextcolor
mwrite "------------------Welcome to University Managment System------------------"
call CRLF
call CRLF
call CRLF
mov eax,yellow(black*16)    
call settextcolor

mWrite "	Press 1 to register Course"
call CRLF
call CRLF
mWrite "	Press 2 To genrate attendance report"
call CRLF
call CRLF
mWrite "	Press 3 for Courses description"
call CRLF
call CRLF
mWrite "	Press 4 for Courses Schedule"
call CRLF
call CRLF
mWrite "	Press 5 for viewing Exam schedule"
call CRLF
call CRLF
mWrite "	Press 6 to give exam"
call CRLF
call CRLF
mWrite "	Press 7 to view result"
call CRLF
call CRLF
mWrite "	Press 8 to book a room in hostel"
call CRLF
call CRLF
mWrite "	Press 9 to change password"
call CRLF
call CRLF
mWrite "	Press 0 to exit"
call CRLF
call CRLF
mWrite "	Enter your Choice-->"



call readdec
mov choice,eax

call forcecls

.IF choice==1
    call forcecls
	Invoke registerCourse,studentId
	call crlf
	call waitmsg
.ELSEIF choice==2
	call forcecls
	Invoke GenerateAttendanceReport,studentid
	call crlf
	call waitmsg
.ELSEIF choice==3
	call forcecls
    INVOKE studentdescription
	call crlf
	call waitmsg


.ELSEIF choice==4
   call forcecls
   INVOKE stuschedule
   call crlf
   call waitmsg


.ELSEIF choice==5
	call forcecls
    INVOKE examings
	call crlf
	call waitmsg

.ELSEIF choice==6
	call forcecls
    INVOKE giveExam,studentId
	call crlf
    call waitmsg
	
.ELSEIF choice==7
	call forcecls
    INVOKE showStudentResult,studentId
	call crlf
    call waitmsg

.ELSEIF choice==8
	call forcecls
    INVOKE Hostel
	call crlf
    call waitmsg
.ELSEIF choice==9
	call forcecls
	call changePassword
	call forcecls
	call waitmsg
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
		jmp again

.ENDIF
	cmp choice,0
	jne again
quit:

ret
studentchoices ENDP
End