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

select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS'); --studenci ktorzy zaaplikwali na kierunek CS--

/* inny sposob*/
select distinct Student.sID, sName --bo dostajemy duplikaty--
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

/* szukamy tylko imie uczniow ktorzy zaaplikowali gdziekolwiek na CS*/
select sName
from STUDENT
where sID in (select sID from Apply where major = 'CS');

/* innny sposob*/
select distinct sName --znowu mamy kopie--
from Student, Apply
where Student.sID = Apply.sID and major = 'CS'; 

/* tu duplikaty beda miec znaczenie, szukamy jedynie GPA tych ktorzy chca na CS*/
select GPA
from Student
where sID in (select sID from Apply where major = 'CS');

/* inny sposob*/

select GPA
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';
--w ten sposob liczac srednia bralibysmy tych samych uczniow wiecej niz 1 raz--

/* uczniowie ktorzy zaaplikowali na CS ale nie na EE*/
select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS')
and sID not in(select sID from Apply where major = 'EE');
--inny sposob to przesunac not przed sID i da to samo--

/* aby sprawdzic czy subquery jest empty or not
wszystkie uni ktore dziela stan z innym uniwerkiem (all colleges such that some other college is
in the same state)*/
select cName, state
from College C1
where exists (select * from College C2 --drugi uniwerek nazywamy C2--
where C2.state = C1.state);
/*ale ten kod jest bledny, bo C1 moze byc tym samym uni co C2 wiec wszystko moze byc prawdziwe*/

/*naprawiamy to*/
select cName, state
from College C1
where exists (select * from College C2
where C2.state = C1.state and C1.cName <> C2.cName); --<> not equal--

/* najwieksza wartość enrollment*/
select cName
from College C1
where not exists (select * from College C2
where C2.enrollment > C1.enrollment);

/* student z najwiekszym GPA
czyli szukamy takiego studenta ze zaden inny nie ma wyzszego GPA*/
select sName, GPA
from Student C1
where not exists (select * from Student C2
where C2.GPA > C1.GPA);

/* ten sam cel ale bez uzywania subquery*/
select distinct S1.sName, S1.GPA
from Student S1, Student S2
where S1.GPA > S2.GPA;
-- to jest bledne bo szuka wszystkich uczniow dla ktorych ktos jest gorszy--

select sName, GPA
from STUDENT
where GPA >= all (select GPA from Student);
-- czy GPA jest wieksze lub rowne pozostalym GPA--

/* inny sposob
GPA wieksze niz innych, ale nie porownujemy tego samego studenta ze soba*/
select sName
from Student S1
where GPA > all (select GPA from Student S2
where S2.sID <> S1.sID);
--dostajemy nic, bo 4 studentow ma ta sama GPA--

/* ktory uni ma najwieksze enrollment*/
select cName
from College S1
where enrollment > all (select enrollment from College S2
where S2.cName <> S1.cName);

--"any" zamiast "all" you have to satisfy the condition with at least one element of the set--
select cName
from College S1
where not enrollment <= any (select enrollment from College S2
where S2.cName <> S1.cName);
--where it is not the case that the enrollment is less than or equal to any other college--
-- no other college has a bigger enrollment--

/* students not from the smallest high school
greater than any highschool size*/
select sID, sName, sizeHS
from Student
where sizeHS > any (select sizeHS from Student);

/* bez uzycia any*/
select sID, sName, sizeHS
from Student S1
where exists (select * from Student S2
where S2.sizeHS < S1.sizeHS);

/* students who applied to CS but not EE*/
select sID, sName
from Student
where sID = any(select sID from Apply where major = 'CS') --ID rowne tym co zaaplikowali na CS--
and sID <> any (select sID from Apply where major = 'EE'); --ID nierowne tym co na EE--
--bledne, dobre: and not sID = any