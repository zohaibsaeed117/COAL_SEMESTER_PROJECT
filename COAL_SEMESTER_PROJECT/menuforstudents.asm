Include File.inc

.data
		uni byte "-------Welcome to University Managment System--------",0dh,0ah,0
	 
	  menu BYTE "Press 1 for Changing password",0dh,0ah,
	  "Press 2 for Courses description",0dh,0ah,
	  "Press 3 for Courses Schedule",0dh,0ah,
	  "Press 4 for viewing Exam schedule",0dh,0ah,
	  "Press 5 to give exam",0dh,0ah,
      "Enter your Choice: ",0
	  
	choice DWORD ?
	user student <>
	thanks byte "ThankYou for using University Management System",0
	invalid BYTE "Invalid number entered!",13,10,0
	msg byte ".txt",0
	result byte 100 DUP(?)
	userName byte "zohaib-saeed",0


.code
 
studentchoices PROC


Invoke registerCourse,ADDR userName         ;......registration for course
call clrscr

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

call clrscr

.IF choice==1
	Invoke ChangePassword
	call crlf
	call waitmsg

.ELSEIF choice==2
    INVOKE studentdescription
	call crlf
	call waitmsg


.ELSEIF choice==3
   INVOKE stuschedule
   call crlf
   	call waitmsg


.ELSEIF choice==4
    INVOKE examings
	call crlf
	call waitmsg

.ELSEIF choice==5
    INVOKE stutest
	call crlf
    call waitmsg


.ENDIF

INVOKE main
	

ret
studentchoices ENDP
End