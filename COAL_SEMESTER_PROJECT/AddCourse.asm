Include File.inc
.data
	authentication byte "courses.txt",0
	buffer byte 5000 DUP(?)
	bufferSize SDWORD ?
	filehandle DWORD ?
	bytesWritten DWORD ?
	bytesRead DWORD 0
	space byte " "
	newLine byte "!",0dh,0ah,0
	errMsg byte "Unable to open File",0
	idMsg byte "Enter Course ID: ",0
	nameMsg byte "Enter course name: ",0
	creditMsg byte "Enter Credit Hours: ",0
	teacherMsg byte "Enter course Teacher's Name: ",0
	len DWORD ?
	idLen DWORD ?
	nameLen DWORD ?
	CreditHoursLen DWORD ?
	TeacherNameLen DWORD ?
	newCourse course <>
	tempCourse course <>
	flag byte ?
	courseFoundMsg byte "Course Already Exists",0
	successMsg byte "New Course added Successfully",0
	txt byte ".txt",0
	newFile byte 20 DUP(?)
.code
addcourse proc
	INVOKE createFile, ADDR authentication,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF
	
	takeCourseData:
	mov edx,offset idMsg
	call writeString

	mov edx,offset newCourse.id
	mov ecx,10
	call readString
	mov idLen,eax

	mov edx,offset NameMsg
	call writeString

	mov edx,offset newCourse.courseName
	mov ecx,30
	call readString
	mov nameLen,eax

	mov edx,offset creditMsg
	call writeString

	mov edx,offset newCourse.creditHours
	mov ecx,2
	call readString
	mov creditHoursLen,eax

	mov edx,offset teacherMsg
	call writeString

	mov edx,offset newCourse.teacherName
	mov ecx,20
	call readString
	mov teacherNameLen,eax

	;-----------------------------------------Checking whether the course exists already or not-------------------------|

	Invoke ReadFile,filehandle,offset buffer,5000,ADDR bufferSize,0


	.IF bufferSize==0			;If the file is empty
		jmp addCourseinFile
	.ENDIF

	  mov edi,offset buffer
	  readFileLoop:

	  Invoke readCourse,edi,bufferSize,ADDR tempcourse.id,ADDR tempcourse.courseName,
	  ADDR tempcourse.creditHours,ADDR tempcourse.teachername,addr bytesRead

	  add edi,bytesRead					;Moving to next line which contains the data of next user


	  mov eax,bytesRead
	  sub bufferSize,eax				;subracting the buffersize after taking details of one user



	  Invoke compareStr, ADDR tempcourse.id,ADDR newCourse.id,ADDR flag
	  cmp flag,1
	  je courseFound
	  

	  cmp bufferSize,0
	  jnle readFileLoop

addCourseInfile:
	;--------------------------------------------Writing all the course details in the file---------------------------|
	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset newCourse.id, idlen,
		ADDR bytesWritten, 0				;writing the id of the course in the authentication file

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END				

	INVOKE WriteFile,
		filehandle, ADDR space, 1,		;Entering a space after the user id
		ADDR bytesWritten, 0

		;writing name in file

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset newCourse.courseName, namelen,
		ADDR bytesWritten, 0				;writing the name of the course in the authentication file

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END				

	INVOKE WriteFile,
		filehandle, ADDR space, 1,		;Entering a space after the user name
		ADDR bytesWritten, 0

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END


	  ;writing credit Hours in file
	INVOKE WriteFile,
		filehandle, offset newCourse.credithours, 1,
		ADDR bytesWritten, 0
	mov len,1

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR space, len,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, offset newCourse.teacherName, teacherNamelen,
		ADDR bytesWritten, 0
		mov len,1

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0


	mov edx,offset successMsg
	call writeString
	;Creating a file of newly Added Course
	Invoke concatstr,ADDR newCourse.courseName,ADDR txt,ADDR newFile
	invoke CreateFile,ADDR newFile,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
	mov edx,eax
	call closeFile
	jmp quit

courseFound:
mov edx,offset courseFoundMsg
call writeString
call CRLF
jmp takeCourseData
quit:
	mov edx,filehandle
	call closeFile
ret
addCourse endp
end