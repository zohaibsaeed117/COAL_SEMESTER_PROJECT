INCLUDE file.inc
.data
	choice DWORD ?
.code
main PROC


	call printMenu
	mov eax,choice
	call ReadInt
	mov choice,eax
	.IF choice==1
		Invoke Login
	.ELSEIF choice==2
		Invoke Signup
	.ENDIF




	quitNow:
INVOKE ExitProcess,0 
main ENDP
END main
