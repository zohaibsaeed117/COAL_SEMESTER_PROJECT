INCLUDE File.inc

.data

subj BYTE "					*----------------- FUNCTIONAL ENGLISH --------------* ",13,10,13,10,0
mcq1 BYTE "		What of the following is a noun?",13,10,
		  "		a)Pakistan		b)chair		c)none of these",13,10,0
mcq2 BYTE "		Which of the following is verb?",13,10,
		  "		a)run		b)walk		c)both of these",13,10,0
mcq3 BYTE "		Which of the following is a proposition?",13,10,
		  "		a)king		b)in		c)sleep",13,10,0
mcq4 BYTE "		What joins two statements?",13,10,
	      "		a)noun		b)adverb		c)conjuction",13,10,0
mcq5 BYTE "		Which of the following qualifies a noun?",13,10,
	      "		a)adverb		b)adjective		c)verb",13,10,0
answers BYTE 4 DUP('a','c','b','c','b')
user_ans BYTE 4 DUP(?)

.code
FEpaper PROC

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
FEpaper ENDP
END 