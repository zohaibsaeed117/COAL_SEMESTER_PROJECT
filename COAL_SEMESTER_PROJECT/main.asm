INCLUDE file.inc
.data
	choice DWORD ?
	user student <>
	welcome byte "Welcome ",0
.code
main PROC

	call HomeMenu
	mov eax,choice
	call ReadInt
	mov choice,eax
	.IF choice==1
		Invoke Login,ADDR user.id,ADDR user.Stuname,ADDR user.email,ADDR user.contact,ADDR user.address,ADDR user.password
	.ELSEIF choice==2
		Invoke registerStudent
	.ELSEIF choice==3
		Invoke ChangePassword
	.ENDIF
	call waitMsg
	call clrscr
	mov edx,offset welcome
	call writeString
	mov edx,offset user.stuName
	call writeString

	call CRLF
	




quitNow:
INVOKE ExitProcess,0 
main ENDP
END main