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

Select sID, sName, GPA
from Student
where GPA > 3.6;

Select sName, major
from Student, Apply
where Student.sID = Apply.sID;

/* aby pozbyc sie duplikatow dodajemy distinct po select */
Select distinct sName, major
from Student, Apply
where Student.sID = Apply.sID;

Select sName, GPA, decision
from Student, Apply
where Student.sID = Apply.sID
and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

Select distinct College.cName
from College, Apply
where College.cName = Apply.cName
and enrollment > 20000 and major = 'CS';

Select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName;

/* aby nasze wyniki mialy ustalona kolejnosc dodajemy order by*/

Select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName;
order by GPA desc; -- bedziemy sortowac wg GPA i dodatkowo desc oznacza ze malejaco--

/* aby dalej sortowac*/

Select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName;
order by GPA desc, enrollment; --brak desc oznacza ze posortuja sie rosnaco--

/*easy string*/
Select sID, major
from Apply
where major like '%bio%'; --chodzi o to ze zamiast pisac te wszystkie dlugie nazwy z bio w nazwie szukamy czegokolwiek co zawiera to--

Select *
from Apply
where major like '%bio%'; --dostajemy wszystkie kolumny--

Select *
from Student, College;

/* dodawanie kolejnej zmiennej scaled GPA*/
Select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0)
from Student;

/*jak nam sie nie podoba nazwa dodanej zmiennej to ja zmienymy przez as*/
Select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) as ScaledGPA
from Student;
