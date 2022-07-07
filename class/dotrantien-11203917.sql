create database quanlymaybay
use quanlymaybay

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

create table vebay (
	sove char(10) primary key not null,
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



insert into tuyenbay values ('tb01', N'Hà Nội', 'Hồ Chí Minh','200', '200000', '500000')
insert into tuyenbay values ('tb02', N'Hà Nội', 'Đà Nẵng','300', '300000', '500000')
insert into tuyenbay values ('tb03', N'Hà Nội', 'Lâm Đồng','100', '200000', '600000')
insert into tuyenbay values ('tb04', N'Hà Nội', 'Đắc Lắc','400', '300000', '500000')
insert into tuyenbay values ('tb05', N'Hà Nội', 'Phú Quốc','400', '200000', '600000')
insert into tuyenbay values ('tb06', N'Hà Nội', 'Nghệ An','100', '300000', '500000')


insert into vebay values ('sove01', 'kh01', 'tb01', '1', '3', '2022-06-01')
insert into vebay values ('sove02', 'kh02', 'tb02', '2', '2', '2022-05-02')
insert into vebay values ('sove03', 'kh03', 'tb03', '1', '3', '2022-03-01')
insert into vebay values ('sove04', 'kh04', 'tb04', '2', '1', '2022-04-01')
insert into vebay values ('sove05', 'kh05', 'tb05', '1', '2', '2022-07-01')
insert into vebay values ('sove06', 'kh06', 'tb06', '1', '1', '2022-10-02')


select * from hanhkhach
select * from tuyenbay
select * from vebay

----------------------cau3: tao view thong tin khach hang da di binh thuong trong thang 5 2022

create view v_thongtin
as
select * from tuyenbay where month(ngaydi) = 5 and tinhtrang = 3

select * from v_thongtin


-----------------cau 4: tao view cho biet cac tuyen bay tu ha noi trong nam 2022
create view v_tuyenbay
as
	select tuyenbay.matb, noidi, vebay.ngaydi from tuyenbay, vebay
	where tuyenbay.matb = vebay.matb and year(ngaydi) = '2022' and noidi = N'Hà Nội'

select * from v_tuyenbay


---------------cau 5: xay dung thu tuc them so ve voi ma khach và matb đã có
exec sp_help vebay
exec sp_help tuyenbay
exec sp_help hanhkhach
create proc sp_themsove @sove char(10), @makhach char(10), @matb char(10), @loai char(10), @tinhtrang char(10), @ngaydi date
as
begin 
	if exists (select sove from vebay where sove = @sove) -- kiểm tra khóa chính exists
		print N'Số vé này đã có trong bảng'
	else
		if not exists (select makhach from hanhkhach where makhach = @makhach) --kiểm tra khóa ngoại not exists
			print N'Mã khách này chưa tồn tại'
	else
		if not exists (select matb from tuyenbay where matb = @matb) --kiểm tra khóa ngoại not exists
			print N'Mã tuyến bay này chưa tồn tại'
	else 
		insert into vebay values (@sove, @makhach, @matb, @loai, @tinhtrang, @ngaydi)
end;

exec sp_themsove 'sove09', 'kh01','tb01', '1', '3', '2022-06-01'

select * from vebay
delete from vebay where sove = 'sove09'


----------------------------------câu 6: thong ke so tien cac khach hang tra lai ve trong thang 5 nam 2022
alter view v_sotien
as
select case when vebay.loai = '1' then tuyenbay.giatien_1 else tuyenbay.giatien_2 end
as
sotien, vebay.matb, loai, tinhtrang, ngaydi from vebay, tuyenbay where vebay.matb = tuyenbay.matb

select sum(sotien) as tien from v_sotien 
where tinhtrang = 2 and month(ngaydi) = 5 and year(ngaydi) = 2022

----------------------------------cau 7: viet trigger tinh tong so tien cua 1 tuyen bay khi biet sau khi bo sung, thay doi tinh trang ve

