create database quanlidiem1

use quanlidiem1
delete database quanlidiem1

create table lop(malop char(10) primary key, tenlop nvarchar(100), sosv int, tuoi bigint);
go
create table sv(masv char(10) primary key, tensv nvarchar(50), gioitinh nchar(3),
			 ngaysinh date, malop char(10) references lop(malop) not null, tinh nvarchar(100), hocbong float)
go
create table monhoc(mamh char(10) primary key, tenmh nvarchar(50), sotc int)
go
create table diem(masv char(10) not null references sv(masv), 
			 mamh char(10) not null references monhoc(mamh), diem1 float,
			 diem2 float, diem3 float, diemhp float, primary key(masv, mamh))

insert into monhoc values('TCC', N'Toán cao cấp', 3);
insert into monhoc values('GDTC1', N'Giáo dục thể chất 1', 2);
insert into monhoc values('GDTC2', N'Giáo dục thể chất 2', 3);
insert into monhoc values('VLDC1', N'Vật lý đại cương', 4);
insert into monhoc values('TRR', N'Toán rời rạc', 4);

insert into lop values('CNTT62A', N'Công nghệ thông tin 62A', 40, null);
insert into lop values('CNTT62B', N'Công nghệ thông tin 62B', 45, null);
insert into lop values('KHMT', N'Khoa học máy tính', 50, null);
insert into lop values('HTTTQL62A', N'HT thong tin quản lý 62A', 50, null);
insert into lop values('HTTTQL62B', N'HT thong tin quản lý 62B', 50, null);
insert into lop values('TMDT62A', N'Thương mại điện tử 62A', 60, null);


insert into sv values('SV1', N'Trần Văn A', N'Nam' ,'2001-02-04', 'CNTT62A', N'Hà Nội', 0);
insert into sv values('SV2', N'Trần Văn B', N'Nam' ,'2001-11-09', 'CNTT62A', N'Hà Nội', 0);
insert into sv values('SV3', N'Trần Văn c', N'Nữ' ,'2001-05-08', 'CNTT62B', N'Bắc Ninh', 0);
insert into sv values('SV4', N'Trần Văn D', N'Nữ' ,'2001-01-04', 'CNTT62B', N'Hà Nam', 0);
insert into sv values('SV5', N'Trần Văn E', N'Nam' ,'2001-06-03', 'CNTT62A', N'Hải Phòng', 0);

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

select * from monhoc
select * from lop
select * from sv
select * from diem

-----tạo function tính tuổi
alter function f_tinhtuoi(@MASV CHAR(10))
returns INT
AS
BEGIN
	DECLARE @NGAYSINH1 DATE
	select @NGAYSINH1 = ngaysinh FROM SV WHERE MASV = @MASV 

	return datediff(YEAR,@NGAYSINH1, getdate())
end


select * from sv
where dbo.f_tinhtuoi(ngaysinh) - 10 > 0


--update  lop set tuoi = dbo.f_tinhtuoi(select ngaysinh from sv where masv = 'SV1')
--where malop = 'CNTT62A'

delete from lop where malop = 'CNTT62A' 

update  lop set tuoi = dbo.f_tinhtuoi('SV1')
where malop = 'CNTT62A'

SELECT * FROM LOP










alter trigger trg_tinhdiem on diem for insert
as
begin
update diem	
	set diemhp = inserted.diem1 * 0.1 + inserted.diem2 * 0.4 + inserted.diem3 * 0.5
	from diem,inserted
	where diem.masv = inserted.masv and diem.mamh = inserted.mamh
end

select * from diem where masv = 'sv5'
delete from diem where masv = 'SV5'

disable trigger trg_tinhdiem on diem
enable trigger trg_tinhdiem on diem


insert into diem values('SV5', 'TCC', 10, 7, 6, 0)
insert into diem values('SV5', 'GDTC1', 6, 7, 9, 0)

update diem set diem1='9' where masv = 'sv1' and mamh = 'TRR'

select * from diem where masv='sv1'