Include File.inc
.data
	authentication byte "AuthFaculty.txt",0
	buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	filehandle DWORD ?
	bytesRead DWORD 0
	errMsg byte "Unable to open File",0
	EmailMsg byte "Enter your Email: ",0
	passMsg byte "Enter your Password: ",0 
	flag byte ?
	notFound byte "Wrong Credentials",0
	successMsg byte "You are logged in successfully",0
	tempEmail byte 50 DUP(?)
	tempPassword byte 10 DUP(?)
	email byte 20 DUP(?)
	password byte 10 DUP(?)
	tabp byte "	",0
.code
LoginFaculty PROC
takeCredentials:
call Clrscr
	INVOKE createFile, ADDR authentication,GENERIC_READ,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF

	call CRLF
	call CRLF
	call CRLF
	mov edx,offset tabp					
	call writeString

	mov edx,offset emailMsg				;printing the message for user to enter the email
	call writeString

	mov edx,offset tempEmail						;Taking the Email from user
	mov ecx,50
	call readString

	call CRLF
	call CRLF
	call CRLF
	mov edx,offset tabp
	call writeString

	mov edx,offset passMsg				;printing the message for user to enter the password
	call writeString

	mov edx,offset temppassword					;Taking the password from the user
	mov ecx,10
	call readString

	;-----------------------------------------Checking whether the user exists already or not-------------------------|

	Invoke ReadFile,filehandle,offset buffer,5000,ADDR bufferSize,0

	mov edi,offset buffer
	  readFileLoop:
	  Invoke readFaculty,edi,bufferSize,offset email,offset password,addr bytesRead

	  add edi,bytesRead					;Moving to next line which contains the data of next user


	  mov eax,bytesRead
	  sub bufferSize,eax				;subracting the buffersize after taking details of one user


	  Invoke compareStr,ADDR email,ADDR tempEmail,ADDR flag
	  cmp flag,0
	  je emailNotFound
	  Invoke compareStr, ADDR password,ADDR temppassword,ADDR flag
	  cmp flag,1
	  je quit
	  emailNotFound:
	  cmp bufferSize,0
	  jnle readFileLoop

	mov edx,offset notFound
	call writeString
	call CRLF
	mov edx,fileHandle
	call closeFile
	call waitMsg
	jmp takeCredentials
quit:
	mov edx,offset successMsg
	call writeString
	mov eax,1
	call CRLF
	mov edx,filehandle
	call closeFile
ret
LoginFaculty ENDP
END