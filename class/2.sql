create database qlbanhang
use qlbanhang
drop database qlbanhang

create table dmhanghoa(
mahang char(10) not null primary key,
tenhang nchar(50) not null,
soluongton int not null,
dongia int);

create table hangban(
maban char(10) not null primary key,
mahang char(10) references dmhanghoa(mahang),
ngayban datetime,
nguoiban char(50),
soluongban int not null, thanhtien int)

insert into dmhanghoa values('HH1', 'Bia 33', 200, 100)
insert into dmhanghoa values('HH2', 'Bia HN', 600, 150)
insert into dmhanghoa values('HH3', 'Ruou 133', 200, 40)
insert into dmhanghoa values('HH4', 'CoCa Cola 1', 30, 10)
insert into dmhanghoa values('HH5', 'Nuoc ngot 1', 400, 50)

insert into hangban values('MB1', 'HH1', '11/12/2020', 'Hong', 20,0)
insert into hangban values('MB2', 'HH2', '12/12/2020', 'Ha', 20,0)
insert into hangban values('MB3', 'HH3', '15/12/2020', 'Nga', 10,0)
insert into hangban values('MB4', 'HH4', '10/12/2020', 'Minh', 20,0)
insert into hangban values('MB5', 'HH5', '09/12/2020', 'Hung', 30,0)

select * from dmhanghoa
select * from hangban

update hangban set thanhtien = soluongban*dongia
from dmhanghoa,hangban where dmhanghoa.mahang=hangban.mahang

delete from hangban where maban='MB6'

insert into hangban values('MB6', 'HH1', '009/12/2020', 'Hung', 50,0)
----------trigger khi them ban ghi vao hang ban
create trigger trg_dathang on hangban after insert as
begin 
update dmhanghoa
	set soluongton = soluongton - (
		select soluongban from inserted 
		where inserted.mahang = dmhanghoa.mahang)
	from dmhanghoa, inserted where dmhanghoa.mahang = inserted.mahang

update hangban set thanhtien = soluongban * dongia
from dmhanghoa, hangban where dmhanghoa.mahang = hangban.mahang
end
go

drop trigger trg_dathang
disable trigger trg_dathang on hangban
enable trigger trg_dathang on hangban


---------------viết thủ tục bán hàng - kiểm tra số lượng tồn có trong danh mục
create proc sp_hangban @maban char(10), @mahang char(10), @ngayban datetime, @nguoiban char(50), @soluong int
as
	if exists (select * from hangban where maban = @maban)
		print N'Mã bán này đã có '
	else 
		if not exists (select * from dmhanghoa where mahang = @mahang)
			print N'Mã hàng này chưa có trong danh mục'
	else
		if exists (select mahang, soluongton from dmhanghoa where mahang = @mahang and soluongton < @soluong)
			print N'Số lượng mặt hàng này không đủ để bán'
	else 
		insert into hangban (maban, mahang, ngayban, nguoiban, soluongban) values(@maban, @mahang, @ngayban, @nguoiban, @soluong)
go

exec sp_hangban 'MB77', 'HH1', '09/12/2020', 'Ngoc', 100

select * from dmhanghoa
select * from hangban

---------------viết thủ tục thêm hàng hóa mới chưa có trong danh mục
alter proc sp_dmhanghoa @mahang char(10), @tenhang nvarchar(30), @soluong int, @dongia int
as
	if exists (select * from dmhanghoa where mahang = @mahang)
		print N'Mã hàng này đã có trong hệ thống'
	else
		insert into dmhanghoa values (@mahang, @tenhang, @soluong, @dongia)
go

exec sp_dmhanghoa 'HH7', 'Bia 77', 100, 200

select * from dmhanghoa

----------------cập nhật số lượng hàng hóa đã có trong danh mục
create proc sp_dmhanghoa_sl @mahang char(10), @soluong int
as
	if exists (select * from dmhanghoa where mahang = @mahang)
		update dmhanghoa set soluongton = soluongton + @soluong where mahang = @mahang
	else 
		print N'Mã hàng này chưa có trong danh mục'
go

exec sp_dmhanghoa_sl 'HH7', 200
select * from dmhanghoa

------------huy ban hang------------
create trigger trg_huydathang on hangban for delete as
begin
	update dmhanghoa
		set soluongton = soluongton + (select soluongban from deleted where mahang = dmhanghoa.mahang)
	from dmhanghoa, deleted where dmhanghoa.mahang = deleted.mahang
end

select * from dmhanghoa
select * from hangban

delete from hangban where maban ='MB77'

---------------cap nhat hang trong kho sau khi cap nhat dat hang------------
create trigger trg_capnhatdathang on hangban after update 
as
begin
	update dmhanghoa set soluongton = soluongton - 
		(select soluongton from inserted where mahang = dmhanghoa.mahang) +
		(select  soluongton from deleted where mahang = dmhanghoa.mahang)
update hangban set thanhtien = soluongban * dongia
from dmhanghoa,hangban where dmhanghoa.mahang = hangban.maban
end

select * from hangban
update hangban set soluongban = 50 from hangban where maban = 'MB1' and mahang = 'HH1'


select * from dmhanghoa

CREATE TRIGGER trg_SUAHANGBAN on HANGBAN FOR UPDATE
AS
BEGIN
UPDATE DMHANGHOA SET SoLuongTon = SoLuongTon -
(SELECT SoLuongban FROM inserted WHERE MaHang = DMHANGHOA.MaHang) +
(SELECT SoLuongban FROM deleted WHERE MaHang = DMHANGHOA.MaHang)
FROM DMHANGHOA,deleted WHERE DMHANGHOA.MaHang = deleted.MaHang



UPDATE HANGBAN set thanhtien = inserted.Soluongban* Dongia
From DMHANGHOA,HANGBAN,inserted WHERE DMHANGHOA.MaHang = HANGBAN.MaHang
and HANGBAN.MaBan = inserted.MaBan
END

update hangban set soluongban = 40 from hangban where maban = 'MB6' and mahang = 'HH1'





---------------------------
disable trigger all on hangban
enable trigger all on hangban
---------------------------
