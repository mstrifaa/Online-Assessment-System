 create table users (
        id number primary key,
        fullName varchar2(50),
        username varchar2(50),
        email varchar2(40),
        password varchar2(20),
        constraint identity unique (username, password)
    );

create table loggedInUsers(
        userId number,
        userName varchar2(50),
        foreign key (userId) references users(id)
    );

CREATE SEQUENCE seq_user
        MINVALUE 1
        START WITH 1
        INCREMENT BY 1;

--create table quiz(
	quizCode number primary key,
	title varchar2(100),
	description varchar2(500),
	questions varchar2(4000) not null,
	answers varchar2(2000),
	userId number,
	foreign key (userId) references users(id)
);-- use kortesi na

-- using this one instead--
create table quiz(
	quizCode number primary key,
	quiz varchar2(4000),
	answers varchar2(2000),
	userId number,
	foreign key (userId) references users(id)
);
create sequence seq_quiz
	minvalue 1000
	start with 1000
	increment by 10;
