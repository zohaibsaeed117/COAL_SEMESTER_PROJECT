Include File.inc
.data
	txt byte ".txt",0
	attendanceFileLocation byte "CourseAttendance/",0
	course_file byte 30 DUP(?)
	course_file_handle DWORD ?
	buffer byte 5000 DUP(?)
	buffersize DWORD ?
	string byte 20 DUP(?)
	errMsg byte "File not Found!",0
	A byte "A",0
	percentage real4 ?
	hundred DWORD 100
	presents DWORD ?
	totalattendance DWORD ?
.code
courseAttendance PROC,
CourseName:PTR BYTE,
studentId:PTR BYTE

	Invoke concatStr,courseName,ADDR txt,ADDR string	;"courseAttendance/Coal
	Invoke concatStr,offset attendanceFileLocation,offset string,ADDR course_file	;"courseAttendance/COAL.txt

	INVOKE createFile, ADDR course_file,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

	mov course_file_handle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF

	;-----------------------------Finding the student in a file------------------
	Invoke ReadFile,course_file_handle,offset buffer,5000,ADDR bufferSize,0

	  mov esi,offset buffer
	  mov ecx,bufferSize
	  checkagain:

	 Invoke readfl,esi,ADDR string,ecx			;reading student id

	 Invoke str_compare,ADDR string,studentId
	 je studentFound

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

studentFound:
	mov totalattendance,0
	mov presents,0			
	attendanceLoop:
		Invoke readfl,esi,ADDR string,ecx
		Invoke str_compare,ADDR string,offset a
		je absent
		inc presents
		absent:
		inc totalattendance
		cmp BYTE PTR[esi],'!'
	jne attendanceLoop
		
	mov eax,presents
	mov ebx,totalattendance

	imul eax,100
	mov edx,0
	div ebx

quit:
ret
courseAttendance ENDP
end