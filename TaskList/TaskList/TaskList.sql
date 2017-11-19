create database TaskList;
go

use TaskList;
go

create table Employee
(EmployeeID int not null identity primary key,
EmployeeName nvarchar(20) not null)

create table Task
(TaskID int not null identity primary key,
TaskTitle nvarchar(30) not null)

create table [Status]
(StatusID int not null identity primary key,
StatusTitle nvarchar(20) not null)

create table [View]
(ViewID int not null identity primary key,
EmployeeID int not null references Employee(EmployeeID),
TaskID int not null references Task(TaskID),
Comment nvarchar(50) null,
StatusID int not null references [Status](StatusID)
)

create table [ActivityLog]
(ViewID int not null,
EmployeeID int not null,
TaskID int not null,
Comment nvarchar(50) null,
StatusID int not null)

create trigger upd_log on [View] after update as
	insert into [ActivityLog](ViewID, EmployeeID, TaskID, Comment, StatusID)
	select ViewID, EmployeeID, TaskID, Comment, StatusID from deleted

insert Employee
values('Olga'),
('Victoria'),
('Rostyslav'),
('Alina'),
('Natalia'),
('Lilya')

insert [Status]
values ('Preparation of quotation'),
('Review'),
('VAT'),
('Bookkeeping'),
('UFS'),
('Audit'),
('Done')

insert Task
values('Bookkeeping of Statk')

insert [View] (EmployeeID, TaskID, StatusID)
values ((select EmployeeID from Employee where EmployeeName = 'Rostyslav'), (select TaskId from Task where TaskTitle = 'Bookkeeping of Statk'), 4)

