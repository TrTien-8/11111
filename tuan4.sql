create database chamcong 
use chamcong

create table donvi (
	madv varchar(10) primary key,
	tendv nvarchar(50) not null,
	diachi nvarchar(50) not null,
	dienthoai varchar(10))

create table nhanvien (
	manv varchar(10) primary key,
	madv varchar(10) not null foreign key references donvi(madv),
	hoten nvarchar(30) not null, ngaysinh smalldatetime not null,
	gioitinh nvarchar(3) not null,
	diachi nvarchar(50) not null,
	dienthoai varchar(10), chucvu nvarchar(30) not null)

create table chamcong (
	manv varchar(10) not null foreign key references nhanvien(manv),
	thang int check(thang > 0 and thang < 13) not null, songaycong float check (songaycong >= 0 and songaycong <= 26) not null,
	songaynghicophep float check (songaynghicophep >= 0 and songaynghicophep <= 10) not null)

insert into donvi values ('dv01', N'Đơn vị 1', N'Hà Nội', '0123456789')
insert into donvi values ('dv02', N'Đơn vị 2', N'Hà Nam', '0864536765')
insert into donvi values ('dv03', N'Đơn vị 3', N'Tây Ninh', '0983456724')
insert into donvi values ('dv04', N'Đơn vị 4', N'Nam Định', '0987897654')
insert into donvi values ('dv05', N'Đơn vị 5', N'Lạng Sơn', '0989878765')
insert into donvi values ('dv06', N'Đơn vị 6', N'Hà Nội', '0123452342')
insert into donvi values ('dv07', N'Đơn vị 7', N'Nam Định', '0145676543')
insert into donvi values ('dv08', N'Đơn vị 8', N'Hà Nội', '0145365342')

insert into nhanvien values ('nv01', 'dv01', N'Nguyễn Văn A', '1987-09-18', N'Nam', N'Hà Nội', '0987989898', N'Nhân Viên')
insert into nhanvien values ('nv02', 'dv02', N'Nguyễn Văn B', '1957-09-18', N'Nữ', N'Hà Nam', '0987654567', N'Trưởng Phòng')
insert into nhanvien values ('nv03', 'dv03', N'Nguyễn Văn C', '1997-09-18', N'Nam', N'Hà Nội', '0134567887', N'Phó Phòng')
insert into nhanvien values ('nv04', 'dv04', N'Nguyễn Văn D', '1981-09-18', N'Nữ', N'Hà Nam', '0123456765', N'Tổ Trưởng')
insert into nhanvien values ('nv05', 'dv05', N'Nguyễn Văn E', '1989-09-18', N'Nam', N'Hà Nội', '0123478765', N'Nhân Viên')
insert into nhanvien values ('nv06', 'dv06', N'Nguyễn Văn G', '1967-09-18', N'Nữ', N'Hà Nam', '0123457765', N'Nhân Viên')
insert into nhanvien values ('nv07', 'dv07', N'Nguyễn Văn H', '1980-09-18', N'Nam', N'Hà Nội', '0135654345', N'Nhân Viên')
insert into nhanvien values ('nv08', 'dv08', N'Nguyễn Văn K', '1984-09-18', N'Nữ', N'Hà Nam', '012654565', N'Nhân Viên')


insert into chamcong values ('nv01', 3, 23, 0)
insert into chamcong values ('nv02', 4, 22, 0)
insert into chamcong values ('nv03', 3, 23, 0)
insert into chamcong values ('nv04', 6, 21, 0)
insert into chamcong values ('nv05', 2, 23, 0)
insert into chamcong values ('nv06', 8, 20, 0)
insert into chamcong values ('nv07', 6, 23, 0)
insert into chamcong values ('nv08', 3, 24, 0)

select * from donvi
select * from nhanvien
select * from chamcong

-------------câu 1: viết thủ tục sửa thông tin chấm công, kiểm tra các ràng buộc----------
--update chamcong
	--set thang = @thang, songaycong = @songaycong, songaynghicophep = @songaynghicophep where @manv = manv


create proc sp_suachamcong @manv varchar(10), @thang int, @songaycong float, @songaynghicophep float
as begin
if not exists (select * from chamcong where @manv = manv)
	print N'Ma nv nay ko ton tai'
else if (@songaycong < 0 or @songaycong > 26)
	print 'So ngay cong ko hop le'
else if (@songaynghicophep < 0 or @songaynghicophep > 10)
	print 'So ngay nghi ko hop le'
else 
	update chamcong
	set thang = @thang, songaycong = @songaycong, songaynghicophep = @songaynghicophep where @manv = manv
end

exec sp_suachamcong 'nv01', 4, 25, 0
delete from chamcong where manv = 'nv01'
select * from chamcong

----------------------------tao thu tuc them ban ghi trong bang donvi 
exec sp_help donvi

create proc sp_khachhang @madv varchar(10), @tendv nvarchar(100), @diachi nvarchar(100), @dienthoai varchar(10)
as
begin 
	if exists (select madv from dobvi where madv = @madv) -- kiểm tra khóa chính exists
		print N'Mã don vi này đã có trong bảng'
	else 
		insert into donvi values (@madv, @tendv, @diachi, @dienthoai)
end;






















-------------------cau 2: tạo view tính lương theo số ngày công của các nhân viên - có nghỉ phép , không nghỉ phép, tất cả

create view v_luongcb1 as -- cos phep
select nhanvien.manv, nhanvien.hoten, nhanvien.madv, thang, songaycong, songaynghicophep, (songaycong * 100000 + songaynghicophep * 50000) as 'Tien luong'
from nhanvien, chamcong where nhanvien.manv = chamcong.manv and songaynghicophep > 0

select * from v_luongcb1


create view v_luongcb2 as --tat ca 
select nhanvien.manv, nhanvien.hoten, nhanvien.madv, thang, songaycong, songaynghicophep, (songaycong * 100000 + songaynghicophep * 50000) as 'Tien luong'
from nhanvien, chamcong where nhanvien.manv = chamcong.manv 

select * from v_luongcb2

create view v_luongcb3 as --tat ca 
select nhanvien.manv, nhanvien.hoten, nhanvien.madv, thang, songaycong, songaynghicophep, (songaycong * 100000 + songaynghicophep * 50000) as 'Tien luong'
from nhanvien, chamcong where nhanvien.manv = chamcong.manv and songaynghicophep = 0

select * from v_luongcb3


---------------vieets cau lenh tong luong theo tung phong ban
select madv, sum([tien luong]) as tong
from v_luongcb2 group by madv


select madv, count(manv) as soluong
from nhanvien
group by madv
having count(madv) > 1

-----thu tuc tinh luong theo 2 option: =1 thi tinh theo ma nhan vien, = 2 tinh luong theo ma don vi
-----tinh luong theo so ngay cong cua cac nhan vien - co nghi phep
-----ngay cong 100.000 ngay phep 50000

create proc sp_tinhtien @option int, @ma varchar(10), @thang int
as
begin 
	if @option = 1
		select nhanvien.manv, nhanvien.hoten, nhanvien.madv, thang, songaycong, songaynghicophep, (songaycong * 100000 + songaynghicophep * 50000) as 'tien luong'
		from nhanvien, chamcong where nhanvien.manv = chamcong.manv and @ma = nhanvien.manv and @thang = thang
	if @option = 2
		select nhanvien.manv, nhanvien.hoten, nhanvien.madv, thang, songaycong, songaynghicophep, (songaycong * 100000 + songaynghicophep * 50000) as 'tien luong'
		from nhanvien, chamcong where nhanvien.manv = chamcong.manv and @ma = nhanvien.madv and @thang = thang
	else 
		print 'lua chon ko hop le'
end

exec sp_tinhtien 1, 'nv01', 3
exec sp_tinhtien 2, 'dv1', 4

------------------------------trigger them du lieu bang cham cong

create trigger suachamcong on chamcong after update
as
begin
	update chamcong set manv = inserted.manv, thang = inserted.thang,
		   songaycong = inserted.songaycong, songaynghicophep = inserted.songaynghicophep
	from chamcong, inserted
	where inserted.manv = chamcong.manv and inserted.thang = chamcong.thang and inserted.songaycong = chamcong.songaycong
		  and inserted.songaynghicophep = chamcong.songaynghicophep
end



select * from chamcong




















