INCLUDE File.inc

.data

grde BYTE "Grade: ",0
pass BYTE "Pass",0ah,0dh,0
aa BYTE "A",0ah,0dh,0
bb BYTE "B",0ah,0dh,0
cc BYTE "C",0ah,0dh,0
de BYTE "D",0ah,0dh,0
ff BYTE "F",0ah,0dh,0

.code

grade PROC,       ;grading function
marrk:DWORD

mov edx,offset grde
call writestring

.IF marrk==5
mov edx,offset aa
call writestring

.ELSEIF marrk==4
mov edx,offset bb
call writestring

.ELSEIF marrk==3
mov edx,offset cc
call writestring

.ELSEIF marrk==2
mov edx,offset de
call writestring

.ELSEIF marrk==1
mov edx,offset pass
call writestring

.ELSEIF marrk==0
mov edx,offset ff
call writestring

.ENDIF

ret
grade ENDP

END