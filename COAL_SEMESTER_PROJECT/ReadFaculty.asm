Include File.inc

.data
	count DWORD ?
	check byte "Hello",0
.code 

readFaculty PROC uses edx ecx esi ebx,
buffer:PTR BYTE,
bufferSize:DWORD,
email:PTR BYTE,
password:PTR BYTE,
bytesRead:PTR DWORD

mov eax,bytesRead	
mov DWORD PTR[eax],0

	;Taken data of a whole user in the string temp
	mov edx,buffer

	mov esi,email
	mov ecx,50												;max size of email can be 50
	emailLoop:
		mov bl,byte PTR[edx]
		mov BYTE PTR [esi],bl
		inc edx
		inc esi
		inc DWORD PTR[eax]	
		cmp BYTE PTR[edx]," "
		je emailBreak
		loop emailLoop
		emailBreak:
		mov BYTE PTR [esi],0								;Adding null termianator at the end of name

		inc edx												;incrementing the space in the buffer after the email
		inc DWORD PTR[eax]								;incrementing the space in the buffer after the email
		

	mov esi,password
	mov ecx,10												;max size of password can be 10
	passwordLoop:									
		cmp byte PTR[edx],'!'
		je passwordBreak
		mov bl,byte PTR[edx]
		mov BYTE PTR [esi],bl
		inc edx
		inc esi
		inc DWORD PTR[eax]	
		loop passwordLoop
	passwordBreak:
		mov BYTE PTR [esi],0								;Adding null termianator at the end of name
		
										
		add DWORD PTR[eax],3								;incrementing the space in the buffer after the name
	
ret
readFaculty ENDP
END