Include File.inc
.data
	courseId byte 20 DUP(?)
	course_file byte "courses.txt",0
	course_file_handle DWORD ?
	course_file_buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	tempCourse course <>
	bytesRead DWORD ?
	flag byte ?
	bytesWritten DWORD ?
	finalbufferSize DWORD ?
.code
giveExam proc,
studentId:PTR BYTE

	call showCourses
	
	call CRLF
	call CRLF
	call CRLF
	mWrite "Enter the course Id:"
	
	mov edx,offset courseId
	mov ecx,20
	call readString

	INVOKE createFile, ADDR course_file,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

	mov course_file_handle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mWrite "	Unable to open the file!"
	  jmp  quit
	.ENDIF

	;-----------------------------------------Checking whether the course exists already or not-------------------------|

	Invoke ReadFile,course_file_handle,offset course_file_buffer,5000,ADDR bufferSize,0


	  mov edi,offset course_file_buffer
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
	  mWrite "Course Not Found"
	  jmp quit
courseFound:
mov eax,course_file_handle
call closeFile
;----------------------------------Checking whether student has registered the selected course-------------------------|
.data
	student_file byte 30 DUP(?)
	student_file_handle DWORD ?
	student_file_buffer byte 5000 DUP(?)
	string byte 30 DUP(?)
	txt byte ".txt",0
	attendance DWORD ?
.code
	Invoke concatstr,studentid,ADDR txt,ADDR student_file
	INVOKE createFile, ADDR student_file,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

	mov student_File_handle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mWrite "	Unable to open the file!"
	  jmp  quit
	.ENDIF

	Invoke ReadFile,student_file_handle,offset student_file_buffer,5000,ADDR bufferSize,0
	mov eax,bufferSize
	mov finalbufferSize,eax
	.IF bufferSize==0			;If the file is empty
		jmp NoCourseRegistered
	.ENDIF

	  mov esi,offset student_file_buffer
	  mov ecx,bufferSize
	  checkagain:

	 Invoke readfl,esi,ADDR string,ecx			;reading subjects student registered
	 Invoke compareStr,ADDR string,ADDR tempcourse.courseName,ADDR flag
	 cmp flag,1
	 je registeredCourseFound
	 loop1:
		cmp BYTE PTR[esi],'!'
		je breakLoop1
		inc esi
		loop loop1
	breakLoop1:
		add esi,3
		sub ecx,3
	cmp ecx,0
	jnle checkagain
	mov eax,course_file_handle
	call closeFile
	jmp quit
registeredCourseFound:
ja quit
push ecx
push esi					;To presever the offset at which the given subject is found
	;------------------Checking if the student already have given exam or not--------------

	mov eax,0
	checkLoop:
		cmp BYTE PTR[esi],"!"
		je breakLoop
		inc esi
		inc eax
	cmp eax,3
	jle checkLoop
	breakLoop:
	.IF eax>3
		mWrite "You have already given Exam!"
		call CRLF
		jmp quit
	.ENDIF

	mov eax,course_file_handle
	call closeFile
	Invoke courseAttendance,ADDR tempCourse.courseName,studentid
	mov attendance,eax
	.IF eax<75
		mWrite "Your attendance is less than 75%."
		call CRLF
		mWrite "You are not allowed to give exam"
		call crlf
		jmp quit
	.ELSE
.data
	pf byte "Programming-Fundametals",0
	fe byte "Functional-English",0
	coal byte "COAL",0
	marks DWORD ?
.code
	Invoke str_Compare,ADDR pf,ADDR tempCourse.courseName
	je pflabel
	Invoke str_Compare,offset fe,offset tempCourse.coursename
	je felabel
	Invoke str_Compare,offset coal,offset tempCourse.CourseName
	je coallabel
	pflabel:
	Invoke pfpaper
	jmp writeResult
	felabel:
	Invoke fepaper
	jmp writeResult
	coallabel:
	Invoke coalpaper
	jmp writeResult
	.ENDIF
writeResult:
	mov marks,eax
	pop esi
	pop ecx
	Invoke assignGrade,marks,attendance
	
	
	mov eax,student_file_handle
	call closeFile
	;------------Writing result in exam ins student file----------

	mov edx,offset student_File
	call createOutputFile
	mov student_file_handle,eax
	add finalBuffersize,6				;added 7 bytes in the buffer

	INVOKE WriteFile,student_file_handle,offset student_file_buffer, finalbufferSize,
			ADDR bytesWritten, 0				;writing the name of the course in the authentication file
	mov eax,student_File_handle
	call closeFile

	;--------------Writing result in grade file-------------------------------------
	Invoke writeGradeInFile,studentId,ADDR tempCourse.courseName,marks
	jmp quit
noCourseRegistered:
	mWrite "You have not registered any course yet!"
	call CRLF
	mov eax,student_file_handle
	call closeFile
quit:
	mov eax,course_file_handle
	call closeFile
ret
giveExam endp
end