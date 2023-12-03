Include File.inc
.data
buffersize=50000
file1 BYTE "BusInfo.txt",0
file2 BYTE "Drivers.txt",0
choice1 BYTE "Enter 1 to get information about Buses and their Routes..",0
choice2 BYTE "Enter 2 to get information about Drivers..",0
yourchoice BYTE "Enter a number: ",0
uni BYTE  "University Of Engineering and Technology",0
tss BYTE   "Welocme	to	 Transport Service",0
filehandler1 dd ?
filehandler2 dd ?
buffer dd buffersize DUP(?)
Modifysize dd 0
newsize dd 0
Ask1 BYTE "Is there any new bus you want to add in the list: ",0
newadd BYTE "Enter bus number and route number: ",0
ok BYTE "Okay...Thank You ",0
buffstr1 BYTE 30 DUP(?)
buffstr2 BYTE 50 DUP(?)
strlen DD ?
bytesWritten dd 0
length1 dd ?
length2 dd ?
Ask BYTE "Is there any new Driver you want to add: ",0
newadd1 BYTE "Add Name and Contact of Driver with Route Number: ",0
errMsg BYTE "CANNOT OPEN FILE",0

.code
Transport PROC
mov eax,yellow+(black*16)
call settextcolor
mov dh,0
mov dl,30
call gotoxy
mov edx,offset uni
call writestring
call crlf
mov dh,2
mov dl,35
call gotoxy
mov edx,offset tss
call writestring

call crlf
call crlf
call crlf
mov edx,offset choice1
call writeString
call crlf
mov edx,offset choice2
call writeString
call crlf
call crlf
mov edx,offset yourchoice
call writestring
call readint
cmp eax,1
je FL1
cmp eax,2
je FL2
jmp quit

FL1:

INVOKE createfile,ADDR file1,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0

mov filehandler1,eax
.IF eax==INVALID_HANDLE_VALUE
mov edx,OFFSET errMsg
call writestring
jmp quit
.ENDIF

mov edx,offset buffer
mov ecx,buffersize
call ReadFromFile

mov edx,offset buffer
call writestring

mov edx,offset Ask1
call writestring
call readint

.IF eax==1

mov edx,offset newadd
call writestring

mov edx,offset buffstr1
mov ecx,30
call readstring
mov length1,eax

INVOKE SetFilePointer,
filehandler1,0,0,FILE_END

INVOKE WriteFile,
filehandler1,offset buffstr1,length1,
ADDR bytesWritten,0

mov eax,filehandler1
call closefile
jmp quit

.ELSEIF eax==0
call crlf
mov edx,offset ok
call writestring
mov eax,filehandler1
call closefile
jmp quit

.ENDIF

FL2:

INVOKE createfile,ADDR file2,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0

mov filehandler2,eax
.IF eax==INVALID_HANDLE_VALUE
mov edx,OFFSET errMsg
call writestring
jmp quit
.ENDIF

mov edx,offset buffer
mov ecx,buffersize
call ReadFromFile

mov edx,offset buffer
call writestring

mov edx,offset Ask
call writestring
call readint

.IF eax==1

mov edx,offset newadd1
call writestring

mov edx,offset buffstr2
mov ecx,30
call readstring
mov length2,eax

INVOKE SetFilePointer,
filehandler2,0,0,FILE_END

INVOKE WriteFile,
filehandler2,offset buffstr2,length2,
ADDR bytesWritten,0
call writeWindowsMsg

mov eax,filehandler2
call closefile
jmp quit

.ELSEIF eax==0
call crlf
mov edx,offset ok
call writestring
mov eax,filehandler2
call closefile
jmp quit

.ENDIF

quit:
exit 

ret
Transport ENDP
end