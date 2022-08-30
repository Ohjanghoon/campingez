-- (관리자계정) spring 일반계정 생성
create user ez
identified by easy123456789A
default tablespace data;

alter user spring quota unlimited on users;
grant connect, resource to ez;
