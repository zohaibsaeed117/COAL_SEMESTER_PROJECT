Include C:\Irvine\Irvine32.inc
IncludeLib C:\Irvine\Irvine32.lib

STUDENT struct
	Stuname BYTE 20 DUP(?)
	Email BYTE 50 DUP(?)
	password byte 10 DUP(?)
STUDENT ENDS


Signup PROTO

ReadUser PROTO,
buffer:PTR DWORD,
sizeOfBuffer:DWORD,
stuName:PTR DWORD,
email:PTR DWORD,
password:PTR DWORD,
byteRead:PTR DWORD

compareStr PROTO,
string1:PTR DWORD,
string2:PTR DWORD,
flag:PTR DWORD