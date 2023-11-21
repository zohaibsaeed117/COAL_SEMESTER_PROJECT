INCLUDE file.inc
.386
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	msg byte "Hello world",0
	x DWORD 10
	y DWORD 20
.code
main PROC
	mov eax,10
	mov ebx,20
	INVOKE SUMP ,10,20
	CALL WRITEINT

INVOKE ExitProcess,0 
main ENDP
END main
