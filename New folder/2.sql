create database quanlymaybay1
use quanlymaybay1

create table hanhkhach (
	makhach char(10) primary key not null,
	tenkhach nvarchar(30) not null,
	diachi nvarchar(30) not null,
	dienthoai varchar(12) unique check (dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
	scmt varchar(12)
)

create table tuyenbay (
	matb char(10) primary key not null,
	noidi nvarchar(30) not null,
	noiden nvarchar(30) not null,
	thoigian int not null,
	giatien_1 float,
	giatien_2 float,
)
drop table vebay
create table vebay (
	sove int primary key not null,
	makhach char(10) references hanhkhach(makhach) not null,
	matb char(10) references tuyenbay(matb) not null,
	loai char(10),
	tinhtrang char(20),
	ngaydi date,
)

----------------------cau 2 : nhap du lieu
insert into hanhkhach values ('kh01', N'Hương', N'Hà Nội', '0123432314', '453672435364')
insert into hanhkhach values ('kh02', N'Hải', N'Lạng Sơn', '0125478945', '153654789654')
insert into hanhkhach values ('kh03', N'Hà', N'Hà Nam', '0125698745', '023654789654')
insert into hanhkhach values ('kh04', N'Thảo', N'Hải Dương', '0236547854', '023654789654')
insert into hanhkhach values ('kh05', N'Trang', N'Nam Định', '0236547851', '023654789654')
insert into hanhkhach values ('kh06', N'Hùng', N'Sơn La', '0215423654', '023658963254')
insert into hanhkhach values ('kh07', N'Tuấn', N'Vĩnh Phúc', '0123654789', '023658965423')
insert into hanhkhach values ('kh08', N'Phương', N'Cao Bằng', '0256945678', '025896325896')


insert into tuyenbay values ('tb01', N'Hà Nội', 'Hồ Chí Minh','200', '1', '1')
insert into tuyenbay values ('tb02', N'Hà Nội', 'Đà Nẵng','300', '1', '1')
insert into tuyenbay values ('tb03', N'Hà Nội', 'Lâm Đồng','100', '1', '1')
insert into tuyenbay values ('tb04', N'Hà Nội', 'Đắc Lắc','400', '1', '1')
insert into tuyenbay values ('tb05', N'Hà Nội', 'Phú Quốc','400', '1', '1')
insert into tuyenbay values ('tb06', N'Hà Nội', 'Nghệ An','100', '1', '1')

insert into vebay values ('01', 'kh01', 'tb01', '1', '3', '2022-06-01')
insert into vebay values ('02', 'kh02', 'tb02', '2', '2', '2022-05-02')
insert into vebay values ('03', 'kh03', 'tb03', '1', '3', '2022-03-01')
insert into vebay values ('04', 'kh04', 'tb04', '2', '1', '2022-04-01')
insert into vebay values ('05', 'kh05', 'tb05', '1', '2', '2022-07-01')
insert into vebay values ('06', 'kh06', 'tb06', '1', '1', '2022-10-02')


select * from hanhkhach
select * from tuyenbay
select * from vebay

create or alter view v_sotien
as
select case when vebay.loai = '1' then tuyenbay.giatien_1 else tuyenbay.giatien_2 end
as
sotien, vebay.matb, loai, tinhtrang, ngaydi from vebay, tuyenbay where vebay.matb = tuyenbay.matb

select sum(sotien) as tien from v_sotien 
where tinhtrang = 2 and month(ngaydi) = 5 and year(ngaydi) = 2022

alter view v_tinhtien 
as
	select hanhkhach.makhach, tenkhach, diachi, dienthoai, scmt, vebay.matb, sove, loai, tinhtrang, ngaydi, noidi, noiden, thoigian, giatien_1, giatien_2
	from vebay, hanhkhach, tuyenbay
	where hanhkhach.makhach = vebay.makhach and tuyenbay.matb = vebay.matb and month(ngaydi) = 5 and year(ngaydi) = 2022 and tinhtrang = 2

SELECT * FROM v_tinhtien


drop function f_tinhtien
create function f_tinhtien()
returns float
as
begin
	declare @tongtien float, @tien1 float, @tien2 float
	select @tien1 = sum(giatien_1 * sove) from v_tinhtien where loai = '1'
	select @tien2 = sum(giatien_2 * sove) from v_tinhtien where loai = '2'
	set @tongtien = @tien1 + @tien2

	return @tongtien
end

SELECT dbo.f_tinhtien() AS tongtien







