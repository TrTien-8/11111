create database de06
use de06

create table dmhang (
	mahang char(10) primary key not null,
	tenhang nvarchar(200) not null,
	gianhap float not null,
	dvt char(10) not null,
	noisanxuat nvarchar(200) not null,
	giaxuat float not null,
	ghichu nvarchar(200) not null)

create table dmkhach (
	makhach char(10) primary key not null,
	tenkhach nvarchar(200) not null,
	diachikhach nvarchar(200) not null,
	dienthoai char(10) not null,
	email char(30) not null,
	sotk1 char(20) not null)

create table dmcungcap (
	mancc char(10) primary key not null,
	tenncc nvarchar(200) not null,
	diachincc nvarchar(200) not null,
	dienthoaincc char(10) not null,
	sotk2 char(20) not null)

create table phieunhap (
	sophieun bigint not null,
	mancc char(10) not null foreign key references dmcungcap(mancc),
	mahang char(10) not null foreign key references dmhang(mahang),
	soluongn bigint not null,
	ngaynhap date not null,
	thanhtienn float,
	ghichu nvarchar(200))

create table phieuxuat (
	sophieux bigint not null,
	mahang char(10) not null foreign key references dmhang(mahang),
	makhach char(10) not null foreign key references dmkhach(makhach),
	soluongx bigint not null,
	ngayxuat date not null,
	thanhtienx float,
	ghichu nvarchar(200))

insert into dmhang values ('mh01', N'Nước Ngọt', '200', 'VND', N'Hà Nội', '250','')
insert into dmhang values ('mh02', N'Kẹo', '100', 'VND', N'Hà Nam', '150','')
insert into dmhang values ('mh03', N'Mứt', '150', 'VND', N'Hải Phòng', '250','')
insert into dmhang values ('mh04', N'Kem', '250', 'VND', N'Sơn Tây', '350','')
insert into dmhang values ('mh05', N'Bim Bim', '120', 'VND', N'Việt Trì', '200','')
insert into dmhang values ('mh06', N'Bánh', '130', 'VND', N'Vĩnh Phúc', '160','')
insert into dmhang values ('mh07', N'Kẹo dẻo', '200', 'VND', N'Nam Định', '250','')
insert into dmhang values ('mh08', N'Kẹo cứng', '220', 'VND', N'Hà Nội', '270','')

insert into dmkhach values ('mk01', N'Tuấn', N'Hà Nội', '0123456789', 'tuan@gmail.com', '0123456')
insert into dmkhach values ('mk02', N'Uyên', N'Hà Nam', '0214587451', 'uyen@gmail.com', '0258741')
insert into dmkhach values ('mk03', N'Hải', N'Hải Phòng', '0236547896', 'hai@gmail.com', '0236589')
insert into dmkhach values ('mk04', N'Hương', N'Nam Định', '0258741254', 'huong@gmail.com', '0256874')
insert into dmkhach values ('mk05', N'Thảo', N'Tuyên Quang', '0326589632', 'thao@gmail.com', '0256398')
insert into dmkhach values ('mk06', N'Ly', N'Thái Nguyên', '0256874563', 'ly@gmail.com', '0365897')
insert into dmkhach values ('mk07', N'Thủy', N'Bình Định', '0369854712', 'thuy@gmail.com', '0365987')
insert into dmkhach values ('mk08', N'Hùng', N'Sơn Tây', '0236987456', 'hung@gmail.com', '0145698')

insert into dmcungcap values ('ncc01', N'Hữu Nghị', N'Hà Nội', '0254789254', '0125478')
insert into dmcungcap values ('ncc02', N'Hải Tiến', N'Hà Nam', '0254789541', '0215478')
insert into dmcungcap values ('ncc03', N'Long Hải', N'Nam Định', '0125698745', '0236589')
insert into dmcungcap values ('ncc04', N'Kinh Đô', N'Sơn Tây', '0236587456', '0145687')
insert into dmcungcap values ('ncc05', N'Hữu Nghị', N'Vĩnh Phúc', '0236589745', '0236874')
insert into dmcungcap values ('ncc06', N'Long Hải', N'Tuyên Quang', '0256987452', '0236589')
insert into dmcungcap values ('ncc07', N'Hữu Nghị', N'Ba Vì', '0254789254', '0236987')
insert into dmcungcap values ('ncc08', N'Hải Tiến', N'Hà Nội', '0254789254', '0147892')

insert into phieunhap values ('2', 'ncc01', 'mh01', '50', '2021-01-01', null, '')
insert into phieunhap values ('3', 'ncc02', 'mh02', '30', '2021-02-02', null, '')
insert into phieunhap values ('4', 'ncc03', 'mh03', '80', '2021-03-03', null, '')
insert into phieunhap values ('5', 'ncc04', 'mh04', '90', '2021-04-04', null, '')
insert into phieunhap values ('6', 'ncc05', 'mh05', '56', '2021-05-05', null, '')
insert into phieunhap values ('2', 'ncc06', 'mh06', '70', '2021-06-06', null, '')
insert into phieunhap values ('3', 'ncc07', 'mh07', '80', '2021-07-07', null, '')
insert into phieunhap values ('4', 'ncc08', 'mh08', '46', '2021-08-08', null, '')

insert into phieuxuat values ('4', 'mh01', 'mk01', '40', '2022-01-01', null, '')
insert into phieuxuat values ('6', 'mh02', 'mk02', '50', '2022-02-02', null, '')
insert into phieuxuat values ('8', 'mh03', 'mk03', '60', '2022-03-03', null, '')
insert into phieuxuat values ('5', 'mh04', 'mk04', '30', '2022-04-04', null, '')
insert into phieuxuat values ('9', 'mh05', 'mk05', '20', '2022-05-05', null, '')
insert into phieuxuat values ('7', 'mh06', 'mk06', '10', '2022-06-06', null, '')
insert into phieuxuat values ('8', 'mh07', 'mk07', '50', '2022-07-07', null, '')
insert into phieuxuat values ('5', 'mh08', 'mk08', '40', '2022-08-08', null, '')

select * from dmhang
select * from dmkhach
select * from dmcungcap
select * from phieunhap
select * from phieuxuat

------------cau 2----------------
exec sp_help phieuxuat 

create or alter proc sp_themphieuxuat @sophieux bigint, @mahang char(10), @makhach char(10), 
					 @soluongx bigint, @ngayxuat date, @thanhtienx float, @ghichu nvarchar(200)
as 
begin
	if (exists (select * from phieuxuat where @mahang = mahang and @makhach = makhach))
		print N'Mã hàng này đã được xuất'
	if (not exists (select mahang from dmhang where @mahang = mahang))
		print N'Mã hàng này chưa có trong bảng'
	if (not exists (select makhach from dmkhach where @makhach = makhach))
		print N'Mã khách này chưa có trong bảng'
	else 
		insert into phieuxuat values (@sophieux, @mahang, @makhach, @soluongx, @ngayxuat, @thanhtienx, @ghichu)
end

drop proc sp_themphieuxuat

exec sp_themphieuxuat '6', 'mh01', 'mk03', '10', '2022-10-10', null, ''
exec sp_themphieuxuat '6', 'mh01', 'mk01', '10', '2022-10-10', null, ''
exec sp_themphieuxuat '6', 'mh10', 'mk03', '10', '2022-10-10', null, ''
exec sp_themphieuxuat '6', 'mh01', 'mk10', '10', '2022-10-10', null, ''
select * from phieuxuat
delete from phieuxuat where mahang = 'mh01' and makhach = 'mk03'
delete from phieuxuat where sophieux = 6
-------
exec sp_help phieunhap

create or alter proc sp_themphieunhap @sophieun bigint, @mancc char(10), @mahang char(10), 
					 @soluongn bigint, @ngaynhap date, @thanhtienn float, @ghichu nvarchar(200)
as 
begin
	if (exists (select * from phieunhap where @mancc = mancc and @mahang = mahang))
		print N'Mã hàng này đã được nhập'
	if (not exists (select mancc from dmcungcap where @mancc = mancc))
		print N'Mã nhà cung cấp này chưa có trong bảng'
	if (not exists (select mahang from dmhang where @mahang = mahang))
		print N'Mã hàng này chưa có trong bảng'
	else 
		insert into phieunhap values (@sophieun, @mancc, @mahang, @soluongn, @ngaynhap, @thanhtienn, @ghichu)
end

exec sp_themphieunhap '3', 'ncc02', 'mh02', '30', '2021-02-02', null, ''
exec sp_themphieunhap '3', 'ncc02', 'mh09', '30', '2021-02-02', null, ''
exec sp_themphieunhap '3', 'ncc04', 'mh02', '30', '2021-02-02', null, ''
exec sp_themphieunhap '3', 'ncc09', 'mh02', '30', '2021-02-02', null, ''

select * from phieunhap

------------cau 3 ----------
create or alter view thongtin1 as
select dmcungcap.mancc, tenncc , diachincc, dienthoaincc, sotk2, sophieun, phieunhap.mahang, soluongn, 
	   ngaynhap, thanhtienn, ghichu
from dmcungcap, phieunhap
where dmcungcap.mancc = phieunhap.mancc

select * from thongtin1


create or alter view thongtin2 as --câu 3 ý 2
select sophieux, phieuxuat.mahang, phieuxuat.makhach, soluongx, ngayxuat, thanhtienx, phieuxuat.ghichu
from phieuxuat, dmhang, dmkhach
where phieuxuat.mahang = dmhang.mahang and phieuxuat.makhach = dmkhach.makhach and 
	  month(ngayxuat) = 6 and year(ngayxuat) = 2022

select * from thongtin2

---------------cau 4-----------
exec sp_help phieunhap
create or alter proc sp_thanhtien 
as
begin
	update phieunhap set thanhtienn = soluongn * gianhap
	from dmhang where phieunhap.mahang = dmhang.mahang
end

select * from phieunhap
select * from dmhang
exec sp_thanhtien 

create or alter proc sp_thongke @mahang char(10)
as
begin
	select mahang, year(ngayxuat) as nam, sum(soluongx) as soluongx
	from phieuxuat
	group by mahang, year(ngayxuat)
	having mahang = @mahang
end

exec sp_thongke @mahang	= 'mh01'
-------

create or alter proc sp_thongke @mahang char(10)
as
begin
	select mahang, year(ngaynhap) as nam, sum(soluongn) as soluongn
	from phieunhap
	group by mahang, year(ngaynhap)
	having mahang = @mahang
end

exec sp_thongke @mahang	= 'mh01'

----------------cau 5-----------
create or alter trigger trg_tinhtoan6 on phieunhap after insert
as
begin
	update phieunhap set thanhtienn = soluongn * gianhap 
	from dmhang
	where phieunhap.mahang = dmhang.mahang
end

exec sp_themphieunhap '3', 'ncc04', 'mh02', '30', '2021-02-02', null, ''
select * from phieunhap

disable trigger trg_tinhtoan6
enable trigger trg_tinhtoan6



