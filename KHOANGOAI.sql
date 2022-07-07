create database primary1
go
use primary1
go

--drop database primary1

create table bomon
(
	mabomon char(10) primary key,
	ten nvarchar(100) default N'tên bộ môn'
)
go
create table lop
(
	malop char(10) not null,
	ten nvarchar(100) default N'tê lớp'
	primary key(malop)
)
-- điều kiện tạo khóa ngoại
-- tham chiếu tới khóa chính
-- unique, not null
-- cùng kiểu dữ liệu
-- cùng số lượng trường tham chiếu

go
create table giaovien
(
	magiaovien char(10) not null primary key,
	tengiaovien nvarchar(100) default N'tên giáo viên',
	diachi nvarchar(100) default N'địa chỉ giáo viên',
	ngaysinh date,
	gioitinh bit,
	mabomon char(10),
	foreign key(mabomon) references dbo.bomon(mabomon)
)

--alter table dbo.giaovien add primary key(magiaovien)
go
create table hocsinh 
(
	mahocsinh char(10) primary key,
	ten nvarchar(100),
	malop char(10)
)
go
alter table dbo.hocsinh add foreign key(malop) references dbo.lop(malop)

insert into dbo.bomon(mabomon, ten)
values ('BM01', N'Bộ môn 1')
insert into dbo.bomon(mabomon, ten)
values ('BM02', N'Bộ môn 2')
insert into dbo.bomon(mabomon, ten)
values ('BM03', N'Bộ môn 3')
go
insert into dbo.giaovien(magiaovien, tengiaovien, diachi, ngaysinh, gioitinh, mabomon)
values ('GV01', N'GV01', N'DC1', getdate(), 1, 'BM01')

insert into dbo.giaovien(magiaovien, tengiaovien, diachi, ngaysinh, gioitinh, mabomon)
values ('GV02', N'GV02', N'DC1', getdate(), 1, 'BM02')

--truy vấn
select * from dbo.bomon

select mabomon from dbo.bomon
select mabomon as N'Mã bộ môn', ten as N'Tên bộ môn ' from dbo.bomon

select * from dbo.bomon
select * from dbo.giaovien

select * from giaovien, bomon
select gv.magiaovien, bm.ten from dbo.giaovien as gv, dbo.bomon as bm
