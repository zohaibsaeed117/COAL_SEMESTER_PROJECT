Include C:\Irvine\Irvine32.inc
IncludeLib C:\Irvine\Irvine32.lib

STUDENT struct
	id byte 20 DUP(0)
	Stuname BYTE 20 DUP(0)
	Email BYTE 50 DUP(0)
	password byte 10 DUP(0)
	contact byte 12 DUP(0)
	address byte 20 DUP(0)
STUDENT ENDS

HomeMenu PROTO

registerStudent PROTO

Login PROTO,
id:PTR DWORD,
stuName:PTR DWORD,
email:PTR DWORD,
contact:PTR DWORD,
address:PTR DWORD,
password:PTR DWORD,

ReadUser PROTO,
buffer:PTR DWORD,
bufferSize:DWORD,
id:PTR DWORD,
stuName:PTR DWORD,
email:PTR DWORD,
contact:PTR DWORD,
address:PTR DWORD,
password:PTR DWORD,
bytesRead:PTR DWORD

ChangePassword PROTO

compareStr PROTO,
string1:PTR DWORD,
string2:PTR DWORD,
flag:PTR DWORD

description PROTO

schedule PROTO

paper PROTO

grade PROTO,
marrk:DWORD

gradest PROTO