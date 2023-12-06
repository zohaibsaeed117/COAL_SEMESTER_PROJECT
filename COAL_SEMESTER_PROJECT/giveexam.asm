INCLUDE File.inc

.data

buffer byte 5000 DUP(?)
	bufferSize DWORD ?
	filehandle DWORD ?
	bytesWritten DWORD ?
	bytesRead DWORD 0
	errMsg byte "Unable to open File",0
	IdMsg byte "Enter your Id: ",0
	passMsg byte "Enter your Password: ",0 
	notFound byte "Wrong Credentials",0
	tempId byte 20 DUP(?)
	templidlen dd ?
	tempPassword byte 10 DUP(?)
	tabp byte "	",0
	txt byte ".txt",0
	newFile byte 20 DUP(?)
	msk BYTE "Marks : ",0
	newLine byte " ",0dh,0ah,0
	nameMsg byte "Enter your name : ",0
	ContactMsg byte "Enter your Contact Number : ",0
	emailMsg byte "Enter your email : ",0
	len DWORD ?
	idLen DWORD ?
	nameLen DWORD ?
	contactLen DWORD ?
	emailLen DWORD ?
	passwordlen DWORD ?
	stu student <>
	var1 BYTE 2 DUP(?)
	var2 BYTE 2 DUP(?)
	gp BYTE "Grade : ",0
	namely BYTE "Name : ",0
	passw BYTE "Password : ",0
	con BYTE "Contact : ",0
    maill BYTE "e-mail : ",0
	ied BYTE "Id : ",0
	coursee BYTE "Course name : ",0
	cors BYTE 20 DUP(?)
	lenc DWORD ?

.code

stutest PROC

    mov edx,offset tabp
	mov edx,offset idMsg
	call writeString

	mov edx,offset stu.id
	mov ecx,20
	call readString
	mov idLen,eax

	INVOKE str_copy,addr stu.id,addr tempid

	Invoke concatstr,ADDR tempid,ADDR txt,ADDR newFile
	 ;Creating a file 

	invoke CreateFile,ADDR newFile,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
	mov edx,eax
	call closefile

	INVOKE createFile, ADDR newFile,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE, NULL,		;Opening File
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
	mov edx,offset namemsg				;printing the message for user to enter the name
	call writeString

	mov edx,offset stu.stuName						;Taking name from the user as Input
	mov ecx,20
	call readString

	mov nameLen,eax
	
	call CRLF
	call CRLF
	call CRLF
	mov edx,offset tabp
	mov edx,offset emailmsg				;printing the message for user to enter the email
	call writeString

	mov edx,offset stu.email						;Taking the email from user
	mov ecx,50
	call readString
	mov emailLen,eax

	call CRLF
	call CRLF
	call CRLF
	mov edx,offset tabp
	mov edx,offset coursee			;printing the message for user to enter the contact number
	call writeString

	mov edx,offset cors					;Taking the contact Number from user
	mov ecx,50
	call readString
	mov lenc,eax

	
	call CRLF
	call CRLF
	call CRLF
	mov edx,offset tabp
	mov edx,offset contactmsg				;printing the message for user to enter the contact number
	call writeString

	mov edx,offset stu.contact						;Taking the contact Number from user
	mov ecx,50
	call readString
	mov contactLen,eax
	
	call CRLF
	call CRLF
	call CRLF
	mov edx,offset tabp
	mov edx,offset passMsg				;printing the message for user to enter the password
	call writeString

	mov edx,offset stu.password					;Taking the password from the user
	mov ecx,10
	call readString
	mov passwordLen,eax
	
	mov stu.password[eax],0
	mov len,eax
	;.................................................................................................................

;writing name in file

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset namely,7,
		ADDR bytesWritten, 0		

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset stu.stuName, namelen,
		ADDR bytesWritten, 0				;writing the name of the user in the authentication file

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0
	
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset ied, 5,
		ADDR bytesWritten, 0	
		
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset stu.id, idlen,
		ADDR bytesWritten, 0				;writing the id of the user in the authentication file



		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0
	
	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset coursee,14 ,
		ADDR bytesWritten, 0		

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	  INVOKE WriteFile,
		filehandle,offset cors,lenc ,
		ADDR bytesWritten, 0		

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		;writing email in file

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset maill, 9,
		ADDR bytesWritten, 0		

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END
	  
	INVOKE WriteFile,
		filehandle, offset stu.email, emaillen,
		ADDR bytesWritten, 0
	mov len,1

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset con, 10,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	  ;writing contact in file

	INVOKE WriteFile,
		filehandle, offset stu.contact, contactlen,
		ADDR bytesWritten, 0

	INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END	

	INVOKE WriteFile,
		filehandle,offset passw, 11,
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

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

;##########################################################################################################

call clrscr

		INVOKE paper

		mov var2,bl
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR gp, 8,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR var2, 2,
		ADDR bytesWritten, 0


		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	INVOKE WriteFile,
		filehandle, ADDR newLine, 3,
		ADDR bytesWritten, 0

		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	  INVOKE WriteFile,
		filehandle, ADDR msk, 8,
		ADDR bytesWritten, 0

.IF var2=='A'

mov var1,'5'
       
		
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	  INVOKE WriteFile,
		filehandle, ADDR var1,2,
		ADDR bytesWritten, 0

		jmp quit

        
.ELSEIF var2=='B'

mov var1,'4'

		
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	  INVOKE WriteFile,
		filehandle, ADDR var1,2,
		ADDR bytesWritten, 0

		jmp quit
        
        
.ELSEIF var2=='C'

mov var1,'3'

	
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	  INVOKE WriteFile,
		filehandle, ADDR var1,2,
		ADDR bytesWritten, 0

        jmp quit
        
.ELSEIF var2=='D'


mov var1,'2'

	
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	  INVOKE WriteFile,
		filehandle, ADDR var1,2,
		ADDR bytesWritten, 0

		jmp quit
	
.ELSEIF var2=='E'

mov var1,'1'
		
		
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	  INVOKE WriteFile,
		filehandle, ADDR var1,2,
		ADDR bytesWritten, 0
      
	  jmp quit
        
.ELSEIF var2=='F'
     
mov var1,'0'

		
		INVOKE SetFilePointer,
	  filehandle,0,0,FILE_END

	  INVOKE WriteFile,
		filehandle, ADDR var1,2,
		ADDR bytesWritten, 0

          
.ENDIF
		

quit:

mov eax,filehandle
	mov edx,eax
	call closeFile

ret
stutest ENDP
END