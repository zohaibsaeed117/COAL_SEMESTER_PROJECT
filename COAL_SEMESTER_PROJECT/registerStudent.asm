Include File.inc
.data
	authentication byte "AuthStudent.txt",0
	buffer byte 5000 DUP(?)
	bufferSize SDWORD ?
	filehandle DWORD ?
	bytesWritten DWORD ?
	bytesRead DWORD 0
	space byte " "
	newLine byte "!",0dh,0ah,0
	errMsg byte "Unable to open File",0 
	len DWORD ?
	idLen DWORD ?
	nameLen DWORD ?
	contactLen DWORD ?
	AddressLen DWORD ?
	emailLen DWORD ?
	passwordlen DWORD ?
	stu student <>
	temp student <>
	flag byte ?
	success byte ?
	userFoundMsg byte "User Already Exists",0
	successMsg byte "User registred Successfully",0
	txt byte ".txt",0
	newFile byte 20 DUP(?)
	tabp byte " ",0
	choice byte ?
.code
registerStudent PROC

	takeCredentials:
	call forcecls
INVOKE createFile, ADDR authentication,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
		mWrite "Unable to Open File"
	  jmp  quit
	.ENDIF


	call CRLF
	call CRLF
	call CRLF

	mwrite "	Enter your Id:"

	mov edx,offset stu.id
	mov ecx,20
	call readString
	mov idLen,eax
	
	
	call CRLF
	call CRLF
	call CRLF
	
	mwrite "	Enter your Name:"

	mov edx,offset stu.stuName						;Taking name from the user as Input
	mov ecx,20
	call readString

	mov nameLen,eax
	
	call CRLF
	call CRLF
	call CRLF
	
	mwrite "	Enter your Email:"

	mov edx,offset stu.email						;Taking the email from user
	mov ecx,50
	call readString
	mov emailLen,eax

	
	call CRLF
	call CRLF
	call CRLF
	
	mwrite "	Enter Your Conatact Number"

	mov edx,offset stu.contact						;Taking the contact Number from user
	mov ecx,50
	call readString
	mov contactLen,eax

	call CRLF
	call CRLF
	call CRLF
	
	mwrite "	Enter your Home Address:"

	mov edx,offset stu.address					;Taking the contact Number from user
	mov ecx,50
	call readString
	mov addressLen,eax
	
	call CRLF
	call CRLF
	call CRLF
	
	mwrite "	Enter your Password:"

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
	  Invoke readStudent,edi,bufferSize,ADDR temp.id,ADDR temp.Stuname,ADDR temp.email,ADDR temp.contact,ADDR temp.address,ADDR temp.password,addr bytesRead

	  add edi,bytesRead					;Moving to next line which contains the data of next user


	  mov eax,bytesRead
	  sub bufferSize,eax				;subracting the buffersize after taking details of one user



	  Invoke compareStr, ADDR temp.id,ADDR stu.id,ADDR flag
	  cmp flag,1
	  je userFound
	  

	  cmp bufferSize,0
	  jnle readFileLoop


	registerUser:
	;--------------------------------------------Writing all the credentials in the file---------------------------|
	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset stu.id, idlen,
		ADDR bytesWritten, 0				;writing the id of the user in the authentication file

	INVOKE WriteFile,
		filehandle, ADDR space, 1,		;Entering a space after the user id
		ADDR bytesWritten, 0

		;writing name in file

	INVOKE WriteFile,
		filehandle,offset stu.stuName, namelen,
		ADDR bytesWritten, 0				;writing the name of the user in the authentication file

	INVOKE WriteFile,
		filehandle, ADDR space, 1,		;Entering a space after the user name
		ADDR bytesWritten, 0

	  ;writing email in file
	INVOKE WriteFile,
		filehandle, offset stu.email, emaillen,
		ADDR bytesWritten, 0
	mov len,1


	INVOKE WriteFile,
		filehandle, ADDR space, len,
		ADDR bytesWritten, 0

	  ;writing contact in file
	INVOKE WriteFile,
		filehandle, offset stu.contact, contactlen,
		ADDR bytesWritten, 0

	INVOKE WriteFile,
		filehandle, ADDR space, len,
		ADDR bytesWritten, 0

	INVOKE WriteFile,
		filehandle, offset stu.address, addresslen,
		ADDR bytesWritten, 0


	INVOKE WriteFile,
		filehandle, ADDR space, 1,
		ADDR bytesWritten, 0


	INVOKE WriteFile,
		filehandle, offset stu.password, passwordlen,
		ADDR bytesWritten, 0
		mov len,1


	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0


	mov success,1				;If the user is registered Successfully
	mov edx,offset successMsg
	call writeString
	;Creating a file of newly registered student
	Invoke concatstr,ADDR stu.id,ADDR txt,ADDR newFile
	invoke CreateFile,ADDR newFile,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
	mov edx,eax
	call closeFile
	jmp quit

userFound:
mov eax,red(16*black)
call setTextColor
mWrite "	User already Exists"
mov eax,lightBlue(16*black)
call setTextColor
call CRLF
quit:
	mov eax,filehandle
	call closeFile
	mWrite "	Do you want to register user again (Y/N): "
	call readChar
	.IF al=='y'
		jmp takeCredentials
	.ELSEIF al=='Y'
		jmp takeCredentials
	.ENDIF
ret
registerStudent endp
end