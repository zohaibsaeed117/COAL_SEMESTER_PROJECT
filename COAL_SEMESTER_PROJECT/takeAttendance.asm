Include File.inc
.data
	coursesFile byte "courses.txt",0
	file_handle_courses_file DWORD ?
	file_handle_attendance_file DWORD ?
	errMsg byte "File not Found!",0
	buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	bytesRead DWORD ?
	courseIdMsg byte "Please Enter Course Id:",0
	courseId byte 20 DUP(?)
	tempCourse course <>
	flag dword ?
	attendancePath byte "CourseAttendance\",0
	txt byte ".txt",0
	result byte 30 DUP(?)
	attendanceFile byte 50 DUP(?)
	tempStr byte 20 DUP(?)
	attendance_file_buffer BYTE 5000 DUP(?)
	colon byte ":",0
	choice DWORD ?
	wrongChoiceMsg byte "Wrong Choice!Enter Input again",0
	courseNotFoundMsg byte "Course Not Found",0
	againMsg byte "Do you want to take attendance again? (Y/N)",0
	bytesWritten DWORD ?
	bufferToWriteInFile DWORD ?
.code
takeAttendance Proc

	takeAttendanceLabel:

	call showCourses
	INVOKE createFile, ADDR coursesFile,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov file_handle_courses_file,eax			; save file handle
	.if eax == invalid_handle_value
	  mov  edx,offset errmsg		; display error message
	  call writestring
	  jmp  quit
	.ENDIF

	;----------------------Taking course id from the user---------------------------------
	mov edx,offset courseIdMsg
	call writeString

	mov edx,offset courseId
	mov ecx,20
	call readString

	;----------------------Checking whether the course exists or not-----------------------

	Invoke readFile,file_handle_courses_file,offset buffer,5000,ADDR bufferSize,0


	  mov edi,offset buffer
	  readFileLoop:

	  Invoke readCourse,edi,bufferSize,ADDR tempcourse.id,ADDR tempcourse.courseName,
	  ADDR tempcourse.creditHours,ADDR tempcourse.teachername,addr bytesRead

	  add edi,bytesRead					;Moving to next line which contains the data of next user


	  mov eax,bytesRead
	  sub bufferSize,eax				;subracting the buffersize after taking details of one user



	  Invoke compareStr, ADDR tempcourse.id,ADDR courseId,ADDR flag
	  cmp flag,1
	  je courseFound
	  

	  cmp bufferSize,0
	  jnle readFileLoop
	  mov edx,offset courseNotFoundMsg
	  call writeString
	  call CRLF
	  jmp courseNotFound

	  courseFound:
	  ;----------------------Opening attendance file--------------------

	  Invoke concatstr,ADDR tempCourse.courseName,ADDR txt,ADDR result       ;i.e "file.txt"
	  Invoke concatStr,ADDR attendancePath,ADDR result,ADDR attendanceFile           ;"path/file.txt"

	  INVOKE createFile, ADDR attendanceFile,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
	  
	  mov file_handle_attendance_file,eax			; save file handle

	  .if eax == invalid_handle_value
		  mov  edx,offset errmsg		; display error message
		  call writestring
		  jmp  quit
	  .ENDIF
	  ;---------------Taking attendance----------------------
	Invoke readFile,file_handle_attendance_file,offset attendance_file_buffer,5000,ADDR bufferSize,0
	mov eax,bufferSize
	mov bufferToWriteInFile,eax
	
	mov esi,offset attendance_file_buffer
	mov ecx,bufferSize

	checkagain:
	call CRLF
	call CRLF
		Invoke readFl,esi,ADDR tempStr,ecx

		mov edx,offset tempStr
		call writeString

		mov edx,offset colon
		call writeString
		takeInputagain:

		call readInt
		mov choice,eax

		Invoke markattendance,choice

		add bufferToWriteInFile,2 ;2 bytes are added in each itreation

		cmp ecx,0
		jnle checkagain

	;----------------------------Writing attendance in file------------------
	mov eax,file_handle_attendance_file
	call closeFile

	mov edx,offset attendanceFile
	call createOutputFile
	mov file_handle_attendance_file,eax
	INVOKE WriteFile,
		file_handle_attendance_file, offset attendance_file_buffer, bufferToWriteInFile,
		ADDR bytesWritten, 0
	mov eax,file_handle_attendance_file
	call closeFile
	jmp quit
courseNotFound:
	mov eax,file_handle_courses_file
	call closeFile

	mov edx,offset againMsg
	call writeString
	call CRLF
	call readChar
	.IF al=='y'
		jmp  takeAttendanceLabel
	.ELSEIF al=='Y'
		jmp takeAttendanceLabel
	.ENDIF
quit:
ret
takeAttendance ENDP
END