Include File.inc
.data

	choice byte ?
	stu student <>
	thanks byte "Thanks For using University Management System",0
	invalid BYTE "Invalid number entered!",13,10,0

.code
studentMenu Proc
    
	call forcecls


mov eax,yellow(black*16)   
call settextcolor

again:
call printLoginMenu		;Printing menu

call readDec
mov choice,al

.IF choice==1
    call forcecls
	Invoke LoginStudent,ADDR stu.id,ADDR stu.Stuname,ADDR stu.email,ADDR stu.contact,ADDR stu.address,ADDR stu.password
	INVOKE studentchoices,ADDR stu.id          ;...........student authorities

.ELSEIF choice==2
     call forcecls
     call registerStudent
	 call forcecls
	 jmp again         

.ELSEIF choice==0
		call clrscr

     jmp quit

.ELSE
		mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
				call clrscr

		
.ENDIF

quit:


	ret
studentMenu ENDP
END