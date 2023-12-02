Include File.inc
.data
	choice byte ?
	stu student <>
	thanks byte "Thanks For using University Management System",0
	invalid BYTE "Invalid number entered!",13,10,0

.code
studentMenu Proc
	again1:
	call clrscr
	call printLoginMenu		;Printing menu

	call readDec
	mov choice,al

	.IF choice==1
		Invoke LoginStudent,ADDR stu.id,ADDR stu.Stuname,ADDR stu.email,ADDR stu.contact,ADDR stu.address,ADDR stu.password
	.ELSEIF choice==2
		call CLRSCR
		call registerStudent
		jmp again1
	.ELSEIF choice==0
		mov edx,offset thanks
		call writeString
		jmp quit
	.ELSE
		mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
		jmp again1
	.ENDIF
.data
	menu byte "---------------------------------Welcome to University Managment System--------------------------------",0dh,0ah,
	  "Press 1 to Register a new Course",0dh,0ah,
	  "Press 0 to exit",0dh,0ah,
	  "Enter your Choice: ",0
.code
	again2:
	;Showing student menu here after loggin in
	call CLRSCR
	mov edx,offset menu
	call writeString

	call readDec
	mov choice,al

	.IF choice==1
		Invoke RegisterCourse,ADDR stu.id
	.ELSEIF choice==0
		mov edx,offset thanks
		call writeString
		jmp quit
	.ELSE
		mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
		call waitMsg
		jmp again2
	.ENDIF
		quit:
	ret
studentMenu ENDP
END