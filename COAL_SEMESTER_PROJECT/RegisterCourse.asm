Include File.inc
.data
	courses byte "courses.txt",0
	newFile byte 35 DUP(?)
	filehandleAllCourse DWORD ?
	filehandlegrade DWORD ?
	filehandleattendance DWORD ?
	tempCourse course <>
	courseId byte 10 DUP(?)
	idMsg byte "Enter Code of the course you want to register: ",0
	errMsg byte "Unable to open the file",0
	successMsg byte "Your course has been registered successfully",0
	notFoundMsg byte "Course not found",0
	txt byte ".txt",0
	grade byte "_!",0dh,0ah,0
	flag byte 0
	bytesWritten byte ?
	bytesRead DWORD ?
	buffer byte 500 DUP(?)
	bufferSize DWORD ?
	space byte " ",0
	len DWORD ?
	pathGrades byte "coursesGrades\",0
	pathAttendance byte "CourseAttendance\",0
	gradesFile byte 50 DUP(?)
	AttendanceFile byte 50 DUP(?)
	anotherCourse byte "Do you want to register another course?(Y/N)",0
.code
registerCourse PROC,
Studentid:PTR byte

	call showCourses

registeragain:
	INVOKE createFile, ADDR courses,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

	mov filehandleallCourse,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF

	mov edx,offset idMsg
	call writeString

	mov edx,offset courseId
	mov ecx,10
	call readString

	

	;-----------------------------------------Checking whether the course exists already or not-------------------------|

	Invoke ReadFile,filehandleallCourse,offset buffer,5000,ADDR bufferSize,0


	.IF bufferSize==0			;If the file is empty
		jmp registerStudentInCourse
	.ENDIF

	  mov edi,offset buffer
	  readFileLoop:

	  Invoke readCourse,edi,bufferSize,ADDR tempcourse.id,ADDR tempcourse.courseName,
	  ADDR tempcourse.creditHours,ADDR tempcourse.teachername,addr bytesRead

	  add edi,bytesRead					;Moving to next line which contains the data of next user


	  mov eax,bytesRead
	  sub bufferSize,eax				;subracting the buffersize after taking details of one user



	  Invoke compareStr, ADDR tempcourse.id,ADDR courseID,ADDR flag
	  cmp flag,1
	  je courseFound
	  

	  cmp bufferSize,0
	  jnle readFileLoop
	  jmp notFound
addCourseInfile:
	;--------------------------------------------Writing all the course details in the file---------------------------|
CourseFound:
	Invoke concatstr,ADDR tempCourse.courseName,ADDR txt,ADDR newFile
	Invoke concatStr,ADDR pathGrades,ADDR newFile,ADDR gradesFile

	invoke CreateFile,ADDR gradesFIle,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
	  mov filehandlegrade,eax			; save file handle


	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF
	;---------------------------------Checking if user have registered already or not---------
.data
courseFileBuffer byte 500 DUP(?)
string byte 30 DUP(?)
alreadyRegisteredMsg  byte "You are already registered!",0
.code
	Invoke readFile,filehandlegrade,ADDR courseFilebuffer, 5000,ADDR bufferSize,0
	cmp bufferSize,0
	je registerStudentInCourse

	mov esi,offset courseFileBuffer
	mov ecx,bufferSize

	checkagain:
	Invoke readfl,esi,ADDR string,ecx			;reading student id

	Invoke compareStr,ADDR string,studentId,ADDR flag			;reading student grade
	cmp flag,1
	je alreadyRegistered
	Invoke readfl,esi,ADDR string,ecx
	dec ecx					;because we have "_!",0dh,0ah in our string one char is extra
	cmp ecx,0
	jnle checkagain

	;--------------------------------------writing student id in file of grades-------------------
	registerStudentInCourse:

	 Invoke str_length,studentid
	 mov len,eax

	INVOKE SetFilePointer,
	  filehandlegrade,0,0,FILE_END	

	INVOKE WriteFile,
		filehandlegrade,studentid, len,
		ADDR bytesWritten, 0				;writing the id of the course in the authentication file

		INVOKE SetFilePointer,
	  filehandlegrade,0,0,FILE_END	

	INVOKE WriteFile,
		filehandlegrade, ADDR space, 1,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandlegrade,0,0,FILE_END	

	INVOKE WriteFile,
		filehandlegrade, ADDR grade, 4,		;Entering a space after the user id
		ADDR bytesWritten, 0

	;--------------------------------------writing student id in file of attendance-------------------
	Invoke concatstr,ADDR tempCourse.courseName,ADDR txt,ADDR newFile
	Invoke concatStr,ADDR pathAttendance,ADDR newFile,ADDR AttendanceFile

	invoke CreateFile,ADDR AttendanceFile,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
	mov filehandleattendance,eax
	Invoke str_length,studentid
	 mov len,eax

	INVOKE SetFilePointer,
	  filehandleattendance,0,0,FILE_END	

	INVOKE WriteFile,
		filehandleattendance,studentid, len,
		ADDR bytesWritten, 0				;writing the id of the course in the authentication file

		INVOKE SetFilePointer,
	  filehandleattendance,0,0,FILE_END	

	INVOKE WriteFile,
		filehandleattendance, ADDR space, 1,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandleattendance,0,0,FILE_END	

	INVOKE WriteFile,
		filehandleattendance, ADDR grade, 4,		;Entering a space after the user id
		ADDR bytesWritten, 0

	mov edx,offset successMsg
	call writeString
	call CRLF
	mov eax,filehandleattendance
	call closeFile
	mov eax,filehandlegrade
	call closeFile
	jmp quit
alreadyRegistered:
	mov edx,offset filehandleattendance
	call writeString
	call CRLF
	mov eax,filehandleGrade
	call closeFile
	jmp quit
notFound:
	mov edx,offset notFoundMsg
	call writeString
	call CRLF
quit:
call closeFile
mov eax,filehandleallCourse
	mov edx,offset anotherCourse
	call writeString
	call CRLF
	call readChar
	.IF al=='y'
	jmp registerAgain
	.ELSEIF al=='Y'
	jmp registerAgain
	.ENDIF
ret
registerCourse ENDP
END
