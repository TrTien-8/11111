create database quan_ly_tiet_kiem
go
drop database quan_ly_tiet_kiem
go
use  quan_ly_tiet_kiem

create table khachhang (
	makh char(10) not null primary key,
	tenkh nvarchar(30) not null,
	socmt varchar(30) not null,
	diachi nvarchar(30) not null,
	dienthoai varchar(12) unique check (dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null
	)

create table loaitk (
	maloai char(10) not null primary key,
	tenloai nvarchar(30) not null,
	songay int ,
	loaitien nvarchar(30) not null,
	laisuat float not null
	)

create table sotk (
	maso char(10) primary key,
	makh char(10) references khachhang(makh) not null,
	sotiengui varchar(30),
	maloai char(10) references loaitk(maloai) not null,
	ngaygui date,
	ngayrut date,
	maht char(10) references hinhthuc(maht) not null,
	tienlai float,
	tienrut float
	)

drop table hinhthuc
create table hinhthuc (
	maht char(10) primary key,
	tenht nvarchar(30),
	ghichu nvarchar(30)
	)

select * from khachhang
select * from loaitk
select * from sotk
select * from hinhthuc

exec sp_help khachhang
drop table khachhang
insert into khachhang values ('kh01', N'Hải', '01234567890', N'Hà Nội', '0274574862')
insert into khachhang values ('kh02', N'Hoa', '27457184627', N'Hà Nam', '0987654567')
insert into khachhang values ('kh03', N'Hường', '08456278364', N'Hải Phòng', '0987897865')
insert into khachhang values ('kh04', N'Hương', '08756435265', N'Nam Định', '0985645321')
insert into khachhang values ('kh05', N'Phương', '09876543567', N'Hưng Yên', '0956432134')
insert into khachhang values ('kh06', N'Phượng', '76543213456', N'Thái Nguyên', '0956789876')
insert into khachhang values ('kh07', N'Trang', '56789098765', N'Hà Nội', '0678543234')
insert into khachhang values ('kh08', N'Thủy', '35678987654', N'Hà Nam', '0987654567')

exec sp_help loaitk
drop table loaitk
insert into loaitk values ('ltk01', N'Tài khoản tiết kiệm', null , 'VND', '0.04')
insert into loaitk values ('ltk02', N'Tài khoản thanh toán', null, 'VND', '0.05')
insert into loaitk values ('ltk03', N'Tài khoản ký quỹ', null, 'VND', '0.03')
insert into loaitk values ('ltk04', N'Tài khoản tín dụng', null, 'VND', '0.06')
insert into loaitk values ('ltk05', N'Tài khoản tạm giữ', null, 'VND', '0.02')
insert into loaitk values ('ltk06', N'Tài khoản tiền gửi', null, 'VND', '0.06')

exec sp_help hinhthuc
drop table hinhthuc
insert into hinhthuc values ('ht01', N'Tiết kiệm có kỳ hạn', '')
insert into hinhthuc values ('ht02', N'Tiết kiệm không kỳ hạn', '')
insert into hinhthuc values ('ht03', N'Tiết kiệm góp', '')
insert into hinhthuc values ('ht04', N'Tiết kiệm nhận lãi trước', '')
insert into hinhthuc values ('ht05', N'Tiết kiệm bậc thang', '')

exec sp_help sotk
insert into sotk values ('stk01', 'kh01', '2000000', 'ltk01', '2021-09-03', '2022-08-04', 'ht01', 0 , 0)
insert into sotk values ('stk02', 'kh02', '2000000', 'ltk02', '2021-08-12', '2022-02-05', 'ht01', 0 , 0)
insert into sotk values ('stk03', 'kh03', '2000000', 'ltk03', '2021-09-19', '2022-08-13', 'ht02', 0 , 0)
insert into sotk values ('stk04', 'kh04', '2000000', 'ltk04', '2021-03-25', '2022-05-12', 'ht03', 0 , 0)
insert into sotk values ('stk05', 'kh05', '2000000', 'ltk05', '2021-01-10', '2022-09-12', 'ht04', 0 , 0)
insert into sotk values ('stk06', 'kh06', '2000000', 'ltk06', '2021-05-24', '2022-02-10', 'ht05', 0 , 0)

-----cách lấy ngày trong sql
SELECT DATEDIFF(day , ngaygui, ngayrut) 
     FROM sotk

-------------------tạo function lấy ngày-----------------
CREATE function f_layngay(@ngaygui date, @ngayrut date)
returns INT
AS
BEGIN
	return datediff(day, @ngaygui, @ngayrut)
end
--------------------------- tạo thủ tục thêm bản ghi mới cho khách hàng
exec sp_help khachhang

create proc sp_khachhang @makh char(10), @tenkh nvarchar(60), @socmt varchar(30), @diachi nvarchar(60), @dienthoai varchar(12)
as
begin 
	if exists (select makh from khachhang where makh = @makh) -- kiểm tra khóa chính exists
		print N'Mã khách hàng này đã có trong bảng'
	else 
		insert into khachhang values (@makh, @tenkh, @socmt, @diachi, @dienthoai)
end;
drop proc sp_khachhang

exec dbo.sp_khachhang 'kh09', N'Hoàng', '01234567890', N'Hà Nội', '0234574862'
select * from khachhang

---------------------------tạo thủ tục thêm bản ghi mới cho loại tài khoản
exec sp_help loaitk

create proc sp_loaitk @maloai char(10), @tenloai nvarchar(60), @songay int , @loaitien nvarchar(60), @laisuat float
as
begin 
	if exists (select maloai from loaitk where maloai = @maloai) -- kiểm tra khóa chính exists
		print N'Mã loại tài khoản này đã có trong bảng'
	else 
		insert into loaitk values (@maloai, @tenloai, @songay, @loaitien, @laisuat)
end;


exec sp_loaitk 'ltk08', N'Tài khoản tiền gửi', null, 'VND', '0.07'

delete from loaitk where maloai = 'ltk08'
select * from loaitk

--------------------------------------------thủ tục update lại số ngày trong loại tài khoản dùng function
alter proc sp_updateloaitk @maloai char(10), @songay int, @maso char(10)
as
begin 
	if exists (select maloai from loaitk where maloai = @maloai) -- kiểm tra khóa chính exists
		print N'Mã loại tài khoản này đã có trong bảng'
	else 
		
		update loaitk set @songay = dbo.f_layngay (@maso)
end;

update loaitk set songay = dbo.f_layngay1('stk01') where maloai = 'ltk01'

select * from loaitk

CREATE function f_layngay1(@maso char(10))
returns INT
AS
BEGIN
	declare @ngaygui1 date, @ngayrut1 date
	select @ngaygui1 = ngaygui, @ngayrut1 = ngayrut from sotk where @maso = maso
	return datediff(day, @ngaygui1, @ngayrut1)
end

update  lop set tuoi = dbo.f_tinhtuoi('SV1')
where malop = 'CNTT62A'
-----------tạo thủ tục cập nhật lại số ngày trong bảng loại tài khoản 
alter proc tinhtuoi
as
begin
	update loaitk
		set songay = ( datediff(day, ngaygui, ngayrut) )
		from loaitk, sotk where loaitk.maloai = sotk.maloai
end

exec tinhtuoi 

select * from loaitk

---------------------------tạo thủ tục thêm bản ghi mới cho hình thức
exec sp_help hinhthuc

create proc sp_hinhthuc @maht char(10), @tenkh nvarchar(60), @ghichu nvarchar(60)
as
begin 
	if exists (select maht from hinhthuc where maht = @maht) -- kiểm tra khóa chính exists
		print N'Mã hình thức này đã có trong bảng'
	else 
		insert into hinhthuc values (@maht, @tenkh, @ghichu)
end;

exec sp_hinhthuc 'ht09', N'Tiết kiệm bậc thang', ''
exec sp_hinhthuc 'ht11', N'Tiết kiệm bậc thang', ''
exec sp_hinhthuc 'ht12', N'Tiết kiệm bậc thang', ''

select * from hinhthuc
delete from hinhthuc where maht = 'ht09'

---------------------------tạo thủ tục thêm bản ghi mới cho số tài khoản 
exec sp_help sotk
exec sp_help khachhang
exec sp_help loaitk
exec sp_help hinhthuc

create proc sp_sotk @maso char(10), @makh char(10),@sotiengui varchar(30), @maloai char(10),@ngaygui date, @ngayrut date, @maht char(10), @tienlai float, @tienrut float
as
begin 
	if exists (select maso from sotk where maso = @maso)
		print N'Mã số này đã có trong bảng'
	else
		if not exists (select makh from khachhang where makh = @makh)
			print N'Mã khách hàng này đã có trong bảng dữ liệu'
	else
		if not exists (select maloai from loaitk where maloai = @maloai)
			print N'Mã loại tài khoản này đã có trong bảng dữ liệu'
	else
		if not exists (select maht from hinhthuc where maht = @maht)
			print N'Mã hình thức này đã có trong bảng dữ liệu'
	else 
		insert into sotk values (@maso, @makh, @sotiengui, @maloai, @ngaygui, @ngayrut, @maht, @tienlai, @tienrut)
end;

exec sp_sotk 'stk09', 'kh06', '2000000', 'ltk06', '2021-05-24', '2022-02-10', 'ht05'
select * from sotk
delete from sotk where maso = 'stk09'
--------------------------------------tạo view đưa ra thông tin chi tiết các loại sổ tiết kiệm theo từng năm rút

create VIEW TTSTK AS
SELECT  maSO, SOTK.maLOAI, TENLOAI ,SOTK.maKH, SOTIENGUI, NGAYGUI, NGAYRUT, TIENLAI, tienrut, LAISUAT, SONGAY, TENKH
FROM KHACHHANG, LOAITK, SOTK;


select * from TTSTK
select * from khachhang
select * from loaitk
select * from sotk
select * from hinhthuc

--------------------------------------------xây dựng thủ tục tính toán số tiền lãi của từng năm theo công thức sotienlai = (sotiengui * laisuat)/ 360 * songay
alter proc sp_tienlai @maso char(10)
as
begin 
	update ttstk set tienlai = round((sotiengui * laisuat) / 360 * songay , 2)
	from ttstk where maso = @maso
end

exec sp_tienlai 'stk01'
select * from sotk
delete from sotk where maso = 'stk01'
--------------------------thủ tục cập nhật lại tiền rút ----------------

create proc sp_capnhattienrut @maso char(10), @tienrut float
as
begin
if (not exists (select maso from sotk where maso = @maso))
	print N'Số tài khoản này chưa tồn tại trong bảng dữ liệu'
else 
	update sotk set tienrut = @tienrut where maso = @maso
end;

exec sp_capnhattienrut 'stk01' , 10000
exec sp_capnhattienrut 'stk02' , 20000
exec sp_capnhattienrut 'stk03' , 30000
exec sp_capnhattienrut 'stk04' , 40000
exec sp_capnhattienrut 'stk05' , 50000
exec sp_capnhattienrut 'stk06' , 30000

select * from sotk















-----------------------viết trigger để tính số tiền lãi và tiền rút khi đáo hạn--------------























