Include File.inc
.data
	file byte "courses.txt",0
	buffer byte 5000 DUP(?)
	bufferSize SDWORD ?
	filehandle DWORD ?
	bytesWritten DWORD ?
	bytesRead DWORD 0
	errMsg byte "Unable to open File",0
	tempCourse course <>
	tabp byte "	",0
	endLine byte " ",0dh,0ah,0
	cursor coord <0,0>
	bufferInfo CONSOLE_SCREEN_BUFFER_INFO <>
	len DWORD ?
	line byte "|",0
	header byte "__________________________________________________________________________________________",0dh,0ah,
"| Course Code |  Course Name			 | Credit Hours  |    Teachers Name      |",0dh,0ah,
"------------------------------------------------------------------------------------------",0dh,0ah,0

.code
showCourses PROC
	INVOKE createFile, ADDR file,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
	
	
	mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF
	;--------------------------------------------Printing the course details in the console---------------------------|

	Invoke ReadFile,filehandle,offset buffer,5000,ADDR bufferSize,0

	mov eax,cyan+(black * 16)
	call settextcolor

	mov edx,offset header
	call writeString


	mov edi,offset buffer
	readFileLoop:

	Invoke readCourse,edi,bufferSize,ADDR tempcourse.id,ADDR tempcourse.courseName,
	ADDR tempcourse.creditHours,ADDR tempcourse.teachername,addr bytesRead

	add edi,bytesRead					;Moving to next line which contains the data of next user

	mov eax,bytesRead
	sub bufferSize,eax				;subracting the buffersize after taking details of one user


	;--------------------------------------Printing a line ( | )------------------------------------------

	mov edx,offset line
	call writeString

	;--------------------------------------Printing the Course ID------------------------------------------

	invoke GetStdHandle, STD_OUTPUT_HANDLE
	invoke GetConsoleScreenBufferInfo, eax, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x

	mov dl,bl								
	add dl,3

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl								;moving the value of y
	call gotoXy

	
	mov edx,offset tempCourse.id			;Printing Course id
	call writeString

	;--------------------------------------Printing a line ( | ) after CourseId------------------------------------------

	Invoke str_length,ADDR tempCourse.id		;length of string is in eax
	mov len,eax
	;Finding the current position of console cursor
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	invoke GetConsoleScreenBufferInfo, eax, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x

	mov ecx,10									;Max length of id
	sub ecx,len									;Subtracting the max length of id with the orignal len
	;The above line will points the cursor at the end of boundary of id
	mov dl,bl								;moving the value of x
	add dl,cl

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl								;moving the value of y
	call gotoXy

	mov edx,offset line
	call writeString

	;--------------------------------------Printing the CourseName------------------------------------------
	;Max length of courseName is 30 so it will check the length of string and then it will subtract it with 30
	;
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	invoke GetConsoleScreenBufferInfo, eax, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x


	mov ecx,4								;Setting the cursor value on current line
	mov dl,bl								;moving the value of x
	add dl,cl

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl								;moving the value of y
	call gotoXy


	mov edx,offset tempCourse.courseName
	call writeString
	;--------------------------------------Printing the Line ( | ) after Course Name------------------------------------------

	
	Invoke str_length,ADDR tempCourse.courseName		;length of string is in eax
	mov len,eax
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	invoke GetConsoleScreenBufferInfo, eax, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x
	mov ecx,30
	sub ecx,len									;Subtracting the max length of name with the orignal len
	mov dl,bl								;moving the value of x
	add dl,cl

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl								;moving the value of y
	call gotoXy

	mov edx,offset line
	call writeString

	;--------------------------------------Printing the CreditHours------------------------------------------

	
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	invoke GetConsoleScreenBufferInfo, eax, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x
	
	mov ecx,7
	mov dl,bl								;moving the value of x
	add dl,cl

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl								;moving the value of y
	call gotoXy

	mov edx,offset tempCourse.creditHours
	call writeString

	;--------------------------------------Printing the Line after Credithours------------------------------------------

	mov len,1
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	invoke GetConsoleScreenBufferInfo, eax, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x
								;Subtracting the max length of name with the orignal len
	mov dl,bl								;moving the value of x
	add dl,cl
	add dl,6					;!!CAUTION this is only used to match the line
	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl								;moving the value of y
	call gotoXy

	mov edx,offset line
	call writeString

	;--------------------------------------Printing the Teacher's Name------------------------------------------

	invoke GetStdHandle, STD_OUTPUT_HANDLE
	invoke GetConsoleScreenBufferInfo, eax, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x								;Subtracting the max length of name with the orignal len
	mov ecx,3
	mov dl,bl								;moving the value of x
	add dl,cl

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl								;moving the value of y
	call gotoXy

	
	mov edx,offset tempCourse.teachername
	call writeString

	;--------------------------------------Printing the Line after Credithours------------------------------------------

	invoke Str_length,ADDR tempCourse.teacherName
	mov len,eax
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	invoke GetConsoleScreenBufferInfo, eax, ADDR BufferInfo
	mov bx,bufferInfo.dwCursorPosition.x

	mov ecx,20
	sub ecx,len								;Subtracting the max length of name with the orignal len
	mov dl,bl								;moving the value of x
	add dl,cl

	mov bx,bufferInfo.dwCursorPosition.y
	mov dh,bl								;moving the value of y
	call gotoXy

	mov edx,offset line
	call writeString


	mov edx,offset endLine
	call writeString

	cmp bufferSize,0
	jnle readFileLoop
	quit:
	mov eax,white+(black * 16)
	call settextcolor
ret
showCourses ENDP
END