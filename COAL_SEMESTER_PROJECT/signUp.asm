Include File.inc
.data
	authentication byte "Auth.txt",0
	buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	filehandler DWORD ?
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
	flag BYTE ?
	userFoundMsg byte "User Already Exists",0
.code
Signup PROC

INVOKE createFile, ADDR authentication,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov fileHandler,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quitNow
	.ENDIF

	
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

	Invoke ReadFile,fileHandler,offset buffer,5000,ADDR bufferSize,0

	  mov edi,offset buffer
	  add edi,bytesRead
	  readFileLoop:
	  Invoke readUser,edi,bufferSize,ADDR temp.Stuname,ADDR temp.email,ADDR temp.password,addr bytesRead

	  add edi,bytesRead					;Moving to next line which contains the data of next user

	  mov eax,bytesRead
	  sub bufferSize,eax				;subracting the buffersize after taking details of one user



	  Invoke compareStr, ADDR temp.email,ADDR stu.email,ADDR flag

	  cmp flag,1
	  je userFound
	  cmp bufferSize,0
	  ja readFileLoop



	;--------------------------------------------Writing all the credentials in the file---------------------------|
	INVOKE SetFilePointer,
	  fileHandler,0,0,FILE_END	

	INVOKE WriteFile,
		fileHandler,offset stu.stuName, namelen,
		ADDR bytesWritten, 0				;writing the name of the user in the authentication file

		mov len,1
		INVOKE SetFilePointer,
	  fileHandler,0,0,FILE_END				

	INVOKE WriteFile,
		fileHandler, ADDR space, len,		;Entering a space after the user name
		ADDR bytesWritten, 0

	
	mov len,eax
	INVOKE SetFilePointer,
	  fileHandler,0,0,FILE_END

	INVOKE WriteFile,
		fileHandler, offset stu.email, emaillen,
		ADDR bytesWritten, 0
	mov len,1

	INVOKE SetFilePointer,
	  fileHandler,0,0,FILE_END

	INVOKE WriteFile,
		fileHandler, ADDR space, len,
		ADDR bytesWritten, 0

	INVOKE SetFilePointer,
	  fileHandler,0,0,FILE_END

	INVOKE WriteFile,
		fileHandler, offset stu.password, passwordlen,
		ADDR bytesWritten, 0
		mov len,1

		INVOKE SetFilePointer,
	  fileHandler,0,0,FILE_END

	INVOKE WriteFile,
		fileHandler, ADDR newLine, 3,
		ADDR bytesWritten, 0

	
QuitNow:
	mov eax,fileHandler
	call CloseFile
	jmp quit
userFound:
	mov edx,offset userFoundmsg
	call writeString

quit:
ret
Signup endp
end