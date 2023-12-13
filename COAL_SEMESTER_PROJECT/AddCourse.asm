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
	len DWORD ?
	idLen DWORD ?
	nameLen DWORD ?
	CreditHoursLen DWORD ?
	TeacherNameLen DWORD ?
	newCourse course <>
	tempCourse course <>
	flag byte ?
	successMsg byte "New Course added Successfully",0
	txt byte ".txt",0
	pathGrades byte "coursesGrades\",0
	pathAttendance byte "CourseAttendance\",0
	gradesFile byte 50 DUP(?)
	AttendanceFile byte 50 DUP(?)
	newFile byte 20 DUP(?)
.code
addcourse proc
	INVOKE createFile, ADDR authentication,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mWrite "	Unable to open the file!"
	  jmp  quit
	.ENDIF
	
	takeCourseData:

	call CRLF
	call CRLF
	call CRLF
	mWrite "	Enter Course Id:"

	mov edx,offset newCourse.id
	mov ecx,10
	call readString
	mov idLen,eax

	call CRLF
	call CRLF
	call CRLF
	mWrite "	Enter Course Name:"

	mov edx,offset newCourse.courseName
	mov ecx,30
	call readString
	mov nameLen,eax

	call CRLF
	call CRLF
	call CRLF
	mWrite "	Enter Course Credits Hours:"

	mov edx,offset newCourse.creditHours
	mov ecx,2
	call readString
	mov creditHoursLen,eax

	call CRLF
	call CRLF
	call CRLF
	mWrite "	Enter Course Teacher's Name:"

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

	INVOKE WriteFile,
		filehandle, ADDR space, 1,		;Entering a space after the user id
		ADDR bytesWritten, 0

		;writing name in file

	INVOKE WriteFile,
		filehandle,offset newCourse.courseName, namelen,
		ADDR bytesWritten, 0				;writing the name of the course in the authentication file

	INVOKE WriteFile,
		filehandle, ADDR space, 1,		;Entering a space after the user name
		ADDR bytesWritten, 0

	  ;writing credit Hours in file
	INVOKE WriteFile,
		filehandle, offset newCourse.credithours, 1,
		ADDR bytesWritten, 0
	mov len,1

	INVOKE WriteFile,
		filehandle, ADDR space, len,
		ADDR bytesWritten, 0

	INVOKE WriteFile,
		filehandle, offset newCourse.teacherName, teacherNamelen,
		ADDR bytesWritten, 0
		mov len,1

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0


	mWrite "	New Course Added successfully!"

	;Creating a file of newly Added Course
	Invoke concatstr,ADDR newCourse.courseName,ADDR txt,ADDR newFile
	Invoke concatStr,ADDR pathGrades,ADDR newFile,ADDR gradesFile


	invoke CreateFile,ADDR gradesFIle,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
	call closeFile

	Invoke concatstr,ADDR newCourse.courseName,ADDR txt,ADDR newFile
	Invoke concatStr,ADDR pathAttendance,ADDR newFile,ADDR AttendanceFile

	invoke CreateFile,ADDR AttendanceFile,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
	call closeFile
	
	jmp quit

courseFound:
mWrite "	Course Already Exists!"
call CRLF
jmp takeCourseData
quit:
	mov edx,filehandle
	call closeFile
ret
addCourse endp
end