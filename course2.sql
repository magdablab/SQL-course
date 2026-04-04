/* korzystamy z tej samej tabelki*/

CREATE TABLE college(
    cName VARCHAR2(100),
    state VARCHAR2(50),
    enrollment NUMBER
);
CREATE TABLE Student (
    sID NUMBER,
    sName VARCHAR2(100),
    GPA NUMBER(3,2), --3 cyfry z czego 2 po przecinku
    sizeHS NUMBER
);
CREATE TABLE Apply (
    sID NUMBER,
    cName VARCHAR2(100),
    major VARCHAR2(100),
    decision VARCHAR2(50)
);
Alter Table College Add PRIMARY Key (cName);
Alter Table Student Add PRIMARY KEy (sID) ;
Alter Table Apply Add Primary Key (sID, cName, major);

Insert into College (cName, state, enrollment) Values ('Stanford', 'CA', 15000);
Insert into College (cName, state, enrollment) Values ('Berkley', 'CA', 36000);
INSERT INTO College (cName, state, enrollment) VALUES ('MIT', 'MA', 10000);
INSERT INTO College (cName, state, enrollment) VALUES ('Cornell', 'NY', 21000);

Select * From College; --gwiazdka to pokaz wszystkie kolumny

INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (123, 'Amy', 3.9, 1000);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (234, 'Bob', 3.6, 1500);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (345, 'Craig', 3.5, 500);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (456, 'Doris', 3.9, 1000);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (567, 'Edward', 2.9, 2000);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (678, 'Fay', 3.8, 200);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (789, 'Gary', 3.4, 800);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (987, 'Helen', 3.7, 800);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (876, 'Irene', 3.9, 400);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (765, 'Jay', 2.9, 1500);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (654, 'Amy', 3.9, 1000);
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES (542, 'Craig', 3.4, 2000);

Select * From Student;

INSERT INTO Apply (sID, cName, major, decision) VALUES (123, 'Stanford', 'CS', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (123, 'Stanford', 'EE', 'N');
INSERT INTO Apply (sID, cName, major, decision) VALUES (123, 'Berkley', 'CS', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (123, 'Cornell', 'EE', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (234, 'Berkley', 'biology', 'N');
INSERT INTO Apply (sID, cName, major, decision) VALUES (345, 'MIT', 'bioengineering', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (345, 'Cornell', 'bioengineering', 'N');
INSERT INTO Apply (sID, cName, major, decision) VALUES (345, 'Cornell', 'CS', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (345, 'Cornell', 'EE', 'N');
INSERT INTO Apply (sID, cName, major, decision) VALUES (678, 'Stanford', 'history', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (987, 'Stanford', 'CS', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (987, 'Berkley', 'CS', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (876, 'Stanford', 'CS', 'N');
INSERT INTO Apply (sID, cName, major, decision) VALUES (876, 'MIT', 'biology', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (876, 'MIT', 'marine biology', 'N');
INSERT INTO Apply (sID, cName, major, decision) VALUES (765, 'Stanford', 'history', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (765, 'Cornell', 'history', 'N');
INSERT INTO Apply (sID, cName, major, decision) VALUES (765, 'Cornell', 'psychology', 'Y');
INSERT INTO Apply (sID, cName, major, decision) VALUES (543, 'MIT', 'CS', 'N');

Select * From Apply;

select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName;

/* mozemy dodac zmienna, aby nie pisac za kazdym razem pełnej nazwy
from Student S, College C, Apply A*/

select S.sID, sName, GPA, A.cName, enrollment
from Student S, College C, Apply A
where A.sID = S.sID and A.cName = C.cName;

/* chcemy uzyskac pare studentow, ktorzy maja takie samo GPA*/

Select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA;

/* chcemy zeby utworzyly nam sie pary roznych osob ze soba za pomoca <>*/
Select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID <> S2.SID;

/* no ale zeby ta sama para nie pojawiala sie dwa razy to <*/
Select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID < S2.SID;

/* union */

Select cName as name from College
union --usuwa duplikaty sam--
select sName as name from Student;

/* jesli chcemy duplikaty to dodajemy all do union*/
Select cName as name from College
union all
select sName as name from Student;

/* sortujemy*/
Select cName as name from College
union all
select sName as name from Student
order by name;

Select sID from Apply where major = 'CS'
intersect
select sID from Apply where major = 'EE'; --czyli jest dwojka uczniow co zaaplikowali i na CS i na EE--

/* drugi sposob na to samo co wyzej*/

Select A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major = 'EE'; --pierwszy warunek mowi ze ma to byc ten sam uczen--

/* distinct zeby pozbyc sie duplikatow bo ktos aplikowal 2 razy w te same miejsca (ten sposob nam to pokaze, poprzedn nie)*/
Select distinct A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major = 'EE'; --pierwszy warunek mowi ze ma to byc ten sam uczen--

/* teraz szukamy uczniow ktorzy zaaplikowali do CS ale nie do EE*/

Select sID from Apply where major = 'CS'
EXCEPT
select sID from Apply where major = 'EE';

/* drugi sposob*/
select distinct A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major <> 'EE'; -- <> chodzi o to ze jest rozny niz EE--
--tu dostaniemy wiecej wynikow niz w poprzednim sposobie, bo wykluczamy EE ale moga byc inne np biology, w 1 sposobie tak nie jest--
