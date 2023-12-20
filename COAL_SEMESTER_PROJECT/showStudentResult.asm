Include File.inc
.data
	student_file byte 30 DUP(?)
	student_File_handle DWORD ?
	txt byte ".txt",0
	tempStr byte 30 DUP(?)
	attendance DWORD 4 DUP(?)
	grade DWORD 3 DUP(?)
	buffer BYTE 5000 DUP(?)
	bufferSize DWORD ?
	checkPaper DWORD ?
	header byte "_________________________________________________________________________",0dh,0ah,
				"|           Course Name             |    Attendance %    |    Grade     |",0dh,0ah,
				"-------------------------------------------------------------------------",0
	
.code
showStudentResult PROC,
studentid:PTR BYTE

Invoke concatStr,studentid,ADDR txt,offset student_File

INVOKE createFile, ADDR student_file,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov student_File_handle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mWrite "	Unable to open the file!"
	  jmp  quit
	.ENDIF

	;----------------------Reading File-------------------------------
	Invoke readFile,student_file_handle,offset buffer,5000,ADDR bufferSize,0
	mov esi,offset buffer
	mov ecx,bufferSize


	mwriteString header
	call CRLF
	again:
	Invoke readfl,esi,offset tempStr,ecx

	push esi
	cmp BYTE PTR[esi],'!'
	je notGivenExam
	pop esi


	Invoke readfl,esi,offset attendance,ecx

	Invoke readfl,esi,offset grade,ecx
	push ecx
	Invoke printResult,ADDR tempStr,ADDR attendance,ADDR grade
	inc checkPaper
	pop ecx
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
	cmp checkpaper,0
	jne quit
	mWrite "You have not given any exam"
quit:
	mov eax,student_File_handle
	call CloseFile
ret
showStudentResult ENDP
END