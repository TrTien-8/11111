create database ql_ktx
delete ql_ktx
use ql_ktx

create table nhanvien(manv char(10) primary key, hoten nvarchar(50), ngaysinh date, gioitinh nvarchar(50), dienthoai varchar(12))
create table nhaktx(manha char(10) primary key, tennha nvarchar(50), manv char(10) references nhanvien(manv) not null, soluongphong int)
create table phongo(maphong char(10) primary key, manha char(10) not null references nhaktx(manha), soluongcho int check (soluongcho >= 0 and soluongcho <= 15))
create table sinhvien(masv char(10) primary key, hoten nvarchar(50), lop nvarchar(50), khoa nvarchar(50), ngaysinh date, gioitinh nvarchar(50))
create table phanphongo(namhoc char(10), maphong char(10) not null references phongo(maphong), masv char(10) not null references sinhvien(masv), tungay date, denngay date)

insert into nhanvien values('nv1', N'Hùng', '1997-03-04', N'Nam', 0123456789)
insert into nhanvien values('nv2', N'Lan', '1998-07-04', N'Nữ', 04567891654)
insert into nhanvien values('nv4', N'Tuấn', '2000-04-01', N'Nam', 04518164946) 
insert into nhanvien values('nv5', N'Cường', '1974-06-08', N'Nam', 01587941256)
insert into nhanvien values('nv6', N'Hương', '1978-08-04', N'Nữ', 01254789654)
insert into nhanvien values('nv7', N'Hường', '1983-03-04', N'Nữ', 012547896512)

insert into sinhvien values('sv01', N'Loan', 'KHMT62A', N'Công nghệ thông tin', '2000-03-09', N'Nữ')
insert into sinhvien values('sv02', N'Hương', 'QTKD62', N'Thương mại', '2001-04-03', N'Nữ')
insert into sinhvien values('sv03', N'Hùng', 'CNTT62', N'Công nghệ thông tin', '2001-03-08', N'Nam')
insert into sinhvien values('sv04', N'Cường', 'KHMT62B', N'Công nghệ thông tin', '2000-06-01', N'Nam')
insert into sinhvien values('sv05', N'Tuấn', 'TMDT62', N'Công nghệ thông tin', '2000-01-04', N'Nam')
insert into sinhvien values('sv06', N'Uyên', 'TMDT62', N'Thương mại', '2002-04-06', N'Nữ')


insert into phongo values('phong01', 'nha01', 12)
insert into phongo values('phong02', 'nha02', 13)
insert into phongo values('phong03', 'nha03', 14)
insert into phongo values('phong04', 'nha04', 11)
insert into phongo values('phong05', 'nha05', 15)
insert into phongo values('phong06', 'nha06', 10)
insert into phongo values('phong07', 'nha07', 12)

insert into nhaktx values('nha01', N'Nhà A', 'nv1', 5)
insert into nhaktx values('nha02', N'Nhà B', 'nv2', 7)
insert into nhaktx values('nha03', N'Nhà C', 'nv3', 8)
insert into nhaktx values('nha04', N'Nhà D', 'nv4', 6)
insert into nhaktx values('nha05', N'Nhà E', 'nv5', 5)
insert into nhaktx values('nha06', N'Nhà G', 'nv6', 10)
insert into nhaktx values('nha07', N'Nhà H', 'nv7', 9)

insert into phanphongo values('2021-2022', 'phong01', 'sv01','2022-02-03', '2022-04-01')
insert into phanphongo values('2021-2022', 'phong02', 'sv02', '2022-01-07', '2022-03-09')
insert into phanphongo values('2021-2022', 'phong03', 'sv03', '2021-09-08', '2022-09-02')
insert into phanphongo values('2021-2022', 'phong04', 'sv04', '2022-01-07', '2022-03-09')
insert into phanphongo values('2021-2022', 'phong05', 'sv05', '2021-09-08', '2022-09-02')
insert into phanphongo values('2021-2022', 'phong06', 'sv06', '2021-08-09', '2022-04-09')
insert into phanphongo values('2021-2022', 'phong07', 'sv07', '2021-09-08', '2022-09-02')


select * from nhanvien
select * from sinhvien
select * from nhaktx
select * from phanphongo
select * from phongo
-----------------------------câu 2----------------------------
exec sp_help phanphongo



create proc sp_phanphong @namhoc char(10), @masv char(10), @maphong char(10), @tungay date , @denngay date
as
begin 
	if exists(select masv from phanphongo where masv = @masv)
		print N'Sinh viên đã ở ktx'
	else print 'Sinh viên ko ở ktx'
	if  ((select count(*) from phanphongo where @maphong = maphong) = 0)
			print N'Phòng trống'
	else
		begin 
			if((select count(*) from phanphongo where @maphong = maphong) > 15)
				print N'Phòng này đã đủ chỗ'
			else print N'Phòng này chưa đủ chỗ'

			-- if exists (select * from phanphongo as a join sinhvien as b on a.masv = b.masv where b.gioitinh = 1)
			if exists (select * from phanphongo, sinhvien where phanphongo.masv = sinhvien.masv and gioitinh = N'Nam')
				print 'Phòng này cho nam'
			else print 'Phong danh cho nu'
		end
end;

create proc sp_them_phongo (@maphong varchar(10), @manha varchar(10), @soluong int)
as
begin
	if exists (select maphong from phongo where @maphong = maphong)
		print N'Thong tin ma phong nay da co trong he thong'
	else 
		if not exists (select manha from nhaktx where @manha = manha)
		print N'Chua co thong tin ma nha ktx trong he thong'
	else 
		insert into phongo values(@maphong, @manha, @soluong)
end

exec sp_them_phongo 'phong10', 'nha05', 14
select * from phongo


create proc sp_dangkyphongo (@namhoc varchar(30), @maphong varchar(10),
							 @masv varchar(10), @tungay date, @denngay date)
as
begin
	if exists (select masv from phanphongo where @masv = masv)
		print 'Sinh vien da dang ky o ktx'
	if ((select count(*) from phanphongo where @maphong = maphong) = 0)
		print 'Phong chua co sinh vien nao dang ky'
	else
		begin
			if((select count (*) from phanphongo where @maphong = maphong) > 15)
						print 'Phong qua 15 sinh vien'
		end
		insert into phanphongo values (@namhoc, @maphong, @masv, @tungay, @denngay)
end

exec sp_dangkyphongo '2021-2022', 'phong01', 'sv01', '2021-08-09', '2022-06-08'

select * from phanphongo


-------------------------cau 3----------------------------
create view v_qtoktx1
as
select sinhvien.masv, sinhvien.hoten, sinhvien.lop, sinhvien.khoa,
	   sinhvien.ngaysinh, sinhvien.gioitinh, phongo.maphong, phongo.manha
from phanphongo, phongo, sinhvien
where phanphongo.maphong = phongo.maphong and phanphongo.masv = sinhvien.masv

select * from v_qtoktx1


---------------cau 4---------------
create proc sp_thongke1 @option int, @ma varchar(10), @so varchar(30)
as
begin 
	if @option = 1
	begin
		select count(*) as tongsophong from
		(select maphong, count(maphong) as sosv from phanphongo
		where namhoc = @so group by maphong) as a where a.sosv < 15
	end

	if @option = 2
	begin 
		select ((select sum(soluongcho) as tongcho from phongo
		where manha = @ma) -(select count(*) as tongchodao from phanphongo, phongo
		where phanphongo.maphong = phongo.maphong and phongo.manha = @ma)) as sochocontrong
	end
end


select * from nhaktx
select * from phongo
select * from phanphongo






