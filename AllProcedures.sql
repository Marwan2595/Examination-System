/* Data base procedures */
/*================= User Table ===============================*/
/* select */
/* Select all users without parameters */
create proc getUsers
as 
	select * from [User]
	
getUsers

/* Select user using id */
create proc getUserByID @Id int 
as 
	select * from [User]
	where ID = @Id

--getUserByID 7

/* insert User */
create proc createUser @Id int, @username varchar(50), @email varchar(50), @pass varchar(50), @utype bit
as 
	insert into [User] values(@Id, @username, @email, @pass, @utype)

--createUser 6, 'nada123', 'nada123@iti.com', 'nada345', 1

/* Delete User using id */
create proc deleteUser @Id int
as 
	delete from [User] where ID = @Id

--deleteUser 6

/* Update User username using email*/
create proc updateUserName @email varchar(50), @newusername varchar(50)
as 
	begin try
		update [User]
		set username = @newusername
		where email = @email
	end try
	begin catch
		select 'email doesnot exist'
	end catch

--updateUserName 'nada123@iti.com','nada24'

/* ============================== Instructor table ======================= */
/* select */
/* select all instructors */
create proc getAllInstructors 
as 
	select * from [Instructor]

getAllInstructors

/* select instructor using id*/
create proc getInsById @id int
as 
	if exists(select * from [Instructor]
			  where ID = @id)
			  select * from [Instructor]
			  where ID = @id
	else 
		select 'this id doesnot exist'
	

getInsById 4
/* insert */
create proc addIns @id int, @fname varchar(50), @lname varchar(50), @userid int
as 
	if not exists (select * from [Instructor]
				   where ID = @id)
				   insert into [Instructor] values (@id, @fname, @lname, @userid)
	else 
		select 'duplicate Id'

addIns 3, 'Hamed', 'Mahmoud',3
/* delete */
create proc removeIns @id int
as 
	if exists (select * from [Instructor]
				where ID = @id)
				delete from [Instructor] where ID = @id
    else 
		select 'this Id doesnot exist in this table'
removeIns 3

/* update instructor first name using his or her id */
create proc updateInsFname @id int, @fname varchar(25)
as 
	begin try 
		update [Instructor] set firstname = @fname
		where ID = @id
	end try
	begin catch
		select 'This id does not exist here'
	end catch

updateInsFname 3,'Sara'

/* ============================== Students table ======================= */
/* select */
/* select all students */

create proc getAllStudents
as 
	select * from [Student]

getAllStudents

/* select students using id*/
create proc getStudentByID @id int 
as 
	if exists(select * from Student where ID = @id)
		select * from [Student]
		where ID = @id
	else 
		select 'Sorry This ID is not here' as 'message'

getStudentByID 5
/* insert */
create proc addStd @id int,@fname varchar(20),@lname varchar(20),@userid int,@deptid int
as 
	if not exists(select * from [Student] where ID = @id)
		insert into Student values(@id,@fname,@lname,@userid,@deptid)
	else 
		select 'Sorry Duplicate Id' as 'message'

addStd 4,'Nada','Mamdouh',6,1

/* delete */
create proc deleteStd @id int
as 
	if exists(select * from [Student] where ID = @id)
		delete from [Student] where ID = @id
	else 
		select 'Sorry this id does not exist here' as 'message'

deleteStd 4
/* update student first name using his or her id */
create proc updateStdFname @id int, @fname varchar(25)
as
	if exists(select * from [Student] where ID = @id)
		update [Student] set firstname = @fname
		where ID = @id
	else 
		select 'Sorry this id does not exist here' as 'message'

updateStdFname 4,'Nada'

/* ============================== Questions table ======================= */
/* select */
/* select all data about Questions */
create proc getAllAboutQuestions
as 
	select * from Question

getAllAboutQuestions
/* select all Questions */
create proc getAllQuestions
as 
	select body,correct_answer,a2,a3,a4,type_of_question,crs_id from Question

getAllQuestions
/* select Questions using id*/
create proc getQuestById @id int 
as 
	if exists (select * from Question where ID = @id)
		select * from Question 
		where ID = @id
	else 
		select 'Sorry this Id does not exist here'

getQuestById 45
/* insert */
create proc addQuest @id int, @questBody varchar(500), @correctans varchar(100), @anstwo varchar(100), @ansthree varchar(100), @ansfour varchar(100), @questtype bit, @crsid int
as 
	if not exists (select * from Question where ID = @id)
		insert into Question values(@id, @questBody, @correctans,@anstwo,@ansthree,@ansfour,@questtype,@crsid)
	else 
		select 'Sorry, Duplicate Id' as 'message'

addQuest 46, 'New question for testing', 'True', 'False', NULL, NULL, 1, 3
/* delete */
create proc deleteQuest @id int
as 
	if exists(select * from Question where ID = @id)
		delete from Question where ID = @id
	else 
		select 'Sorry this id does not exist here ' as 'message'

deleteQuest 46
/* update Question body and answers and question type using it's id */
create proc updateQuest @id int , @QuestBody varchar(500), @ansoone varchar(100), @anstwo varchar(100), @ansthree varchar(100),@ansfour varchar(100), @questtype bit ,@crsid int = 3
as 
	if exists (select * from Question where ID = @id)
		update Question set body = @QuestBody, correct_answer = @ansoone, a2 = @anstwo, a3 = @ansthree, a4 = @ansfour, type_of_question = @questtype
		where ID = @id
	else 
		select 'Sorry this Id does not exist here' as 'message'

updateQuest 46, 'updating question for testing ', 'True','False',NULL,NULL,1


/* ============================== Department table ======================= */
/* select */
/* select all departments */
create proc getAllDepts
as
	select * from Department

getAllDepts

/* select students using id*/
create proc getDeptByID @id int
as 
	if exists ( select * from Department where ID = @id )
		select * from Department
		where ID = @id
	else 
		select 'This id does not exist' as 'message'

getDeptByID 1

/* insert */
create proc addDept @id int, @deptname varchar(25),@mgr_id int
as 
	if not exists(select * from Department where ID = @id)
		insert into Department values(@id, @deptname, @mgr_id)
	else
		select 'Duplicate ID cannot insert' as 'message'

addDept 3,'os',2
/* delete */
create proc deleteDept @id int
as 
	if exists(select * from Department where ID = @id)
		delete from Department where ID = @id
	else 
		select 'sorry, no such ID ' as 'message'

deleteDept 3

/* update student first name using his or her id */
create proc updateDept @id int, @name varchar(25), @mgrid int 
as
	if exists(select * from Department where ID = @id)
			update Department set Name = @name, mgr_id = @mgrid
			where ID = @id
	else 
		select 'Sorry this id does not exist' as 'message'
updateDept 3, 'AI', 2

/* ============================== Course table ======================= */
/* select */
/* select all Courses */

create proc getAllCourses
as 
	select * from Course

getAllCourses
/* select a course using id*/
create proc getCourseById @id int
as
	if exists (select * from Course where ID = @id)
			select * from Course where ID = @id
	else 
		select 'Sorry! this id does not exist' as 'message'
getCourseById 3
/* insert */
create proc addCourse @id int, @crsname varchar(25), @crsduration int
as
	if not exists(select * from Course where ID = @id)
			insert into Course values(@id, @crsname, @crsduration)
	else
		select 'duplicate id, cannot insert' as 'message'

addCourse 4, 'jquery', 20

/* delete */
create proc removeCourse @id int
as
	if exists (select * from Course where ID = @id)
		delete from Course where ID = @id
	else 
		select 'cannot delete! This ID does not exist' as 'message'
removeCourse 4

/* update Course data id */
create proc updateCrsData @id int, @Crsname varchar(25), @crsduration int = 20
as 
	if exists (select * from Course where ID = @id)
			update Course set name = @Crsname, duration = @crsduration 
			where ID = @id
	else 
		select 'This id doesnot exist' as 'message'



updateCrsData 4, 'Java'


/* ============================== Topic table ======================= */
/* select */
/* select all Topics */
create proc getAllTopics
as 
	select * from Topic

getAllTopics

/* select a topic using id*/
create proc getTopicByID @id int
as 
	if exists( select * from Topic where ID = @id)
		select * from Topic where ID = @id
	else 
		select 'ID does not exist' as 'message'
getTopicByID 6

/* insert */
create proc addTopic @id int, @topicname varchar(25), @crsid int
as 
	if not exists ( select * from Topic where ID = @id ) 
		insert into Topic values (@id, @topicname, @crsid)
	else
		select 'duplicate id cannot insert'

addTopic 7, 'Delegates', 3
/* delete */
create proc removeTopic @id int
as 
	if exists ( select * from Topic where ID = @id ) 
		delete from Topic where ID = @id 
	else
		select 'Sorry! this id does not exist ' as 'message'

removeTopic 7

/* update topic name using his or her id */
create proc updateTopicName @id int, @topname varchar(25)
as 
	if exists (select * from Topic where ID = @id) 
		update Topic set name = @topname
		where ID = @id
	else 
		select 'Sorry! This id does not exist' as 'message'

updateTopicName 7,'CallBack functions'
/* ============================== Instructor_teaches_Course table ======================= */
/* select */
/* select all Crouses for each instructor */
create proc getInstructorCourses
as 
	select Course.name  , concat(Instructor.firstname,' ',Instructor.lastname) as [Instructor Name]
	from Course inner join Instructor_teaches_Courses
	on Course.ID = Instructor_teaches_Courses.crs_id
	inner join Instructor 
	on Instructor.ID = Instructor_teaches_Courses.ins_id

getInstructorCourses

/* select courses that each instructor teaches using his id*/
create proc getInsCoursesByInsID @id int
as
	if exists ( select * from Instructor_teaches_Courses where ins_id = @id)
		select Course.name as [Course name]  , concat(Instructor.firstname,' ',Instructor.lastname) as [Instructor Name]
		from Course inner join Instructor_teaches_Courses
		on Course.ID = Instructor_teaches_Courses.crs_id
		inner join Instructor 
		on Instructor.ID = Instructor_teaches_Courses.ins_id
		where ins_id = @id

getInsCoursesByInsID 1

/* insert ( assign new course to instructor with specific id ) */
create proc assignNewCrsToInstructor @insId int, @crsId int
as 
	begin try 
		insert into Instructor_teaches_Courses values (@insId, @crsId)
	end try
	begin catch
		select 'instructor id or course id is not right'
	end catch

/* delete (remove a course from the course list of an instructor )*/
create proc unassignCourseToIns @id int, @crsid int 
as 
	if exists(select * from Instructor_teaches_Courses where ins_id = @id and crs_id = @crsid)
				delete from Instructor_teaches_Courses where ins_id = @id and crs_id = @crsid
	else
		select 'instructor id or course id is not valid'
	

unassignCourseToIns 1, 10

/* update student first name using his or her id */
create proc changeCrsThatInsTeach @id int, @newcrsid int
as
	begin try
		update Instructor_teaches_Courses set crs_id = @newcrsid
		where ins_id = @id
	end try
	begin catch
		select 'The instructor id or course id is invalid' as 'message'
	end catch

changeCrsThatInsTeach 1,1



/* ============================== Instructor_WorksIn_Department table ======================= */
/* select */
/* select all departments an instructor works in  */
create proc getDeptsInsWorksIn @id int
as
	if exists (select * from Instructor_worksIn_Department where ins_id = @id)
		select concat(Instructor.firstname, '  ',Instructor.lastname) as [Instructor name], Department.Name
		from Department inner join Instructor_worksIn_Department
		on Department.ID = Instructor_worksIn_Department.dept_id
		inner join Instructor
		on Instructor.ID = Instructor_worksIn_Department.ins_id
		where Instructor_worksIn_Department.ins_id = @id
	else 
		select 'ins id or crs id is invalid' as 'message'

getDeptsInsWorksIn 3

/* add instructor to a department */
create proc assignInsToDept @deptId int, @insid int
as
	begin try 
		insert into Instructor_worksIn_Department values (@insid,@deptId)
	end try
	begin catch
		select 'invalid crs id or ins id cannot insert' as 'message'
	end catch

assignInsToDept 2,1

/* remove instructor from a particular department */
create proc rmoveInsFromDept @insid int, @deptid int
as 
	if exists(select * from Instructor_worksIn_Department where dept_id = @deptid)
		delete from Instructor_worksIn_Department 
		where dept_id = @deptid and ins_id = @insid
	else
		select 'no such dept id or ins id' as 'message'

rmoveInsFromDept 1,2		

/* update (change the department an instructor works in )*/
alter proc chngeInsDept @insid int, @newdeptid int
as
	if exists(select * from Instructor_worksIn_Department where ins_id = @insid)
		update Instructor_worksIn_Department set dept_id = @newdeptid
		where ins_id = @insid
	else 
		select 'invalid ins_id or dept_id' as 'message'

chngeInsDept 1,1


/* ============================== Student_takes_Courses table ======================= */
/* select */
/* select all courses that a student take and his grade in it*/
create proc getCrsesThatStudentTake @stdid int
as
	if exists ( select * from Student_takes_Courses where Student_takes_Courses.student_id = @stdid)
		select concat(firstname,' ', lastname) as [Student Name] , name, grade
		from Student inner join Student_takes_Courses
		on ID = Student_takes_Courses.student_id
		inner join Course
		on Student_takes_Courses.crs_id = Course.ID
		where Student.ID = @stdid
	else 
		select 'no such student id ' as 'message'

getCrsesThatStudentTake 1

/* insert (student assign or take new courses)*/
create proc addNewCrsToStd @stdid int, @crsid int
as 
	begin try 
		insert into Student_takes_Courses values (@stdid,@crsid,0)
	end try
	begin catch
		select 'cannot insert invalid stdid or crsid' as 'message'
	end catch

addNewCrsToStd 1,3

/* delete (remove a course from the courses a student take )*/
create proc removeFromCrsStdTake @stdid int, @crsToBeRemovedId int
as 
	if exists( select * from Student_takes_Courses where student_id = @stdid and crs_id = @crsToBeRemovedId)
			delete from Student_takes_Courses where student_id = @stdid and crs_id = @crsToBeRemovedId
	else 
		select 'invalid stdid or crsid' as 'message'


removeFromCrsStdTake 1,3

/* update (Change a course that a student takes) */
create proc chngCrsStdTake @stdid int, @newCrsid int
as 
	if exists(select * from Student_takes_Courses where student_id = @stdid)
		update Student_takes_Courses set crs_id = @newCrsid
		where student_id = @stdid
	else 
		select 'invalid student id' as 'message'

chngCrsStdTake 5,3


/* ============================== Students_answer_Questions table ======================= */
/* select */
/* select a student answers to all questions  */
create proc getStdsAnsToSpecQuest @stdid int
as
	if exists(select * from Students_answer_Questions where Std_ID = @stdid)
			select concat(firstname,' ',lastname) as [Student Name],body as [question body],Student_Answer
			from Student inner join Students_answer_Questions
			on ID = Std_ID
			inner join Question
			on Question_ID = Question.ID
			where Std_ID = @stdid
	else
		select 'invalid student id' as 'message'

getStdsAnsToSpecQuest 1


/* insert (Adding student answers to different questions)*/
create proc addNewQuestionAnswer @stdid int, @questid int, @stdAns varchar(100)
as 
	begin try 
		insert into Students_answer_Questions values (@stdid,@questid,@stdAns)
	end try
	begin catch
		select 'cannot insert invalid stdid or questionid' as 'message'
	end catch

addNewQuestionAnswer 1,45,'False'

/* delete (remove student answer for a specific question)*/
create proc  removeStdAnswer @stdid int, @questid int
as
	if exists(select * from Students_answer_Questions where Std_ID = @stdid and Question_ID = @questid)
			delete from Students_answer_Questions where Std_ID = @stdid and Question_ID = @questid
	else
		select 'invalid std id or question id' as 'message'

removeStdAnswer 1,46


/* update student answer for a specific question */

create proc updateStdAnswer @stdid int, @questid int , @newAnswer varchar(100)
as
	if exists(select * from Students_answer_Questions where Std_ID = @stdid and Question_ID = @questid)
			 update Students_answer_Questions set Student_Answer = @newAnswer
			 where Std_ID = @stdid and Question_ID = @questid
	else
			select 'invalid student id or question id' as 'message'

updateStdAnswer 1,45,'True'


--Generate Exam Procedure Takes Course Id and Return 10 Random Question
create proc generateExam
(@course int)
	as
	SELECT TOP 10 * FROM Question WHERE crs_id = @course ORDER BY NEWID()
	return

--exec generateExam 1




--Take Instructor id and Return all Courses He Teach
create proc instructorCourses
(@instructorId int)
	as
	SELECT Course.* FROM Course INNER JOIN   Instructor_teaches_Courses ON Course.ID = Instructor_teaches_Courses.crs_id WHERE Instructor_teaches_Courses.ins_id = @instructorId
	return

 
 --exec instructorCourses 2



 --Take Course id and Return all Student Studying it
 create proc courseStudents
(@courseId int)
	as
	SELECT id , firstname+' '+lastname AS Fullname FROM Student INNER JOIN   Student_takes_Courses ON Student.ID = Student_takes_Courses.student_id WHERE Student_takes_Courses.crs_id = @courseId
	return

 --exec courseStudents 2


 --Add Student Answer
  create proc studentAnswer
(@studentId int , @questionId int , @studentAnswer varchar(100))
	as
	INSERT INTO Students_answer_Questions (Std_ID,Question_ID,Student_Answer)
	VALUES (@studentId,@questionId,@studentAnswer)
	return

--exec studentAnswer 1,1,'asdasd'


--Get Student Answers in Specific  Course Exam
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

--exec studentExamAnswers 3,1

--Store Grade 
create proc updateStudentGrade
(@studentId int , @courseId int , @grade int)
as
	UPDATE Student_takes_Courses 
	SET grade = @grade
	WHERE student_id = @studentId AND crs_id = @courseId
return

--exec updateStudentGrade 1,1,20


--Get Grade
create proc studentGrade
(@studentId int , @courseId int )
as
	SELECT grade FROM Student_takes_Courses
	WHERE student_id = @studentId AND crs_id = @courseId
return

--exec studentGrade 1,1

CREATE PROCEDURE sp_Login
  @email varchar(50),
	@password varchar(50),
	@emailFlag bit out,
	@passwordFlag bit out,
	@userId int out
AS
begin
	select @passwordFlag = 0;
	declare @result table (ID int,username varchar(50),email varchar(50),password varchar(50),user_type bit);
	insert into @result select * from [User] where email=@email;
    select @emailFlag = COUNT(*) from @result;
	if @emailFlag = 1
	begin
		if @password = (select password from @result)
		begin
			select @passwordFlag = 1;
			select @userId = ID from @result;
		end
	end
end


--declare @eflag bit;
--declare @pflag bit;
--declare @id int;
--exec sp_Login @email='ali@iti.com',@password='ali123',@emailFlag = @eflag output,@passwordFlag = @pflag output,@userId = @id output
--select @eflag,@pflag,@id

-------------------------------------------------------------------

create procedure sp_GetUserById
	@id int
as
begin
	select*from [User] where ID=@id
end

--sp_GetUserById 4

-------------------------------------------------------------------

create procedure sp_GetStudentData
	@studentUserId int
as
begin
	select S.ID,firstname,lastname,Name from Student S 
	join Department D on D.ID = S.dept_id 
	where S.user_id = @studentUserId
end

create procedure sp_GetInstructorData
	@instructorUserId int
as
begin
	select * from Instructor S
	where user_id = @instructorUserId
end

--ALTER AUTHORIZATION ON DATABASE::[Examination System] TO sa;
-------------------------------------------------------------------

create procedure sp_GetStudentExams 
	@studentId int
as
begin
	select C.ID,C.name from Student_takes_Courses SC
	join Course C on C.ID = crs_id
	where SC.student_id = @studentId
end



