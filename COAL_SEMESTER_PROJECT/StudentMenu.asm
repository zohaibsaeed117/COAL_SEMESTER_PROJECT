Include File.inc
.data

	uni byte "---------------------------------Welcome to University Managment System--------------------------------",0dh,0ah,0
	choice byte ?
	stu student <>
	thanks byte "Thanks For using University Management System",0
	invalid BYTE "Invalid number entered!",13,10,0

.code
studentMenu Proc
    
	call clrscr

mov eax,cyan(black*16)    ;welcoming the user to unversity
call settextcolor
mov edx,offset uni
call writestring

again:
call printLoginMenu		;Printing menu

call readDec
mov choice,al

.IF choice==1
    call clrscr
	Invoke LoginStudent,ADDR stu.id,ADDR stu.Stuname,ADDR stu.email,ADDR stu.contact,ADDR stu.address,ADDR stu.password
	INVOKE studentchoices          ;...........student authorities

.ELSEIF choice==2
     call CLRSCR
     call registerStudent
	 call CLRSCR
	 jmp again         

.ELSEIF choice==0
     jmp quit

.ELSE
		mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
		
.ENDIF

quit:


	ret
studentMenu ENDP
END