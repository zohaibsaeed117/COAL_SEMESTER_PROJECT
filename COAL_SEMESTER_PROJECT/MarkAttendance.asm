Include File.inc
.data
	p byte "P",0
	A byte "A",0
	len DWORD 0
	buffer DWORD ?
	tempBuffer byte 500 DUP(?)
.code
markAttendance PROC,
attendance:DWORD

mov edi,offset tempBuffer
mov buffer,esi

push esi
push ecx					;Preserving the value of ecx

rep movsb

pop ecx
pop edi						;previous source is now destination

mov esi,offset tempBuffer
add edi,2
add ecx,2					;increased the size of buffer by creating space in it
push ecx

rep movsb
mov edx,buffer

mov edi,buffer
mov al," "
mov ecx,2
rep stosb

mov esi,buffer
.IF attendance==0
	mov BYTE PTR[esi],'A'
.ELSE
	mov BYTE PTR[esi],'P'
.ENDIF
pop ecx
loop1:
	cmp BYTE PTR[esi],'!'
	je breakLoop1
	inc esi
loop loop1
breakLoop1:
add esi,3
sub ecx,3
RET
markAttendance ENDP
END