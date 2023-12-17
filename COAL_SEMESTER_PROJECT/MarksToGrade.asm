Include File.inc
.data
.code
marksToGrade PROC,
marks:DWORD,
string:PTR BYTE

	push esi
	mov esi,string
	.IF marks==5
		mov BYTE PTR[esi],'A'
		mov BYTE PTR[esi+1],'+'
		mov BYTE PTR[esi+1],0
	.ELSEIF marks==4
	mov BYTE PTR[esi],'A'
		mov BYTE PTR[esi+1],'-'
		mov BYTE PTR[esi+1],0
	.ELSEIF marks==3
	mov BYTE PTR[esi],'B'
		mov BYTE PTR[esi+1],0
	.ELSEIF marks==2
	mov BYTE PTR[esi],'C'
		mov BYTE PTR[esi+1],0
	.ELSEIF marks==1
	mov BYTE PTR[esi],'D'
		mov BYTE PTR[esi+1],0
	.ELSEIF marks==0
	mov BYTE PTR[esi],'F'
		mov BYTE PTR[esi+1],0
	.ENDIF
	pop esi
ret
marksToGrade endp
end