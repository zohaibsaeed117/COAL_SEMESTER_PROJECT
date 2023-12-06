Include File.inc
.data

lala BYTE 500 DUP(?)
lent DWORD ?
bytesWritten DWORD ?
bytesRead DWORD 0

.code

readfl PROC,
buffer:PTR BYTE,
string:PTR BYTE,
len:DWORD


	mov esi,buffer
	mov edi,string
	mov ecx,len
	loop1:
		cmp BYTE PTR[esi],"!"
		je EndofLine
		cmp BYTE PTR[esi]," "
		je endOFWord
		mov bl,[esi]
		mov [edi],bl
		inc esi
		inc edi

	loop loop1

	EndofWord:
		mov BYTE PTR[edi],0
		inc esi
		dec ecx
		jmp quit
	endofLine:
	mov BYTE PTR[edi],0
	add esi,3
	sub ecx,2
	
quit:
ret
readfl EndP
end
