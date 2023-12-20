Include C:\Irvine\Irvine32.inc
IncludeLib C:\Irvine\Irvine32.lib
Include C:\Irvine\Macros.inc

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
course_file_buffer:PTR BYTE,
bufferSize:DWORD,
id:PTR BYTE,
stuName:PTR BYTE,
email:PTR BYTE,
contact:PTR BYTE,
address:PTR BYTE,
password:PTR BYTE,
bytesRead:PTR DWORD

ReadCourse PROTO,
course_file_buffer:PTR BYTE,
bufferSize:DWORD,
id:PTR BYTE,
courseName:PTR BYTE,
creditHours:PTR BYTE,
teacherName:PTR BYTE,
bytesRead:PTR DWORD

ReadFaculty PROTO,
course_file_buffer:PTR BYTE,
bufferSize:DWORD,
email:PTR BYTE,
password:PTR BYTE,
bytesRead:PTR DWORD

ChangePassword PROTO

RegisterCourse PROTO,
studentid:PTR BYTE

AddCourse PROTO						;This function is for Faculty member to add a new course

ShowCourses PROTO

takeAttendance PROTO

markAttendance PROTO,
attendance:DWORD

GenerateAttendanceReport PROTO,
studentId:PTR BYTE

CourseAttendance PROTO,
courseName:PTR BYTE,
studnetId:PTR BYTE

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

HostelStudent PROTO,
course_file_buffer:PTR BYTE,
bufferSize:DWORD,
id:PTR BYTE,
stuName:PTR BYTE

readfl PROTO,
course_file_buffer:PTR BYTE,
string:PTR BYTE,
len:DWORD

giveExam PROTO,
studentid:PTR BYTE

paper PROTO

gral PROTO,
marks:DWORD

forceCLS PROTO

studentdescription PROTO

stuschedule PROTO

studentchoices PROTO,
studentId:PTR BYTE

Cafeteria PROTO

Transport PROTO

Hostel PROTO

coalpaper PROTO

PFpaper PROTO

FEpaper PROTO

assignGrade PROTO,
marks:DWORD,
attendance:DWORD

intTostr PROTO,
var1:DWORD,
string:PTR BYTE

marksToGrade PROTO,
marks:DWORD,
string:PTR BYTE

writeGradeInFile PROTO,
studentId:PTR BYTE,
courseName:PTR BYTE,
marks:DWORD							;To write grade in file

writestudentGrade PROTO,				;Helping function
marks:DWORD	

showStudentResult PROTO,
studentId:PTR BYTE

printResult PROTO,
courseName:PTR BYTE,
attendance:PTR BYTE,
grade:PTR BYTE

showCourseResult PROTO

printResultFaculty PROTO,
studentId:PTR BYTE,
grade:PTR BYTE