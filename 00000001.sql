create database quan_ly_tiet_kiem1
go
drop database quan_ly_tiet_kiem
go
use  quan_ly_tiet_kiem1

create table khachhang (
	makh char(10) not null primary key,
	tenkh nvarchar(30) not null,
	socmt varchar(30) not null,
	diachi nvarchar(30) not null,
	dienthoai varchar(12) unique check (dienthoai like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null
	--dienthoai varchar(15) not null check(dienthoai not like '%[^0-9]%')
	)
create table loaitk (
	maloai char(10) not null primary key,
	tenloai nvarchar(30) not null,
	songay int,
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


insert into khachhang values ('kh01', N'Hải', '01234567890', N'Hà Nội', '0274574862')
insert into khachhang values ('kh02', N'Hoa', '27457184627', N'Hà Nam', '0987654567')
insert into khachhang values ('kh03', N'Hường', '08456278364', N'Hải Phòng', '0987897865')
insert into khachhang values ('kh04', N'Hương', '08756435265', N'Nam Định', '0985645321')
insert into khachhang values ('kh05', N'Phương', '09876543567', N'Hưng Yên', '0956432134')
insert into khachhang values ('kh06', N'Phượng', '76543213456', N'Thái Nguyên', '0956789876')
insert into khachhang values ('kh07', N'Trang', '56789098765', N'Hà Nội', '0678543234')
insert into khachhang values ('kh08', N'Thủy', '35678987654', N'Hà Nam', '0987654567')

insert into loaitk values ('ltk01', N'Tài khoản tiết kiệm', 30 , 'VND', '0.04')
insert into loaitk values ('ltk02', N'Tài khoản thanh toán', 60, 'VND', '0.05')
insert into loaitk values ('ltk03', N'Tài khoản ký quỹ', 90, 'VND', '0.03')
insert into loaitk values ('ltk04', N'Tài khoản tín dụng', 120, 'VND', '0.06')
insert into loaitk values ('ltk05', N'Tài khoản tạm giữ', 240, 'VND', '0.02')
insert into loaitk values ('ltk06', N'Tài khoản tiền gửi', 240, 'VND', '0.06')

insert into hinhthuc values ('ht01', N'Tiết kiệm có kỳ hạn', '')
insert into hinhthuc values ('ht02', N'Tiết kiệm không kỳ hạn', '')
insert into hinhthuc values ('ht03', N'Tiết kiệm góp', '')
insert into hinhthuc values ('ht04', N'Tiết kiệm nhận lãi trước', '')
insert into hinhthuc values ('ht05', N'Tiết kiệm bậc thang', '')

insert into sotk values ('stk01', 'kh01', '2000000', 'ltk01', '2021-09-03', '2022-08-04', 'ht01', 0 , 0)
insert into sotk values ('stk02', 'kh02', '2000000', 'ltk02', '2021-08-12', '2022-02-05', 'ht01', 0 , 0)
insert into sotk values ('stk03', 'kh03', '2000000', 'ltk03', '2021-09-19', '2022-08-13', 'ht02', 0 , 0)
insert into sotk values ('stk04', 'kh04', '2000000', 'ltk04', '2021-03-25', '2022-05-12', 'ht03', 0 , 0)
insert into sotk values ('stk05', 'kh05', '2000000', 'ltk05', '2021-01-10', '2022-09-12', 'ht04', 0 , 0)
insert into sotk values ('stk06', 'kh06', '2000000', 'ltk06', '2021-05-24', '2022-02-10', 'ht05', 0 , 0)

select * from khachhang
select * from loaitk
select * from sotk
select * from hinhthuc

alter VIEW TTSTK AS
SELECT  maSO, SOTK.maLOAI, TENLOAI ,SOTK.maKH, SOTIENGUI, NGAYGUI, NGAYRUT, TIENLAI, tienrut, LAISUAT, SONGAY, TENKH
FROM KHACHHANG, LOAITK, SOTK
where khachhang.makh = SOTK.makh and loaitk.maloai = sotk.maloai and sotk.makh = khachhang.makh and year(ngayrut) = 2022

select * from ttstk


create proc sp_tienlai @maso char(10)
as
begin 
	update ttstk set tienlai = round((sotiengui * laisuat) / 360 * songay , 2)
	update ttstk set tienrut = round((sotiengui * laisuat) / 360 * songay , 2) + sotiengui
	from ttstk where maso = @maso
end

exec sp_tienlai 'stk01'
select * from sotk
delete from sotk where maso = 'stk01'



---
create view loaisotk_theonam
as
select year(ngayrut) as namrut, loaitk.maloai, tenloai, songay, loaitien,laisuat
from loaitk, sotk where sotk.maloai = loaitk.maloai;

select * from loaisotk_theonam;

create proc tienrut1 @maso char(10)
as
begin
	if(not exists (select * from sotk where maso=@maso))
	begin
		print N'Khong co ma so tiet kiem nay trong he thong';
		return -1;
	end;
	else
	begin
		update sotk
		set tienrut = sotiengui + sotiengui * laisuat * songay / 360,
			tienlai = sotiengui * laisuat * songay/360
		from sotk,loaitk
		where sotk.maloai = loaitk.maloai and maso = @maso;
	end
end

select * from sotk

create trigger tinhtoan on sotk after insert
as
begin
	update sotk
	set tienrut = sotk.sotiengui + sotk.sotiengui * laisuat * songay/360,
	tienlai = sotiengui * laisuat * songay / 360
	from sotk,loaitk
	where sotk.maloai = loaitk.maloai

end

create trigger tinhtoan1_update on sotk for update
as
begin
	update sotk
	set tienrut = sotk.sotiengui + sotk.sotiengui * laisuat * songay/360,
	tienlai = sotiengui * laisuat * songay / 360
	from sotk,loaitk
	where sotk.maloai = loaitk.maloai
end

select * from sotk where maso = 'stk02'

select * from loaitk
update sotk set maloai = 'ltk04' where maso = 'stk02'
