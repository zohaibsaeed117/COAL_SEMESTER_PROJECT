INCLUDE file.inc
.data
	choice DWORD ?
	invalid BYTE "Invalid number entered!",13,10,0

.code
main PROC

	call printMenu
	mov eax,choice
	call ReadInt
	mov choice,eax
	.IF choice==1
		Invoke Login
	.ELSEIF choice==2
		Invoke registerStudent
	.ELSEIF choice==3
	    Invoke description
	.ELSEIF choice==4
	    Invoke schedule
	.ELSEIF choice==5
	    Invoke gradest
	.ELSE
		mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
	.ENDIF





	quitNow:

INVOKE ExitProcess,0 
main ENDP
END main
