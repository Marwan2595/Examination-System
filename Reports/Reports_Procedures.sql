--Report That Takes Course ID and Return its Topics
create proc courseTopics
(@courseId int)
as
	SELECT * FROM Topic 
	WHERE crs_id = @courseId
return

--Report That Takes Student ID and Course ID and Return The Exam Answers
create proc studentExamAnswers
(@studentId int , @courseId int )
as
	SELECT Q.body AS Question ,
	SQ.Student_Answer AS Student_Answer,
	Q.correct_answer AS Correct_Answer
	FROM Question AS Q , Students_answer_Questions AS SQ
	WHERE Q.ID = SQ.Question_ID
	AND Q.crs_id = @courseId
	AND SQ.Std_ID = @studentId
return
studentExamAnswers 1,1


--Report Takes Instructor ID and Return His Courses With Students Number in it 
create proc instructorCoursesDetails
(@instructorId int)
	as
	SELECT C.name as Course , COUNT(SC.student_id) as Student_Count
	FROM Course C , Student_takes_Courses SC , Instructor_teaches_Courses IC
 	WHERE C.ID = IC.crs_id
	AND C.ID = SC.crs_id 
	AND IC.ins_id = @instructorId
	GROUP BY C.name
	--INNER JOIN   Instructor_teaches_Courses ON Course.ID = Instructor_teaches_Courses.crs_id
	--WHERE Instructor_teaches_Courses.ins_id = @instructorId
	return

	instructorCoursesDetails 1


--Report That Takes Department ID And Return all Students Data
create proc departmentStudents
(@departmntID int)
as
SELECT * FROM Student WHERE dept_id = @departmntID
return

departmentStudents 1

--Report That Takes Student ID and return His Degree in all Courses

create proc studentGrades 
(@studntID int)
as 
SELECT C.name as Course , SC.grade as Grade 
FROM Course as C , Student_takes_Courses AS SC
WHERE C.ID = SC.crs_id
AND SC.student_id = @studntID
return

studentGrades 1