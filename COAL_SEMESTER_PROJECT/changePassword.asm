Include File.inc
.data
	authentication byte "AuthStudent.txt",0
	buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	filehandle DWORD ?
	bytesbuffer DWORD ?
	bytesWritten DWORD ?
	bytesRead DWORD 0
	flag byte ?
	success byte ?
	notFound byte "Wrong Credentials",0
	successMsg byte "Your password has been changed successfully",0
	tempId byte 20 DUP(?)
	tempPassword byte 10 DUP(?)
	newPassword byte 10 DUP(?)
	stu student <>

.code
changePassword PROC

takeCredentials:
INVOKE createFile, ADDR authentication,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mWrite "Unable to open the file"
	  jmp  quit
	.ENDIF

	
	mWrite "	Enter your Id:"

	mov edx,offset tempid						;Taking the id from user
	mov ecx,20
	call readString

	mWrite "	Enter your Password:"

	mov edx,offset temppassword					;Taking the password from the user
	mov ecx,10
	call readString
	
	;-----------------------------------------Checking whether the user exists already or not-------------------------|

	Invoke ReadFile,filehandle,offset buffer,5000,ADDR bufferSize,0
	Invoke closehandle,fileHandle
	  mov edi,offset buffer
	  mov eax,bufferSize
	  mov bytesBuffer,eax
	  readFileLoop:
	  Invoke readStudent,edi,bufferSize,ADDR stu.id,ADDR stu.Stuname,ADDR stu.email,ADDR stu.contact,ADDR stu.address,ADDR stu.password,addr bytesRead
	  add edi,bytesRead					;Moving to next line which contains the data of next user


	  mov eax,bytesRead
	  sub bufferSize,eax				;subracting the buffersize after taking details of one user


	  Invoke compareStr, ADDR stu.id,ADDR Tempid,ADDR flag
	  cmp flag,0
	  je emailNotFound
	  Invoke compareStr, ADDr stu.password,ADDR temppassword,ADDR flag
	  cmp flag,1
	  je userFound
	  emailNotFound:
	  cmp bufferSize,0
	  jnle readFileLoop
	  jmp quit
userFound:
	mov al," "			;going back in the buffer to find the space
	mov ecx,12			
	std
	repne scasb
	add edi,2
	
	mWrite "	Enter New Password:"

	mov edx,offset newpassword
	mov ecx,10
	call readString

	mov esi,offset newpassword
	cld
	mov ecx,eax
	rep movsb

	invoke CreateFile,ADDR authentication,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
	mov filehandle,eax
	.IF eax == INVALID_HANDLE_VALUE
	  mWrite "Unable to open the file"
	  jmp  quit
	.ENDIF

	Invoke WriteFile,filehandle,offset buffer,bytesBuffer,ADDR bytesWritten,0

	mWrite "	Your password has been changed successfully!"
	jmp quitProc
quit:
	mWrite "	User Not Found"
	call CRLF
quitPROC:
	mov edx,filehandle
	call closeFile
ret
changePassword endp
end