Include File.inc

.data
	temp byte 80 DUP(?)
	count DWORD ?
	check byte "Hello",0
.code 

ReadCourse PROC uses edx ecx esi ebx,
buffer:PTR BYTE,
bufferSize:DWORD,
id:PTR BYTE,
courseName:PTR BYTE,
creditHours:PTR BYTE,
teacherName:PTR BYTE,
bytesRead:PTR DWORD


mov eax,bytesRead	
mov DWORD PTR[eax],0

	;Taken data of a whole user in the string temp

	mov esi,id
	mov edx,buffer
	mov ecx,20												;max length of id can be 20
	idLoop:
		mov bl,byte PTR[edx]
		mov BYTE PTR [esi],bl
		inc edx
		inc esi
		inc DWORD PTR[eax]									;telling number of bytes read in first user
		cmp byte PTR[edx]," "
		je idBreak
		loop idLoop
		idBreak:

		mov BYTE PTR [esi],0								;Adding null termianator at the end of id

		inc edx												;incrementing the space in the buffer after the id
		inc DWORD PTR[eax]									;incrementing the space in the buffer after the id


	mov esi,coursename
	mov ecx,30												;max size of name can be 20
	nameLoop:
		mov bl,byte PTR[edx]
		mov BYTE PTR [esi],bl
		inc edx
		inc esi
		inc DWORD PTR[eax]									;telling number of bytes read in first user
		cmp byte PTR[edx]," "
		je nameBreak
		loop nameLoop
		nameBreak:

		mov BYTE PTR [esi],0								;Adding null termianator at the end of name

		inc edx												;incrementing the space in the buffer after the name
		inc DWORD PTR[eax]									;incrementing the space in the buffer after the name

		

	mov esi,creditHours
	mov ecx,1											;max size of email can be 50
	creditHoursLoop:
		mov bl,byte PTR[edx]
		mov BYTE PTR [esi],bl
		inc edx
		inc esi
		inc DWORD PTR[eax]	
		cmp BYTE PTR[edx]," "
		je creditHoursBreak
		loop creditHoursLoop
		creditHoursBreak:
		mov BYTE PTR [esi],0								;Adding null termianator at the end of name

		inc edx												;incrementing the space in the buffer after the creditHours
		inc DWORD PTR[eax]								;incrementing the space in the buffer after the creditHours
		

	mov esi,teachername
	mov ecx,20												;max size of teachername can be 10
	teachernameLoop:									
		cmp byte PTR[edx],'!'
		je teachernameBreak
		mov bl,byte PTR[edx]
		mov BYTE PTR [esi],bl
		inc edx
		inc esi
		inc DWORD PTR[eax]	
		loop teachernameLoop
	teachernameBreak:
		mov BYTE PTR [esi],0								;Adding null termianator at the end of name
		
										
		add DWORD PTR[eax],3								;incrementing the space in the buffer after the name
	
ret
readCourse ENDP
END