Include File.inc
.data
	authentication byte "Auth.txt",0
	buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	filehandle DWORD ?
	bytesWritten DWORD ?
	bytesRead DWORD 0
	errMsg byte "Unable to open File",0
	IdMsg byte "Enter your Id: ",0
	passMsg byte "Enter your Password: ",0 
	flag byte ?
	success byte ?
	notFound byte "Wrong Credentials",0
	successMsg byte "You are logged in successfully",0
	tempId byte 20 DUP(?)
	tempPassword byte 10 DUP(?)

.code
Login PROC,
id:PTR DWORD,
stuName:PTR DWORD,
email:PTR DWORD,
contact:PTR DWORD,
address:PTR DWORD,
password:PTR DWORD

takeCredentials:
INVOKE createFile, ADDR authentication,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0


	mov filehandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  quit
	.ENDIF

	
	mov edx,offset idMsg				;printing the message for user to enter the email
	call writeString

	mov edx,offset tempid						;Taking the id from user
	mov ecx,20
	call readString

	mov edx,offset passMsg				;printing the message for user to enter the password
	call writeString

	mov edx,offset temppassword					;Taking the password from the user
	mov ecx,10
	call readString
	
	;-----------------------------------------Checking whether the user exists already or not-------------------------|

	Invoke ReadFile,filehandle,offset buffer,5000,ADDR bufferSize,0
	
	  mov edi,offset buffer
	  readFileLoop:
	  Invoke readUser,edi,bufferSize,id,Stuname,email,contact,address,password,addr bytesRead

	  add edi,bytesRead					;Moving to next line which contains the data of next user


	  mov eax,bytesRead
	  sub bufferSize,eax				;subracting the buffersize after taking details of one user


	  Invoke compareStr, id,ADDR Tempid,ADDR flag
	  cmp flag,0
	  je emailNotFound
	  Invoke compareStr, password,ADDR temppassword,ADDR flag
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
jmp takeCredentials
quit:
mov edx,offset successMsg
call writeString
call CRLF
	mov edx,filehandle
	call closeFile
ret
Login endp
end