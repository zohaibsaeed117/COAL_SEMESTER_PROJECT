Include File.inc



.data
buffersize=50000
file11 BYTE "Items.txt",0
file2 BYTE "Budget.txt",0
choice1 BYTE "Enter 1 for Items and Price List..",0
choice2 BYTE "Enter 2 for the Cafeteria's Budget..",0
yourchoice BYTE "Enter a number: ",0
uni BYTE  "University Of Engineering and Technology",0
cafe BYTE   "Welocme	to	Cafeteria",0
filehandler1 dd ?
filehandler2 dd ?
buffer dd buffersize DUP(?)
Modifysize dd 0
newsize dd 0
ok BYTE "Okay..Thank You",0
Askk BYTE "Do you want to enter any more item to the list: ",0
AddNew BYTE "Enter the Item Name and Price: ",0
len1 dd ?
buffstr1 BYTE 30 DUP(?)
bytesWritten dd 0
errMsg BYTE "CANNOT OPEN FILE",0

.code
Cafeteria PROC
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
mov edx,offset cafe
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
INVOKE createfile,ADDR file11,GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0

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

mov edx,offset Askk
call writestring
call readint

.IF eax==1

mov edx,offset AddNew
call writestring

mov edx,offset buffstr1
mov ecx,30
call readstring
mov len1,eax

INVOKE SetFilePointer,
filehandler1,0,0,FILE_END

INVOKE WriteFile,
filehandler1,offset buffstr1,len1,
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
call clrscr
mov edx,offset file2
call openInputFile
mov filehandler2,eax
mov ecx,LENGTHOF buffer
mov edx,offset buffer
call ReadFromFile
mov newsize,eax
mov edx,offset buffer
call writestring
mov eax,filehandler2
call CloseFile
jmp quit


quit:
exit

ret
Cafeteria ENDP
END 