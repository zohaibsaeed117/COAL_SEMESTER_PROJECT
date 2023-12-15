INCLUDE File.inc

.data

subj BYTE "					*-----------------COAL--------------* ",13,10,13,10,0
mcq1 BYTE "		What function is used to write a string?",13,10,
		  "		a)WriteString		b)writeint		c)none of these",13,10,0
mcq2 BYTE "		How a decimal value is input?",13,10,
		  "		a)readint		b)readstring		c)non pof these",13,10,0
mcq3 BYTE "		Struct is a _________ function",13,10,
		  "		a)simple		b)user-defined		c)macro",13,10,0
mcq4 BYTE "		Which of the following is used as ending of struct function?",13,10,
	      "		a)ENDP		b)ENDM		c)ENDS",13,10,0
mcq5 BYTE "		Which of following is stack pointer?",13,10,
	      "		a)sdp		b)esp		c)eax",13,10,0
answers BYTE 4 DUP('a','c','b','c','b')
user_ans BYTE 4 DUP(?)

.code
coalpaper PROC

call crlf
call crlf
mov edx,offset subj
call writestring


mov edx,offset mcq1
call writestring
call readchar
mov user_ans[0],al

mov edx,offset mcq2
call writestring
call readchar
mov user_ans[1],al

mov edx,offset mcq3
call writestring
call readchar
mov user_ans[2],al

mov edx,offset mcq4
call writestring
call readchar
mov user_ans[3],al

mov edx,offset mcq5
call writestring
call readchar
mov user_ans[4],al

mov eax,0
mov ecx,5
mov edi,0
mov esi,0
l1:
mov bl,user_ans[esi]
cmp answers[esi],bl
jne l2
inc eax
l2:
inc esi
loop l1

call writedec

ret
coalpaper ENDP
END 