INCLUDE File.inc

.data

subj BYTE "					*----------------- PROGRAMMING FUNDAMENTAL --------------* ",13,10,13,10,0
mcq1 BYTE "		What function is used to write?",13,10,
		  "		a)cout		b)cin		c)none of these",13,10,0
mcq2 BYTE "		keyword to declare an integer value is :",13,10,
		  "		a)char		b)string		c)int",13,10,0
mcq3 BYTE "		Struct is a _________ function",13,10,
		  "		a)simple		b)user-defined		c)macro",13,10,0
mcq4 BYTE "		While is a ____________ statement.",13,10,
	      "		a)simple		b)return		c)conditional",13,10,0
mcq5 BYTE "		Which of following principle stack uses?",13,10,
	      "		a)FIFO		b)LIFO		c)LILO",13,10,0
answers BYTE 4 DUP('a','c','b','c','b')
user_ans BYTE 4 DUP(?)

.code
PFpaper PROC

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

ret
PFpaper ENDP
END 