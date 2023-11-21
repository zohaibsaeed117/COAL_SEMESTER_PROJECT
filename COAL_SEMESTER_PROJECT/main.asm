INCLUDE file.inc
.data
	fileHandle DWORD ?
	buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	authentication byte "auth.txt",0
.code
main PROC

	Invoke signup		


	quitNow:
INVOKE ExitProcess,0 
main ENDP
END main
