include file.inc
.data
	MSG	byte "hello,world",0
.code
login proc
mov edx,offset msg
call writeString
ret
login endp

end