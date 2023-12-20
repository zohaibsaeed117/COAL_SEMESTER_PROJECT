Include File.inc
.data
bufferInfo CONSOLE_SCREEN_BUFFER_INFO <>
console_buffer_handle DWORD ?
.code
printResultFaculty PROC,
studentId:PTR BYTE,
grade:PTR BYTE

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


	mov edx,studentId						
	call writeString							;Writing the studentid


	invoke GetConsoleScreenBufferInfo, console_buffer_handle, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x
	Invoke str_length,studentId
	mov ecx,16
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
	add dl,8					;setting the intial position of x coord for courseName

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
printResultFaculty ENDP
end