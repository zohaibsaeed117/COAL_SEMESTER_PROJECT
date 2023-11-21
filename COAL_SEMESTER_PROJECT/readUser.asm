Include File.inc

.data
	temp byte 80 DUP(?)
	count DWORD ?
	check byte "Hello",0
.code 

readUser PROC uses edx ecx esi ebx,
buffer:PTR DWORD,
bufferSize:DWORD,
stuName:PTR DWORD,
email:PTR DWORD,
password:PTR DWORD,
bytesRead:PTR DWORD

mov edx,buffer
mov ecx,bufferSize
mov esi,0


	loop1:
		cmp BYTE PTR[edx],'!'
		je breakLoop
		mov bl,BYTE PTR[edx]
		mov temp[esi],bl
		inc esi
		inc edx
	loop loop1
	breakLoop:
	mov temp[esi],0



mov eax,bytesRead	
mov DWORD PTR[eax],esi
add DWORD PTR[eax],3




	;Taken data of a whole user in the string temp

	mov esi,stuname
	mov edx,offset temp
	mov ecx,DWORD PTR[eax]
	nameLoop:
		cmp byte PTR[edx]," "
		je nameBreak
		mov bl,byte PTR[edx]
		mov BYTE PTR [esi],bl
		inc edx
		inc esi
		loop nameLoop
		nameBreak:
		mov BYTE PTR [esi],0

		inc edx					;Passing the space after name


	mov esi,email
	emailLoop:
		cmp BYTE PTR[edx]," "
		je emailBreak
		mov bl,byte PTR[edx]
		mov BYTE PTR [esi],bl
		inc edx
		inc esi
		loop emailLoop
		emailBreak:
		mov BYTE PTR [esi],0

		inc edx						;Passing the space after email


	mov esi,password
	passwordLoop:
		cmp byte PTR[edx],0
		je passwordBreak
		mov bl,byte PTR[edx]
		mov BYTE PTR [esi],bl
		inc edx
		inc esi
		loop passwordLoop
	passwordBreak:
	mov BYTE PTR [esi],0
		

	
ret
readUser ENDP
END