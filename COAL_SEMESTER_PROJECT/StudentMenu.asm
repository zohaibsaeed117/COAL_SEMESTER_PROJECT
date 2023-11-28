Include File.inc
.data
	choice byte ?
	stu student <>
	thanks byte "Thanks For using University Management System",0
	invalid BYTE "Invalid number entered!",13,10,0

.code
studentMenu Proc
	again:
	call clrscr
	call printLoginMenu		;Printing menu

	call readDec
	mov choice,al
	.IF choice==1
		Invoke LoginStudent,ADDR stu.id,ADDR stu.Stuname,ADDR stu.email,ADDR stu.contact,ADDR stu.address,ADDR stu.password
	.ELSEIF choice==2
	call CLRSCR
		call registerStudent
		jmp again
	.ELSEIF choice==0
		mov edx,offset thanks
		call writeString
	.ELSE
		mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
		jmp again
	.ENDIF

		

	ret
studentMenu ENDP
END