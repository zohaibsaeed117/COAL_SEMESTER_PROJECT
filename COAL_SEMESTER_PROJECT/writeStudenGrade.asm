Include File.inc
.data
	buffer DWORD ?
	tempbuffer byte 5000 DUP(?)
	string byte 3 DUP(?)
.code
writestudentGrade PROC,
marks:DWORD
mov eax,marks
call writeDec
mov buffer,esi			;Preserving the intial value of buffer
mov edi,offset tempBuffer

push esi
push ecx					;Preserving the value of ecx

rep movsb

pop ecx
pop edi						;previous source is now destination

mov esi,offset tempBuffer
add edi,3
add ecx,3					;increased the size of buffer by creating space in it
push ecx

rep movsb
mov edx,buffer

mov edi,buffer
mov al," "
mov ecx,3
rep stosb

mov edi,buffer

INVOKE marksToGrade,marks,ADDR string
Invoke str_length,ADDR string

mov ecx,eax
mov esi,offset string
rep movsb

pop ecx


ret
writeStudentGrade ENDP
end