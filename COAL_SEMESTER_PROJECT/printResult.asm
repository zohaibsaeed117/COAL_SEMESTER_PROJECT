Include File.inc
.data
bufferInfo CONSOLE_SCREEN_BUFFER_INFO <>
console_buffer_handle DWORD ?
.code
printResult PROC,
courseName:PTR BYTE,
attendance:PTR BYTE,
Grade:PTR BYTE

	mwrite "|"				;Print line at start of the new line

	Invoke GetStdHandle, STD_OUTPUT_HANDLE
	mov console_buffer_handle,eax

	invoke GetConsoleScreenBufferInfo, console_buffer_handle, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x

	mov dl,bl
	add dl,5					;setting the intial position of x coord for courseName

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl

	call gotoXy


	mov edx,courseName						
	call writeString							;Writing the courseName


	invoke GetConsoleScreenBufferInfo, console_buffer_handle, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x
	Invoke str_length,courseName
	mov ecx,30
	sub ecx,eax

	mov dl,bl
	add dl,cl


	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl

	call gotoXy

	mWrite "|"

	invoke GetConsoleScreenBufferInfo, console_buffer_handle, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x

	mov dl,bl
	add dl,7					;setting the intial position of x coord for courseName

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl

	call gotoXy


	mov edx,attendance						
	call writeString							;Writing the attendance

	mwrite "%",0

	invoke GetConsoleScreenBufferInfo, console_buffer_handle, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x

	Invoke str_length,attendance
	add eax,1				;because of % sign
	mov ecx,13
	sub ecx,eax

	mov dl,bl
	add dl,cl


	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl

	call gotoXy

	mWrite "|"
	
	invoke GetConsoleScreenBufferInfo, console_buffer_handle, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x

	mov dl,bl
	add dl,6					;setting the intial position of x coord for courseName

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl

	call gotoXy


	mov edx,grade						
	call writeString							;Writing the attendance

	invoke GetConsoleScreenBufferInfo, console_buffer_handle, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x

	Invoke str_length,grade
	mov ecx,8
	sub ecx,eax

	mov dl,bl
	add dl,cl


	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl

	call gotoXy

	mWrite "|"

	ret
printResult ENDP
END