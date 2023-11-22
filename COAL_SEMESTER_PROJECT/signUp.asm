Include File.inc
.data
	authentication byte "Auth.txt",0
	buffer byte 5000 DUP(?)
	bufferSize SDWORD ?
	filehandle DWORD ?
	bytesWritten DWORD ?
	bytesRead DWORD 0
	space byte " "
	newLine byte "!",0dh,0ah,0
	errMsg byte "Unable to open File",0
	nameMsg byte "Enter your name: ",0
	emailMsg byte "Enter your email: ",0
	passMsg byte "Enter your Password: ",0 
	len DWORD ?
	nameLen DWORD ?
	emailLen DWORD ?
	passwordlen DWORD ?
	stu student <>
	temp student <>
	flag byte ?
	success byte ?
	userFoundMsg byte "User Already Exists",0
	successMsg byte "User registred Successfully",0
.code
Signup PROC

INVOKE createFile, ADDR authentication,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF

	takeCredentials:
	
	mov edx,offset namemsg				;printing the message for user to enter the name
	call writeString

	mov edx,offset stu.stuName						;Taking name from the user as Input
	mov ecx,20
	call readString

	mov nameLen,eax
	
	mov edx,offset emailmsg				;printing the message for user to enter the email
	call writeString

	mov edx,offset stu.email						;Taking the email from user
	mov ecx,50
	call readString
	mov emailLen,eax

	mov edx,offset passMsg				;printing the message for user to enter the password
	call writeString

	mov edx,offset stu.password					;Taking the password from the user
	mov ecx,10
	call readString
	mov passwordLen,eax
	
	mov stu.password[eax],0
	mov len,eax

	;-----------------------------------------Checking whether the user exists already or not-------------------------|

	Invoke ReadFile,filehandle,offset buffer,5000,ADDR bufferSize,0


	.IF bufferSize==0			;If the file is empty
		jmp registerUser
	.ENDIF

	  mov edi,offset buffer
	  readFileLoop:
	  Invoke readUser,edi,bufferSize,ADDR temp.Stuname,ADDR temp.email,ADDR temp.password,addr bytesRead

	  add edi,bytesRead					;Moving to next line which contains the data of next user


	  mov eax,bytesRead
	  sub bufferSize,eax				;subracting the buffersize after taking details of one user



	  Invoke compareStr, ADDR temp.email,ADDR stu.email,ADDR flag
	  cmp flag,1
	  je userFound
	  

	  cmp bufferSize,0
	  jnle readFileLoop


	registerUser:
	;--------------------------------------------Writing all the credentials in the file---------------------------|
	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset stu.stuName, namelen,
		ADDR bytesWritten, 0				;writing the name of the user in the authentication file

		mov len,1
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END				

	INVOKE WriteFile,
		filehandle, ADDR space, len,		;Entering a space after the user name
		ADDR bytesWritten, 0

	
	mov len,eax
	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, offset stu.email, emaillen,
		ADDR bytesWritten, 0
	mov len,1

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR space, len,
		ADDR bytesWritten, 0

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, offset stu.password, passwordlen,
		ADDR bytesWritten, 0
		mov len,1

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0


	mov success,1				;If the user is registered Successfully
	mov edx,offset successMsg
	call writeString
	jmp quit
userFound:
mov edx,offset userFoundMsg
call writeString
call CRLF
jmp takeCredentials
quit:
	mov edx,filehandle
	call closeFile
	movzx eax,success
ret
Signup endp
end