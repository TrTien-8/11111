create database quanlynhapxuat

use quanlynhapxuat

delete database quanlynhapxuat

create table dmhang (
	mahang char(10) primary key not null,
	tenhang nvarchar(60) not null,
	gianhap float,
	dvt char(10),
	noisx nchar(60),
	giaxuat float,
	ghichu nvarchar(200))

create table dmkhach (
	makhach char(10) primary key not null,
	tenkhach nvarchar(60) not null,
	diachikhach nvarchar(200), 
	dienthoai char(12),
	email char(50),
	sotk1 char(50))


create table dmcungcap (
	mancc char(10) primary key not null,
	tenncc nvarchar(60) not null,
	diachincc nvarchar(200),
	dienthoaincc char(12),
	sotk2 char(50))

drop table phieunhap
create table phieunhap (
	sophieun bigint not null,
	mancc char(10) not null foreign key references dmcungcap(mancc),
	mahang char(10) not null foreign key references dmhang(mahang),
	soluongn bigint,
	ngaynhap date,
	thanhtienn float,
	ghichu nvarchar(200))

drop table phieuxuat  
create table phieuxuat (
	sophieux bigint not null,
	mahang char(10) not null foreign key references dmhang(mahang),
	makhach char(10) not null foreign key references dmkhach(makhach),
	soluongx bigint,
	ngayxuat date,
	thanhtienx float,
	ghichu nvarchar(200))


insert into dmhang values ('mh01', 'CoCaCoLa', '200000', 'VND', N'Hà Nội', '300000', null)
insert into dmhang values ('mh02', N'Kẹo Orion', '100000', 'VND', N'Hà Nam', '200000', null)
insert into dmhang values ('mh03', N'Mứt', '300000', 'VND', N'Hà Tây', '400000', null)
insert into dmhang values ('mh04', 'Bim Bim', '100000', 'VND', N'Hồ Chí minh', '200000', null)
insert into dmhang values ('mh05', N'Nước Cam', '400000', 'VND', N'Nam Định', '500000', null)
insert into dmhang values ('mh06', N'Kẹo mềm', '300000', 'VND', N'Hà Nội', '500000', null)
insert into dmhang values ('mh07', N'Bánh Trung Thu', '300000', 'VND', N'Sơn Tây', '600000', null)

insert into dmkhach values ('mk01', N'Tuấn', N'Hà Nam', '0123454321', 'tuan@gmail.com', '0123456')
insert into dmkhach values ('mk02', N'Minh', N'Hà Nội', '0987678765', 'minh@gmail.com', '1234324')
insert into dmkhach values ('mk03', N'Uyên', N'Tuyên Quang', '0987898789', 'uyen@gmail.com', '3453654')
insert into dmkhach values ('mk04', N'Hà', N'Nam Định', '0123432432', 'ha@gmail.com', '4563746')
insert into dmkhach values ('mk05', N'Hồng', N'Thái Nguyên', '0987656543', 'hong@gmail.com', '9876787')
insert into dmkhach values ('mk06', N'Thảo', N'Sơn Tây', '0987676545', 'thao@gmail.com', '6765456')
insert into dmkhach values ('mk07', N'Phương', N'Vĩnh Phúc', '0981234232', 'phuong@gmail.com', '9878909')


insert into dmcungcap values ('ncc01', N'Hữu Nghị', N'Hà Nội', '0987654543', '0987543')
insert into dmcungcap values ('ncc02', N'Hải Tiến', N'Hà Nam', '0989898989', '2346784')
insert into dmcungcap values ('ncc03', N'Bibica', N'Sơn Tây', '0123212121', '4567657')
insert into dmcungcap values ('ncc04', N'Bảo Minh', N'Hồ Chí Minh', '0987676767', '8767656')
insert into dmcungcap values ('ncc05', N'Hải Hà', N'Hà Nội', '012343232', '8765657')
insert into dmcungcap values ('ncc06', N'Hải Châu', N'Hà Nội', '0765656565', '8787675')
insert into dmcungcap values ('ncc07', N'Tràng An', N'Quảng Nam', '0768767878', '9876543')

insert into phieunhap values (200, 'ncc01', 'mh01', 20000, '2021-12-09', null, null)
insert into phieunhap values (400, 'ncc02', 'mh02', 10000, '2021-10-01', null, null)
insert into phieunhap values (300, 'ncc03', 'mh03', 15000, '2021-02-09', null, null)
insert into phieunhap values (500, 'ncc04', 'mh04', 25000, '2021-05-06', null, null)
insert into phieunhap values (200, 'ncc05', 'mh05', 12000, '2021-03-01', null, null)
insert into phieunhap values (400, 'ncc06', 'mh06', 13000, '2021-04-09', null, null)
insert into phieunhap values (200, 'ncc07', 'mh07', 20000, '2021-02-04', null, null)

insert into phieuxuat values (150, 'mh01', 'mk01',10000, '2022-04-01', null, null)
insert into phieuxuat values (150, 'mh02', 'mk02',10000, '2022-01-01', null, null)
insert into phieuxuat values (150, 'mh03', 'mk03',10000, '2022-02-02', null, null)
insert into phieuxuat values (150, 'mh04', 'mk04',10000, '2022-04-04', null, null)
insert into phieuxuat values (150, 'mh05', 'mk05',10000, '2022-04-03', null, null)
insert into phieuxuat values (150, 'mh06', 'mk06',10000, '2022-04-01', null, null)
insert into phieuxuat values (150, 'mh07', 'mk07',10000, '2022-02-09', null, null)

select * from dmhang
select * from dmkhach
select * from dmcungcap
select * from phieunhap
select * from phieuxuat
-------------cau 2 --------------------
exec sp_help phieuxuat 

create or alter proc sp_themphieuxuat @sophieux bigint, @mahang char(10), @makhach char(10), @soluongx bigint, @ngayxuat date, @thanhtienx float, @ghichu nvarchar(400)
as begin
if exists (select * from phieuxuat where @mahang = mahang and @makhach = makhach)
	print N'Phiếu xuất này đã có trong bảng'
else if (not exists (select mahang from dmhang where @mahang = mahang))
	print N'Mã hàng này chưa có trong bảng'
else if (not exists (select makhach from dmkhach where @makhach = makhach))
	print N'Mã khách này chưa có trong bảng'
else 
	insert into phieuxuat values (@sophieux, @mahang, @makhach, @soluongx, @ngayxuat, @thanhtienx, @ghichu)
end

exec sp_themphieuxuat 150, 'mh01', 'mk09',10000, '2022-06-06', null, null
exec sp_themphieuxuat 150, 'mh01', 'mk07',10000, '2022-06-06', null, null
select * from phieuxuat
delete from phieuxuat where mahang = 'mh01' and makhach = 'mk07'
drop procedure sp_themphieuxuat



exec sp_help phieunhap	
create or alter proc sp_themphieunhap @sophieun bigint, @mancc char(10), @mahang char(10), @soluongn bigint, @ngaynhap date, @thanhtienn float, @ghichu nvarchar(400)
as begin
if exists (select * from phieunhap where @mancc = mancc and @mahang = mahang)
	print N'Phiếu nhập này đã có trong bảng'
else if (not exists (select mancc from dmcungcap where @mancc = mancc))
	print N'Mã nhà cung cấp này chưa có trong bảng'
else if (not exists (select mahang from dmhang where @mahang = mahang))
	print N'Mã hàng này chưa có trong bảng'
else 
	insert into phieunhap values (@sophieun, @mancc, @mahang, @soluongn, @ngaynhap, @thanhtienn, @ghichu)
end

select * from phieunhap
exec sp_themphieunhap '200', 'ncc02', 'mh01', 25000, '2021-05-06', null, null
exec sp_themphieunhap '200', 'ncc09', 'mh01', 25000, '2021-05-06', null, null
delete from phieunhap where mahang = 'mh01' and mancc = 'ncc02'
drop procedure sp_themphieunhap


-----cau 3 y 2---------
exec sp_help phieuxuat
create or alter VIEW thongtin AS
SELECT  sophieux, phieuxuat.mahang, phieuxuat.makhach ,soluongx, ngayxuat, thanhtienx, phieuxuat.ghichu
FROM phieuxuat, dmhang, dmkhach
where phieuxuat.mahang = dmhang.mahang and phieuxuat.makhach = dmkhach.makhach and month(ngayxuat) = 6 and year(ngayxuat) = 2022

select * from thongtin

-----cau 3 y 1-------
create or alter view thongtin1 as
select dmcungcap.mancc, tenncc, diachincc, dienthoaincc, sotk2, sophieun, phieunhap.mahang, soluongn, ngaynhap, thanhtienn, phieunhap.ghichu
from dmcungcap, phieunhap
where dmcungcap.mancc = phieunhap.mancc

select * from thongtin1


-----------cau 4 y 1-----------
create proc sp_thanhtien
as
begin 
	update phieunhap set thanhtienn = soluongn * gianhap
	from dmhang where phieunhap.mahang = dmhang.mahang
end

exec sp_thanhtien
select * from phieunhap


-----------cau 4 y 2-----------
create or alter proc sp_thongke @mahang char(10)
as
begin
	select mahang, year(ngayxuat) as nam, sum(soluongx) as soluong
	from phieuxuat
	group by mahang, year(ngayxuat)
	having mahang = @mahang
end

exec sp_thongke @mahang	= 'mh01'



---------------cau 5 --------------
create trigger trg_tinhtoan8 on phieuxuat after insert
as
begin
	update phieuxuat set thanhtienx = soluongx * giaxuat 
	from dmhang
	where phieuxuat.mahang = dmhang.mahang
end


exec sp_themphieuxuat 150, 'mh01', 'mk06',10000, '2022-06-09', null, null
select * from phieuxuat

enable trigger trg_tinhtoan8
disable trigger trg_tinhtoan8
