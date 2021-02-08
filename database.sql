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