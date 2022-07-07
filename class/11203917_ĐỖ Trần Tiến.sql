-- sum, min,  max
--thực hành :
-------------insert , update, delete, sp_tinhtoan


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

create view v_diem3 as
(
select sv.masv, tensv, gioitinh, ngaysinh, tinh, hocbong, sv.malop, tenlop, sosv, diem.mamh, tenmh, sotc, diem1, diem2, diem3, 
(diem1*0.1+diem2*0.4+diem3*0.5) as diemhp
from sv, monhoc, diem, lop
where diem.masv = sv.masv and diem.mamh = monhoc.mamh and lop.malop = sv.malop)

select * from v_diem1
drop view v_diem3

create view v_diem2 as
(
select sv.masv, tensv, malop, diem.mamh, tenmh, sotc, diem1, diem2, diem3,
(diem1*0.1+diem2*0.4+diem3*0.5) as diemhp
from sv,monhoc,diem
where diem.masv=sv.masv and diem.mamh=monhoc.mamh);

select * from v_diem2

create view v_diem1 as
(
select sv.masv, tensv, malop, diem.mamh, tenmh, sotc, diem1, diem2, diem3, diemhp
from sv, monhoc, diem
where diem.masv=sv.masv and diem.mamh=monhoc.mamh);

select * from v_diem1
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





----------------------------------------------------------
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

------------------------------------------15/6/2022--------------------------------
----------function-----------
create function diemtk(@masv char(10))
returns float
as
begin
	return (select (sum(diemhp * sotc)/ sum(sotc)) from v_diem1 where masv = @masv group by masv)
end

select * from v_diem1

create function tongtc1(@masv char(10))
returns int
as
begin
	return (select sum(sotc) from v_diem1 where masv = @masv group by masv)
end

select * from v_diem1

alter view v_tongket(masv, hoten,ngaysinh, malop, tongsotc, diem_tongket)
as
	select distinct masv, tensv,ngaysinh, malop, dbo.tongtc(masv), dbo.tinhdiemtb(masv) from v_diem3

select * from v_tongket

select * from sv

alter proc xethb
as
begin
	update sv
		set hocbong = (
			case 
				when (diem_tongket >= 9.5) then 7000000
				when (diem_tongket >= 9) then 5000000
				when (diem_tongket >= 7) then 3000000
			else 0
			end)
		from sv, v_tongket where v_tongket.masv = sv.masv
end

exec xethb

select * from sv where hocbong > 0

select * from diem where masv = 'sv102'

insert into diem values('sv102', 'GDTC1', 8, 9, 6, 0)
insert into diem values('sv102', 'GDTC2', 8, 9, 6, 0)
insert into diem values('sv102', 'TRR', 8, 9, 6, 0)
insert into diem values('sv102', 'VLDC1', 8, 9, 6, 0)

select * from v_diem3 where masv = 'sv102'















-------------------------------------------------function----------------------------------------
exec sp_helptext v_diem1
exec sp_helptext v_diem2
exec sp_helptext v_diem3

select * from v_diem3
-- đưa ra tổng số tín sinh viên học 
select masv, sum(sotc) as tongtc from v_diem3 group by masv 
-- tính điểm trung bình của từng sinh viên: sum(diemhp * sotc) / sum(sotc)  --sử dụng hàm round làm tròn 
select masv, tensv, round (sum(diemhp*sotc)/sum(sotc),2) as diemtb from v_diem3
group by masv, tensv
---
select masv, sum(sotc) as tongtc, round (sum(diemhp*sotc)/sum(sotc),2) as diemtb from v_diem3
group by masv

------dùng function---------------------------
create function tinhdiemtb (@masv char(10))
returns float
as
begin
	return (select (round(sum(diemhp*sotc)/sum(sotc),1)) from v_diem3 where masv = @masv group by masv);
end;
--------
exec dbo.tinhdiemtb 'sv1'
--------
create function tongtc(@masv char(10))
returns int 
as
begin
	return (select sum(sotc) from v_diem3 where masv = @masv group by masv);
end;
-------Tạo view để tính điểm tổng kết 
alter view v_tongket(masv, hoten,ngaysinh, malop, tongsotc, diem_tongket)
as
	select distinct masv, tensv,ngaysinh, malop, dbo.tongtc(masv), dbo.tinhdiemtb(masv) from v_diem3

select * from v_tongket

create proc hocbong
as
begin
	update sv
	set hocbong=(case 
		when (diem_tongket>=8.5) then 700
		when (diem_tongket>=7.5) then 500
		when (diem_tongket>=6) then 300
		else 0
		end)
	from sv,v_tongket where v_tongket.masv=sv.masv;
end;

exec hocbong;
select * from sv where hocbong > 0

--chỉ xét học bổng cho những sinh viên có tổng số tín chỉ lớn hơn 10
create proc hocbong_tinchi10
as
begin
	update sv
	set hocbong=(case 
		when (diem_tongket>=8.5) then 700
		when (diem_tongket>=7.5) then 500
		when (diem_tongket>=6) then 300
		else 0
		end)
	from sv,v_tongket where v_tongket.masv=sv.masv and v_tongket.tongsotc>10;
end;
exec hocbong_tinchi10;
select * from sv where hocbong > 0
update sv set hocbong=0
--------------
select * from v_diem3 where masv='sv4'
insert into diem values('sv4', 'GDTC1', 8, 9, 6, 0)
insert into diem values('sv4', 'GDTC2', 8, 3, 7, 0)
-- học bổng chưa có sv4 mặc dù tổng kết là 6.5 sv4 có 6 tín ko có hb muốn có chạy 'exec hocbong';

select * from sv

