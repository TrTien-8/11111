-- sum, min,  max

create database quanlidiem

use quanlidiem
drop database quanlidiem

create table lop(malop char(10) primary key, tenlop nvarchar(100), sosv int);
go
create table sv(masv char(10) primary key, tensv nvarchar(50), gioitinh nchar(3),
			 ngaysinh date, malop char(10) references lop(malop) not null, tinh nvarchar(100), hocbong float)
go
create table monhoc(mamh char(10) primary key, tenmh nvarchar(50), sotc int)
go
create table diem(masv char(10) not null references sv(masv), 
			 mamh char(10) not null references monhoc(mamh), diem1 float,
			 diem2 float, diem3 float, diemhp float, primary key(masv, mamh))

exec sp_helpdb quanlidiem -- xem toan bo thong tin CSDL
exec sp_help sv --xem thong tin bang sinh vien
exec sp_help monhoc

alter table monhoc add ghichu nvarchar(50); -- them cot ghi chu
alter table monhoc drop column ghichu; -- xoa cot ghi chu 
exec sp_rename 'monhoc.tongtc', 'sotc', 'column'; --thay doi ten cot

select * from lop;


select * from diem;

drop table lop

insert into lop values('CNTT62A', N'Công nghệ thông tin 62A', 40);
insert into lop values('CNTT62B', N'Công nghệ thông tin 62B', 45);
insert into lop values('KHMT', N'Khoa học máy tính', 50);
insert into lop values('HTTTQL62A', N'HT thong tin quản lý 62A', 50);
insert into lop values('HTTTQL62B', N'HT thong tin quản lý 62B', 50);
insert into lop values('TMDT62A', N'Thương mại điện tử 62A', 60);

select count(malop) as solop from lop;
select malop, tenlop from lop;

insert into monhoc values('TCC', N'Toán cao cấp', 3);
insert into monhoc values('GDTC1', N'Giáo dục thể chất 1', 2);
insert into monhoc values('GDTC2', N'Giáo dục thể chất 2', 3);
insert into monhoc values('VLDC1', N'Vật lý đại cương', 4);
insert into monhoc values('TRR', N'Toán rời rạc', 4);

select * from monhoc
where tenmh like N'T%'; -- tìm kiếm xấp xỉ 

insert into sv values('SV1', N'Trần Văn A', N'Nam' ,'2001-02-04', 'CNTT62A', N'Hà Nội', 0);
insert into sv values('SV2', N'Trần Văn B', N'Nam' ,'2001-11-09', 'CNTT62A', N'Hà Nội', 0);
insert into sv values('SV3', N'Trần Văn c', N'Nữ' ,'2001-05-08', 'CNTT62B', N'Bắc Ninh', 0);
insert into sv values('SV4', N'Trần Văn D', N'Nữ' ,'2001-01-04', 'CNTT62B', N'Hà Nam', 0);
insert into sv values('SV5', N'Trần Văn E', N'Nam' ,'2001-06-03', 'CNTT62A', N'Hải Phòng', 0);

select * from sv;
drop table diem
insert into diem values('SV1', 'TCC', 10, 7, 6, 0)
insert into diem values('SV1', 'GDTC1', 6, 7, 9, 0)
insert into diem values('SV1', 'GDTC2', 8, 7, 5, 0)
insert into diem values('SV1', 'VLDC1', 8, 7, 6, 0)
insert into diem values('SV1', 'TRR', 10, 7, 6, 0)

insert into diem values('SV2', 'TCC', 10, 5, 8, 0)
insert into diem values('SV2', 'GDTC1', 8, 4, 9, 0)
insert into diem values('SV2', 'GDTC2', 8, 7, 5, 0)
insert into diem values('SV2', 'VLDC1', 8, 7, 6, 0)
insert into diem values('SV2', 'TRR', 8, 7, 6, 0)

insert into diem values('SV3', 'TCC', 10, 6, 8, 0)
insert into diem values('SV3', 'GDTC1', 7, 4, 5, 0)
insert into diem values('SV3', 'GDTC2', 8, 9, 5, 0)
insert into diem values('SV3', 'VLDC1', 9, 7, 6, 0)
insert into diem values('SV3', 'TRR', 8, 7, 6, 0)


select * from diem;

insert into diem(masv, mamh, diem1, diem2, diem3) values ('SV3', 'TCC', 10,7,6.5)
delete from diem where masv='SV3' and mamh='TCC'

update diem set diemhp=(diem1*0.1+diem2*0.4+diem3*0.5);
update diem set diemhp=(diem1*0.1+diem2*0.4+diem3*0.5) where masv='SV3';

-- DEM BAO NHIEU SINH VIEN HOC MON GDTC1
-- DEM BAO NHIEU SINH VIEN CO DIEM HOC PHAN >= 7

select count(masv) as soluong from diem where mamh='GDTC1';
select count(masv) as soluong from diem where diemhp >= 7;

-- update lop CNTT62A có 40 sv, CNTT62B có 45 sv, các lớp còn lại có 50 SV
update lop set sosv = '40' where malop='CNTT62A'
update lop set sosv = '45' where malop='CNTT62B'
update lop set sosv = '50' where malop in ('KHMT', 'HTTTQL62A', 'HTTTQL62B', 'TMDT62A')

select * from lop;

---------------------------3/6/2022--------------------------
select * from monhoc
select * from diem

update monhoc set sotc = 3 where mamh = 'GDTC1';
update diem set diemhp=(diem1*0.1+diem2*0.4+diem3*0.5);

update diem set diemhp=(diem1*0.1+diem2*0.2+diem3*0.7)
where mamh = 'GDTC1' or mamh = 'GDTC2'

select count(masv) as soluong from diem where mamh='GDTC1';
select count(masv) as soluong from diem where diemhp >= 7;
update lop set sosv = '55' where malop='CNTT62A'
update lop set sosv = '65' where malop='CNTT62B'
update lop set sosv = '50' where malop in ('KHMT', 'HTTTQL62A', 'HTTTQL62B', 'TMDT62A')
select distinct tensv from sv -- cho ra sự trùng lặp
select tensv from sv
select * from lop
-- có bao nhiêu lớp sinh viên đã nhập học 
select count (malop) from sv
select count (distinct malop) from sv

-- có bao nhiêu sinh viên nhập điểm môn giáo dục thể chất 2
select count (distinct masv) as soluong from diem where mamh = 'GDTC2'
select count (masv) as soluong from diem where mamh = 'GDTC2'

select * from diem where masv = 'SV2'
-- cho biết số lượng môn học của từng sinh viên có điểm 
select masv,count (mamh) as soluong from diem group by masv

-- cho biết những sv có số môn học >= 3
select masv, count (mamh) as soluong from diem
group by masv having count(mamh) >= 3

---------------VIEW--------------------------------
-- sinh viên là nam 
select * from sv where gioitinh = N'Nam'
------
create view v_nam
as
select * from sv where gioitinh = N'Nam'
------
select * from v_nam
------
create view v_nu
as
select * from sv where gioitinh = N'Nữ'

select * from v_nu

create view v_svlop as
(
select sv.masv, tensv, sv.malop, tenlop, gioitinh, ngaysinh, sosv
from sv, lop where lop.malop = sv.malop);

select * from v_svlop
drop view v_svlop
create view v_svlop(masv, ht, malop, tenlop, gt, ns, sosvdk) as
(
select sv.masv, tensv, sv.malop, tenlop, gioitinh, ngaysinh, sosv
from sv, lop where lop.malop = sv.malop);

create view v_diem1 as
(
select sv.masv, tensv, gioitinh, ngaysinh, tinh, hocbong, sv.malop, tenlop, sosv, diem.mamh, tenmh, sotc, diem1, diem2, diem3, 
(diem1*0.1+diem2*0.4+diem3*0.5) as diemhp
from sv, monhoc, diem, lop
where diem.masv = sv.masv and diem.mamh = monhoc.mamh and lop.malop = sv.malop)

select * from v_diem1

select * from sv
-- có bao nhiêu môn học sinh viên đã đăng ký 
-- liệt kê các môn học sinh viên đã đăng ký 

select distinct (mamh) from v_diem1
select count (distinct mamh) as somh from v_diem1
select mamh from v_diem1

-- những môn học có số sv đăng ký nhiều nhất 
select mamh, count (masv) as sv from v_diem1
group by mamh
having count (mamh) >= all
	(select count(mamh) as sl from v_diem1 group by mamh)

-- thống kê những lớp có lượng sinh viên nhiều nhất 
select malop, count (masv) as sv from v_svlop
group by malop
having count (malop) >= all
	(select count(malop) as sl from v_svlop group by malop)

select malop, count (masv) as sv from v_svlop
group by malop
having count (malop) <= all
	(select count(malop) as sl from v_svlop group by malop)

-- tìm kiếm sinh viên sinh năm 2001
select * from v_svlop
select * from v_svlop where year(ns) = 2001
-- áp dụng hàm month để cho biết các thông tin về sinh nhật tháng 1 or tháng 6
-- áp dụng hàm month để cho biết các thông tin về sinh nhật tháng 1 và tháng 6
-- áp dụng hàm month để cho biết các thông tin về sinh nhật tháng 1 năm 2001
-- áp dụng hàm month để cho biết các thông tin về sinh nhật quý 1

select * from v_svlop where month(ns) = 1 or month(ns) = 6
select * from v_svlop where month(ns) = 1 and month(ns) = 6
select * from v_svlop where month(ns) in (1,2,3)

select * from v_svlop where month(ns) = 1 and year(ns) = 2001
select * from v_svlop where month(ns) = 1 or year(ns) = 2001 -- lấy tất cả người sinh năm 2001 và tháng 1

--------------------------10/6/2022-------------------------------\
--tim thang sinh
create proc sp_timthangsinh @thang int 
as
select * from v_svlop where month(ns) = @thang
exec sp_timthangsinh 1

---sua thu tuc
alter proc sp_timthangsinh @nam int 
as
select * from v_svlop where year(ns) = @nam

exec sp_timthangsinh 2001
------tim kiem theo tinh
create proc sp_tinh @tinh nvarchar(200) 
as
select * from sv where tinh like @tinh

exec sp_tinh N'Hà Nội'

exec sp_help sv
exec sp_helptext sp_timthangsinh
----tìm kiếm theo mã lớp
create proc sp_malop @malop char(10)
as
select * from sv where malop = @malop

exec sp_malop 'CNTT62A'
----tìm kiếm theo mã lớp và giới tính
create proc sp_malop1 @malop char(10), @gt nchar(6)
as
select * from sv where malop = @malop and gioitinh = @gt

exec sp_malop1 'CNTT62B', N'Nữ'

select * from sv

--- tìm kiếm theo tên 
create proc sp_ten @ten nvarchar(100)
as
select * from sv where tensv = @ten

exec sp_ten N'Trần Văn A'
---tìm kiếm giới tính và tỉnh

alter proc sp_gioitinh @matinh nvarchar(200), @gt nchar(6)
as
select * from sv where tinh like @matinh and gioitinh = @gt

exec sp_gioitinh N'Hà Nội', 'Nam'

--- thêm bản ghi viết thủ tục
create proc sp_themsv1 @masv char(10), @tensv nvarchar(100), @gioitinh nchar(6), @ngaysinh date, @malop char(10), @tinh nvarchar(200), @hocbong float
as
		insert into sv values (@masv, @tensv, @gioitinh, @ngaysinh, @malop, @tinh, @hocbong)

select * from sv

exec sp_themsv1 'SV10', N'Ly', N'Nữ', '2003-2-3', 'TMDT62A', N'Hà Nam', 0

-------------thủ tục đầy đủ 

alter proc sp_themsv @masv char(10), @tensv nvarchar(100), @gioitinh nchar(6), @ngaysinh date, @malop char(10), @tinh nvarchar(200), @hocbong float
as
begin 
	if exists (select masv from sv where masv = @masv) -- kiểm tra khóa chính exists
		print N'Mã sinh viên này đã có trong bảng'
	else
		if not exists (select malop from lop where malop = @malop) --kiểm tra khóa ngoại not exists
			print N'Mã lớp này chưa tồn tại'
	else 
		insert into sv values (@masv, @tensv, @gioitinh, @ngaysinh, @malop, @tinh, @hocbong)
end;

exec sp_themsv 'SV30', N'Lã Jy', N'Nam', '2003-2-3', 'TMDT23A', N'Hà Nam', 0

---tạo thủ tục insert điểm

alter proc sp_themdiem @masv char(10), @mamh char(10), @diem1 float, @diem2 float, @diem3 float, @diemhp float
as
begin 
if (exists (select * from diem where masv = @masv and mamh = @mamh))
	print N'Môn học này đã được cập nhật điểm'
if (not exists (select masv from sv where masv = @masv))
		print N'Sinh viên này chưa tồn tại'
if (not exists (select mamh from monhoc where mamh = @mamh))
				print N'Môn học này chưa tồn tại'
else 
	insert into diem values (@masv, @mamh, @diem1, @diem2, @diem3, @diemhp)
end;

exec sp_themdiem 'sv1', 'TRR', 8,8,5,0
select * from diem

-----viết thủ tục thêm bảng lớp, bảng môn học

create proc sp_themlop @malop char(10), @tenlop nvarchar(200), @sosv int
as
begin
if (exists (select malop from lop where malop = @malop))
print N'Mã lớp này đã tồn tại trong bảng';
else
insert into lop values(@malop, @tenlop, @sosv)
end;

---viết thủ tục thêm bảng môn học
exec sp_help monhoc
create proc sp_themmonhoc @mamh char(10), @tenmh nvarchar(100), @sotc int
as
begin
if (exists (select mamh from monhoc where mamh = @mamh))
print N'Mã môn học này đã tồn tại trong bảng';
else
insert into monhoc values(@mamh, @tenmh, @sotc)
end;

exec sp_themmonhoc 'XYZ', 'Môn học mới', 3

delete from monhoc where mamh = 'XYZ' -- vừa nhập ko có sv đk nên ko có ràng buộc nên xóa đc


---cập nhật số tín chỉ 
alter proc sp_capnhatmh @mamh char(10), @sotc int
as
begin
if (not exists (select mamh from monhoc where mamh = @mamh))
	print N'Môn học này chưa tồn tại trong bảng dữ liệu'
else 
	update monhoc set sotc = @sotc where mamh = @mamh
end;

exec sp_capnhatmh 'TRR', 3

--cập nhật mã lớp-sinh viên
create proc sp_capnhatsvlop @masv char(10), @malop char(10)
as
begin
if (not exists (select masv from sv where masv = @masv))
	print N'Chưa có sinh viên này'
else 
	if (not exists (select malop from lop where malop = @malop))
		print N'Chưa có thông tin về lớp'
else
	update sv set malop = @malop where masv = @masv
end;

exec sp_canhatsvlop 

-- xóa môn học 
alter proc sp_xoamh @mamh char(10)
as
begin
if (exists (select mamh from monhoc where mamh =@mamh))
	print N'Không xóa được'
if (not exists (select mamh from monhoc where mamh =@mamh))
	print N'Môn học này chưa có'
else 
	delete from monhoc where mamh = @mamh
end;

exec sp_xoamh 'GDTC1'

select * from monhoc

-----viết thủ tục xóa dữ liệu của tất cả các bảng (4 bảng)

alter proc sp_xoalop @malop char(10)
as
begin
if (exists (select malop from sv where malop = @malop))
print N'Mã lớp này đang được sử dụng ở bảng khác, không thể thực hiện xóa được';
else
delete from lop where malop = @malop
end;

exec sp_xoalop 'CNTT62A'
exec sp_xoalop 'TMDT62B'
------------------------------
create proc sp_xoasv @masv char(10)
as
begin
if (exists (select masv from diem where masv = @masv))
	print N'Không thể xóa sinh viên này'
else 
	if (not exists (select masv from sv where masv = @masv))
		print N'Sinh viên chưa có trong bảng dữu liệu'
else 
	delete from sv where masv = @masv
end;
exec sp_xoasv 'SV8'
-------------------------------------





------------------------------------------------------------------
-- thủ tục
exec sp_help sv

create proc sp_malop @malop char(10)
as
select * from sv where malop = @malop

exec sp_malop 'CNTT62A'
--viết thủ tục tìm mã lớp và giới tính
create proc sp_malop1 @malop char(10), @gt nchar(6)
as
select * from sv where malop = @malop and gioitinh = @gt
exec sp_malop1 'CNTT62A', N'Nam'

exec sp_malop 'CNTT62A'

drop proc sp_malop
insert into lop values ('TMDT62B', N'Thương mại điện tử 62B', 0)

select * from lop;
delete from lop where malop = 'TMDT62B'

-- viết thủ tục xóa 1 lớp bất kì trong bảng lớp
--create proc sp_xoalop @malop char(10)
--as
--delete from lop where malop = @malop

alter proc sp_xoalop @malop char(10)
as
begin
if (exists (select malop from sv where malop = @malop))
print N'Mã lớp này đang được sử dụng ở bảng khác, không thể thực hiện xóa được';
else
delete from lop where malop = @malop
end;

exec sp_xoalop 'CNTT62A'
exec sp_xoalop 'TMDT62B'

-- thêm lớp
exec sp_help lop
create proc sp_themlop @malop char(10), @tenlop nvarchar(200), @sosv int
as
begin
if (exists (select malop from lop where malop = @malop))
print N'Mã lớp này đã tồn tại trong bảng';
else
insert into lop values(@malop, @tenlop, @sosv)
end;

exec sp_themlop 'TMDT64B', N'Thương mại điện tử 64B', 0
select * from lop;
--tìm kiếm sinh viên theo tỉnh và lớp
--them xóa trong bảng sinh viên
exec sp_help sv
create proc sp_themsv @masv char(10), @tensv nvarchar(100), @gioitinh nchar(6), @ngaysinh date, @malop char(10), @tinh nvarchar(200), @hocbong float
as
begin 
	if exists (select masv from sv where masv = @masv)
		print N'Mã sinh viên này đã có trong bảng'
	else
		if not exists (select malop from lop where malop = @malop)
			print N'Mã sinh viên này đã có trong bảng dữ liệu'
	else 
		insert into sv values (@masv, @tensv, @gioitinh, @ngaysinh, @malop, @tinh, @hocbong)
end;
exec sp_helptext sp_themsv 
select * from sv
exec sp_themsv 'SV8', N'Lã Jy', N'Nam', '2003-2-3', 'TMDT62A', N'Hà Nam', 0
--thêm xóa trong bảng điểm
create proc sp_xoasv @masv char(10)
as
begin
if (exists (select masv from diem where masv = @masv))
	print N'Không thể xóa sinh viên này'
else 
	if (not exists (select masv from sv where masv = @masv))
		print N'Sinh viên chưa có trong bảng dữu liệu'
else 
	delete from sv where masv = @masv
end;
exec sp_xoasv 'SV8'
--thêm xóa trong bảng môn học
exec sp_help monhoc
select * from monhoc
create proc sp_themmh @mamh char(10), @tenmh nvarchar(100), @sotc int
as
begin
	if exists (select mamh from monhoc where mamh = @mamh)
		print N'Môn học này đã tồn tại trong bảng'
	else insert into monhoc values (@mamh, @tenmh, @sotc)
end;
exec sp_themmh 'M10', N'Môn học XYZ', 3

-- sửa dữ liệu, update 

update monhoc set sotc = 6 where mamh = 'TRR'
select * from monhoc
update monhoc set tenmh = N'Môn học thứ 10', sotc = 6 where mamh = 'M10'


create proc sp_capnhatmh @mamh char(10), @sotc int
as
begin
if (not exists (select mamh from monhoc where mamh = @mamh))
	print N'Môn học này chưa tồn tại trong bảng dữ liệu'
else 
	update monhoc set sotc = @sotc where mamh = @mamh
end;

exec sp_capnhatmh 'TRR', 3

-- cập nhật lại điểm của SV khi biết mã sinh viên, mã môn học (điểm 1, điểm 2, điểm 3)
-- điểm hp có cập nhật lại không?
select * from diem

create proc sp_capnhatdiem @masv char(10), @mamh char(10), @diem1 float, @diem2 float, @diem3 float
as
begin 
if (not exists (select mamh, masv from diem where mamh = @mamh and masv = @masv))
	print N'Không cập nhật được'
else
	update diem set diem1 = @diem1, diem2 = @diem2, diem3 = @diem3, diemhp = (@diem1*0.1 + @diem2*0.2 +@diem3*0.3)
	where (mamh = @mamh and masv = @masv)
end;
exec sp_capnhatdiem 'SV1', 'GDTC1', 10,10,8

---------------------6/6/2022-------------------------
--2.sql

----------trigger-------------
create trigger trg_tinhdiem on diem for insert
as
begin
update diem	
	set diemhp = inserted.diem1 * 0.1 + inserted.diem2 * 0.4 + inserted.diem3 * 0.5
	from diem,inserted
	where diem.masv = inserted.masv and diem.mamh = inserted.mamh
end

select * from diem where masv = 'sv5'
delete from diem where masv = 'SV5'
update diem set diem1 = '8' where masv = 'SV5' and mamh = 'TCC'

disable trigger trg_tinhdiem on diem
enable trigger trg_tinhdiem on diem


insert into diem values('SV5', 'TCC', 10, 7, 6, 0)
insert into diem values('SV5', 'GDTC1', 6, 7, 9, 0)

------sua diem
alter trigger trg_suadiem on diem for update
as
begin
update diem	
	set diemhp = inserted.diem1 * 0.1 + inserted.diem2 * 0.4 + inserted.diem3 * 0.5
	from diem,inserted
	where diem.masv = inserted.masv and diem.mamh = inserted.mamh
end

update diem set diem1='9' where masv = 'SV1' and mamh = 'TRR'

select * from diem where masv='sv1'

drop trigger trg_tinhdiem
drop trigger trg_suadiem


select * from v_diem3 where masv = 'sv1'
select * from v_tongket 

-------------thay doi so tin chi cua mon hoc 







