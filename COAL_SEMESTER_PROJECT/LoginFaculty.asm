Include File.inc
.data
	authentication byte "AuthFaculty.txt",0
	buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	filehandle DWORD ?
	bytesRead DWORD 0 
	flag byte ?
	tempEmail byte 50 DUP(?)
	tempPassword byte 10 DUP(?)
	email byte 20 DUP(?)
	password byte 10 DUP(?)
	tabp byte "	",0
.code
LoginFaculty PROC
takeCredentials:
call forcecls
	INVOKE createFile, ADDR authentication,GENERIC_READ,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
		mWrite "Unable to Open File"
	  jmp  quit
	.ENDIF

	call CRLF
	call CRLF
	call CRLF
	mWrite "	Enter your Email:"

	mov edx,offset tempEmail						;Taking the Email from user
	mov ecx,50
	call readString

	call CRLF
	call CRLF
	call CRLF
	mWrite "	Enter your Password:"


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
	  je success
	  emailNotFound:
	  cmp bufferSize,0
	  jnle readFileLoop

	mWrite "Wrong Credentials!"
	call CRLF
	mWrite "Do you want to try again(Y/N)"
	call readChar
	call CRLF
	.IF al=='y'
		jmp takeCredentials
	.ELSEIF al=='Y'
		jmp takeCredentials
	.ENDIF
	mov eax,0
	jmp quit
success:
	mWrite "You are logged in Successfully"
	call CRLF
	call waitMsg
	mov eax,1
quit:
push eax
	mov eax,filehandle
	call closeFile
pop eax
ret
LoginFaculty ENDP
END