create database data1
go
use data1
go
create table sinhvien
(
	masv nvarchar(10),
	ten nvarchar(100),
	ngaysinh date
)
go
create table hocsinh
(
	mahs nvarchar(10),
	ten nvarchar(100),
	ngaysinh date
)
go
create table nhanvien
(
	maso int,
	ten nvarchar(10),
	ngaysinh date,
	nam bit,
	diachi nchar(20),
	tienluong float
)
drop table nhanvien
-- insert, delete, update table
insert dbo.nhanvien (maso, ten, ngaysinh, nam, diachi, tienluong)
values (10, N'hải', '1994-02-01', 0, N'hà nội', 100.30)
-- xoa du lieu
delete dbo.nhanvien where maso < 11 and tienluong > 50
-- update du lieu
update dbo.nhanvien set tienluong=100.3, diachi	= 'hà nam' where maso=10




go
alter table hocsinh add ngaysinh date
go
-- xoa du lieu trong bang
truncate table hocsinh

--go bang khoi db
drop table hocsinh

--create database data2
--use data2

--create table lop
--(
--	magv nvarchar(10), 
--	ten nvarchar(100)
--)

-- int: số nguyên
-- float: số thực
-- char: bộ nhớ cấp phát cứng
-- varchar: bộ nhớ cấp phát động: chỉ được lấy khi có dữ liệu
-- nchar: viết được tiếng việt
-- nvarchar: viết được tiếng việt
-- date: lưu trữ ngày tháng năm giờ
-- time: lưu trữ giờ, phút, giây,...
-- bit: lưu giá trị 0 và 1
-- text: lưu văn bản lớn
-- ntext: có tiếng việt


-- khoa chinh 
create table khoachinh
(
	id int unique not null ,
	name nvarchar(100) default N'huhu',
)
drop table khoachinh
alter table dbo.khoachinh add primary key (id)

insert dbo.khoachinh(id) values (1)
insert dbo.khoachinh(id) values (2)
insert dbo.khoachinh(id) values (3)






























