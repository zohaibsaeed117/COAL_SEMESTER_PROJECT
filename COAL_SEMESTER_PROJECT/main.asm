INCLUDE file.inc
.data
	choice DWORD ?
	user student <>
	welcome byte "Welcome",0
	invalid BYTE "Invalid number entered!",13,10,0
	msg byte ".txt",0
	result byte 100 DUP(?)
.code
main PROC
	again:
	call clrscr
	call PrintMenu
	mov eax,choice
	call ReadInt
	mov choice,eax
	.IF choice==1
		Invoke Login,ADDR user.id,ADDR user.Stuname,ADDR user.email,ADDR user.contact,ADDR user.address,ADDR user.password
	.ELSEIF choice==2
		Invoke registerStudent
	.ELSEIF choice==3
	Invoke ChangePassword
	.ELSEIF choice==4
	    Invoke description
	.ELSEIF choice==5
	    Invoke schedule
	.ELSEIF choice==6
	    Invoke gradest
	.ELSEIF choice==7
	    Invoke examings
	.ELSEIF choice==0
	jmp quitNow
	.ELSE
		mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
	.ENDIF
	call waitMsg
	jmp again
	call CRLF
	







	quitNow:
INVOKE ExitProcess,0 
main ENDP
END main