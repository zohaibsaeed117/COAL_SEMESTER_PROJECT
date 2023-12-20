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
.code
showCourseResult PROC
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

.data
	result_file byte 45 DUP(?)
	gradePath byte "CoursesGrades\",0
	result_file_handle DWORD ?
	result_file_buffer byte 5000 DUP(?)
	string byte 40 DUP(?)
	grade byte 3 DUP(?)
	txt byte ".txt",0
	header byte "________________________________________",0dh,0ah,
				"|     Student ID      |      Grade     |",0dh,0ah,
				"|--------------------------------------|",0
.code
	Invoke concatStr,offset gradePath,offset tempCourse.courseName,offset string
	Invoke concatstr,offset string,offset txt,ADDR result_file
	INVOKE createFile, ADDR result_file,GENERIC_READ,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov result_file_handle,eax			; save file handle
	.if eax == invalid_handle_value
		mWrite "Unable to open the file"
		jmp  quit
	.ENDIF
	;----------------------------Printing the course result---------------------------
	Invoke readFile,result_file_handle,offset result_file_buffer,5000,ADDR bufferSize,0
	mov esi,offset result_file_buffer
	mov ecx,bufferSize


	mwriteString header
	call CRLF
	again:
	Invoke readfl,esi,offset string,ecx

	cmp BYTE PTR[esi],'!'
	je notGivenExam


	Invoke readfl,esi,offset grade,ecx
	pushad
	Invoke printResultFaculty,ADDR string,ADDR grade
	popad
	call CRLF
	notGivenExam:
		loop1:
		cmp BYTE PTR[esi],'!'
		je breakLoop1
		inc esi
		loop loop1
	breakLoop1:
		add esi,3
		sub ecx,3

	cmp ecx,0
	jnle again
quit:
	mov eax,result_file_handle
	call closeFile
ret
showCourseResult ENDP
END