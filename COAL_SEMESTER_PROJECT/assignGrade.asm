Include File.inc
.data
	buffer DWORD ?
	tempbuffer byte 5000 DUP(?)
	string byte 3 DUP(?)
.code
assignGrade PROC,
marks:DWORD,
attendance:DWORD

mov buffer,esi			;Preserving the intial value of buffer
mov edi,offset tempBuffer

push esi
push ecx					;Preserving the value of ecx

rep movsb

pop ecx
pop edi						;previous source is now destination

mov esi,offset tempBuffer
add edi,6
add ecx,6					;increased the size of buffer by creating space in it
push ecx

rep movsb
mov edx,buffer

mov edi,buffer
mov al," "
mov ecx,6
rep stosb

INVOKE intTostr,attendance,ADDR string
Invoke str_length,offset string
mov ecx,eax
mov edi,buffer
mov esi,offset string
rep movsb

mov ecx,1
mov al," "
stosb

INVOKE marksToGrade,marks,ADDR string
Invoke str_length,ADDR string


mov ecx,eax
mov esi,offset string
rep movsb

pop ecx


ret
assignGrade ENDP
end