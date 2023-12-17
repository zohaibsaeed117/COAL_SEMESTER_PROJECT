Include File.inc
.data
	txt byte ".txt",0
	student_file byte 20 DUP(?)
	student_file_handle DWORD ?
	course_file_buffer byte 5000 DUP(?)
	bytesRead DWORD ?
	bufferSize DWORD ?
	errMsg byte "Unable to open the file",0
	noCourseRegisteredMsg byte "You have not registered any course!",0
	string byte 30 DUP(?)
	flag byte ?
	colon byte ":"
	per byte "%"
.code
GenerateAttendanceReport PROC,
studentId:PTR BYTE

	Invoke concatStr,studentId,offset txt,ADDR student_file

	INVOKE createFile, ADDR student_file,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0

	mov student_file_handle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF

	;-----------------------------------------Checking whether the course exists or not-------------------------|

	Invoke ReadFile,student_file_handle,offset course_file_buffer,5000,ADDR bufferSize,0


	.IF bufferSize==0			;If the file is empty
		jmp NoCourseRegistered
	.ENDIF

	  mov esi,offset course_file_buffer
	  mov ecx,bufferSize
	  checkagain:

	 Invoke readfl,esi,ADDR string,ecx			;reading student id

	 pushad
		 mov eax,lightGreen+(black*16)
		 call settextcolor
		 mov edx,offset string
		 call writeString
		 mov al,colon
		 call writeChar
		 Invoke courseAttendance,ADDR string,studentid
		 .IF eax<75
			push eax
			mov eax,red+(black*16)
			call settextcolor
			pop eax
		.ENDIF
		 call writeDec
		 mov al,per
		 call writeChar
		 call CRLF
	 popad
		 mov eax,white+(black*16)
		 call settextcolor

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
	jmp quit
noCourseRegistered:
	mov edx,offset nocourseRegisteredMsg
	call writeString
	call CRLF
quit:
ret
GenerateAttendanceReport ENDP
END