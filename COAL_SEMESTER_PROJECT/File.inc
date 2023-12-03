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

course struct
	id byte 10 DUP(0)
	Coursename BYTE 30 DUP(0)
	creditHours BYTE 2 DUP(0)
	TeacherName byte 20 DUP(0)
course ENDS

PrintMainMenu PROTO

PrintLoginMenu PROTO			;will print the menu in which it will ask user if he wants to register a new student or login

PrintMenu PROTO

StudentMenu PROTO				;Student interface

FacultyMenu PROTO				;Faculty interface

registerStudent PROTO

LoginStudent PROTO,
id:PTR BYTE,
stuName:PTR BYTE,
email:PTR BYTE,
contact:PTR BYTE,
address:PTR BYTE,
password:PTR BYTE

LoginFaculty PROTO

ReadStudent PROTO,
buffer:PTR BYTE,
bufferSize:DWORD,
id:PTR BYTE,
stuName:PTR BYTE,
email:PTR BYTE,
contact:PTR BYTE,
address:PTR BYTE,
password:PTR BYTE,
bytesRead:PTR DWORD

ReadCourse PROTO,
buffer:PTR BYTE,
bufferSize:DWORD,
id:PTR BYTE,
courseName:PTR BYTE,
creditHours:PTR BYTE,
teacherName:PTR BYTE,
bytesRead:PTR DWORD

ReadFaculty PROTO,
buffer:PTR BYTE,
bufferSize:DWORD,
email:PTR BYTE,
password:PTR BYTE,
bytesRead:PTR DWORD

ChangePassword PROTO

RegisterCourse PROTO,
studentName:PTR DWORD

AddCourse PROTO						;This function is for Faculty member to add a new course

ShowCourses PROTO

compareStr PROTO,
string1:PTR DWORD,
string2:PTR DWORD,
flag:PTR DWORD

concatStr PROTO,
string1:PTR DWORD,
string2:PTR DWORD,
result:PTR DWORD

description PROTO

schedule PROTO

gradest PROTO

examings PROTO

Transport PROTO

Cafeteria PROTO

readfl PROTO,
buffer:PTR BYTE,
string:PTR BYTE,
len:DWORD

solo PROTO

paper PROTO

gral PROTO,
marks:DWORD