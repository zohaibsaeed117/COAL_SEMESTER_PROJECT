Include File.inc
.data
.code
intTostr PROC,
var1:DWORD,
string:PTR BYTE

	mov esi,string
	mov eax,var1
	mov ebx,10
	loop1:
	mov edx,0
		div ebx
		add dl,'0'
		mov [esi],dl
		inc esi
		cmp eax,0
	jne loop1
	mov BYTE PTR[esi],0
	
	mov esi,string

	loop2:
		movzx ebx,BYTE PTR[esi]
		push ebx
		inc esi
		cmp BYTE PTR[esi],0
	jne loop2

	mov esi,string
	loop3:
		pop ebx
		mov [esi],bl
		inc esi
	cmp BYTE PTR[esi],0
	jne loop3
		
ret
intToStr ENDP
END