INCLUDE file.inc
.data
	choice DWORD ?
	user student <>
	thanks byte "ThankYou for using University Management System",0
	invalid BYTE "Invalid number entered!",13,10,0
	msg byte ".txt",0
	result byte 100 DUP(?)
	id byte "2022-CS-628",0
	pf byte "Programming-Fundamental",0
.code
main PROC
;Invoke writeGradeInFile,ADDR id,ADDR pf,5
Invoke giveExam,ADDR id
comment @
call clrscr
again:
call PrintMainMenu
call readdec
mov choice,eax

.IF choice==1                    ;....Student menu
	   INVOKE studentmenu

.ELSEIF choice==2                ;....Menu for Faculty
		INVOKE facultymenu

.ELSEIF choice==0                ;....To exit
		mov eax,lightgreen(black*16)
		call settextcolor
		mov edx,offset thanks
		call writeString
		call crlf
		call crlf
		call crlf
		jmp quit

.ELSE                            ;......In case user enterd the wrong number not given in menu
mov eax,red+(black * 16)
		call settextcolor
		mov edx,offset invalid
		call writestring
		mov eax,white+(black * 16)				   
		call settextcolor
		jmp again

.ENDIF

jmp again


quit:
	nop

	mov eax,white(black*16)           ;.....deafult text color setting
	call settextcolor

	
	@
INVOKE ExitProcess,0 
main ENDP
END main