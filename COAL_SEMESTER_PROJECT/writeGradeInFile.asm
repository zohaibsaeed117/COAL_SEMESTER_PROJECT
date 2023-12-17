Include file.inc
.data
	gradePath byte "CoursesGrades\",0
	txt byte ".txt",0
	course_file_name byte 30 DUP(?)
	course_file_handle DWORD ?
	string byte 20 DUP(?)
	buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	bufferToWriteInfile DWORD ?
.code
writeGradeInFile PROC,
studentId:PTR BYTE,
courseName:PTR BYTE,
marks:DWORD
	Invoke concatStr,offset gradePath,courseName,offset string
	Invoke concatstr,offset string,offset txt,ADDR course_file_name
	INVOKE createFile, ADDR course_file_name,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov course_file_handle,eax			; save file handle
	.if eax == invalid_handle_value
		mWrite "Unable to open the file"
		jmp  quit
	.ENDIF

	;---------------------------Finding the student id in grades file--------------

	Invoke readFile,course_file_handle,offset buffer,5000,ADDR bufferSize,0
	mov eax,bufferSize
	mov bufferToWriteInFile,eax
	
	mov esi,offset buffer
	mov ecx,bufferSize

	checkagain:
		Invoke readFl,esi,ADDR string,ecx
		Invoke str_compare,ADDR string ,studentId
		je userFound
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
	userFound:
		Invoke writeStudentGrade,marks

	INVOKE SetFilePointer,
	  course_file_handle,0,0,FILE_BEGIN

	  add bufferToWriteInfile,3
	 INVOKE WriteFile,
		course_file_handle,offset buffer, bufferToWriteInfile,
		0, 0
	mov eax,course_file_handle
	call closeFile
quit:
ret
writeGradeInFile ENDP
end