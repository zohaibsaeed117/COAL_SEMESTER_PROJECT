INCLUDE File.inc

.data

value BYTE "Following are the values of variables:-",0dh,0ah,
            "var1 = 5",0dh,0ah,
            "var2 = 9",0dh,0ah,
            "var3 = 4",0dh,0ah,
            "var4 = 3",0dh,0ah,
            "var5 = 2",0dh,0ah,
            "Give answer to each equation below.",0dh,0ah,0
var1 dd 5
var2 dd 9
var3 dd 4
var4 dd 3
var5 dd 2
ep1 BYTE "(var2 * -var3)/(var1 - 4)",0ah,0dh,0
ep2 BYTE "(4 * var2)/var1",0ah,0dh,0
ep3 BYTE "(var1 * 3) + var4",0ah,0dh,0
ep4 BYTE "(var1 + 3) * var5",0ah,0dh,0
ep5 BYTE "var2 % var4",0ah,0dh,0
marks dd 0
ans dd ?
msk BYTE "Marks: ",0
yes BYTE "/5",0ah,0dh,0

.code

paper PROC 

mov eax,yellow+(black * 16)   ;TEXT color change
call settextcolor

mov edx,offset value 
call writestring

mov edx,offset ep1 
call writestring
call readint
mov ans,eax

mov eax,var2                 ; expression 1 solution
mov edx,var3
neg edx
imul edx
mov ecx,var1
sub ecx,4
idiv ecx

.IF ans==eax
   inc marks
.ENDIF

mov edx,offset ep2
call writestring
call readdec
mov ans,eax

mov eax,4                ;expression 2 solution
imul var2
idiv var1

.IF ans==eax
  inc marks
.ENDIF

mov edx,offset ep3
call writestring
call readdec
mov ans,eax

mov eax,3                      ;expresssion 3 solution
mov ebx,var1
imul ebx
add eax,var4

.IF ans==eax
inc marks
.ENDIF

mov edx,offset ep4
call writestring
call readdec
mov ans,eax

mov eax,var1               ;expression 4 solution
add eax,3
mov ebx,2
mul ebx

.IF ans==eax
inc marks
.ENDIF

mov edx,offset ep5
call writestring
call readdec
mov ans,eax

mov eax,var4               ;expression 5 solution
mov ebx,var2
mov edx,0
idiv ebx

.IF ans==edx
inc marks
.ENDIF

mov eax,white+(black * 16)   
call settextcolor

mov edx,offset msk
call writestring
mov eax,marks
call writedec
mov edx,offset yes
call writestring

ret
paper ENDP

END