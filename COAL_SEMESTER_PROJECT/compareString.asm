Include File.inc

.data
.code
compareStr PROC uses eax esi edi,
string1:PTR DWORD,
string2:PTR DWORD,
flag:PTR DWORD


	mov eax,flag	
	mov BYTE PTR[eax],0
	
	mov esi,string1
	mov edi,string2
	loop1:
		mov bl,byte PTR[esi]
		cmp bl,byte PTR[edi]
		jne quit
		inc esi
		inc edi
		cmp bl,0
	jne loop1

	mov eax,flag	
	mov BYTE PTR[eax],1
	

quit:
ret
compareStr endp
end