Include File.inc
.data
.code 
concatStr PROC,
string1:PTR DWORD,
string2:PTR DWORD,
result:PTR DWORD

Invoke str_length,string1
mov ecx,eax
mov esi,string1
mov edi,result
rep movsb

Invoke str_length,string2
mov ecx,eax
mov esi,string2
rep movsb
mov BYTE PTR[edi],0
ret
concatStr ENDP
END