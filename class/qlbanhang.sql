create database banhang
use banhang
delete database banhang
create table hh(
	mahh char(10) primary key, tenhh char(50),
	dvt char(5), dongia float, trangthai bit );

create table kh(
	makh char(10) primary key , hoten char(50),
	diachi char(100), sodt char(12), hinhthuc bit);

create table hd(
	sohd char(10) primary key, ngaylap date, ngaygiao date,
	tongtien float, makh char(10) references kh(makh), nguoilap nchar(50))

create table ct_hd(sohd char(10) references hd(sohd),
	mahh char(10) references hh(mahh), soluong int, thanhtien float)

--input du lieu
insert into hh values('H1', N'Bánh oreo', N'Túi', '5000', 1)
insert into hh values('H2', N'Coca Cola', N'Chai', '10000', 1)
insert into hh values('H3', N'Kẹo', N'Túi', '5000',1)
insert into hh values('H4', N'Nước lọc', N'Túi', '7000',1)
insert into hh values('H5', N'Kem', N'Túi', '2000',1)
insert into hh values('H6', N'Đường', N'Túi', '12000',1)
insert into hh values('H7', N'Sữa', N'Túi', '20000',1)
insert into hh values('H8', N'Cafe', N'Túi', '35000',1)

insert into kh values ('K1', N'Linh', N'Trương Định', 0123456789, 0)
insert into kh values ('K2', N'Tuấn', N'Hà Nội', 0123456789, 1)
insert into kh values ('K3', N'Hiệp', N'Hà Nam', 0123456789, 0)
insert into kh values ('K4', N'Hà', N'Hải Phòng', 0123456789, 1)
insert into kh values ('K5', N'Hùng', N'Nam Định', 0123456789, 0)

insert into hd (sohd, ngaylap, ngaygiao, makh, nguoilap) values('HD01', '2021/03/04', '2021/03/30','K1',N'Ngọc');
insert into hd (sohd, ngaylap, ngaygiao, makh, nguoilap) values('HD02', '2021/03/30', '2021/03/28','K1',N'Ngọc');
insert into hd (sohd, ngaylap, ngaygiao, makh, nguoilap) values('HD03', '2021/03/01', '2021/03/20','K1',N'Ngọc');
insert into hd (sohd, ngaylap, ngaygiao, makh, nguoilap) values('HD04', '2021/03/16', '2021/03/17','K1',N'Ngọc');
insert into hd (sohd, ngaylap, ngaygiao, makh, nguoilap) values('HD05', '2021/03/17', '2021/04/15','K2',N'Ngọc');
insert into hd (sohd, ngaylap, ngaygiao, makh, nguoilap) values('HD06', '2021/03/25', '2021/04/02','K2',N'Ngọc');
insert into hd (sohd, ngaylap, ngaygiao, makh, nguoilap) values('HD07', '2021/02/12', '2021/03/06','K2',N'Ngọc');

insert into ct_hd(sohd,mahh, soluong) values('HD01', 'H1', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD01', 'H1', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD02', 'H8', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD02', 'H2', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD03', 'H1', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD03', 'H4', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD03', 'H7', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD04', 'H5', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD06', 'H4', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD07', 'H1', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD03', 'H6', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD03', 'H3', 5)
insert into ct_hd(sohd,mahh, soluong) values('HD03', 'h1', 5)


select * from hh
select * from kh
select * from ct_hd
select * from hd

delete from ct_hd
-- view --
create view v_tonghop
as
	select hh.mahh, tenhh, dvt, dongia, trangthai
	from hh, ct_hd
	where hh.mahh=ct_hd.mahh

select * from v_tonghop

select count (mahh) as soluonghd from v_tonghop where mahh = 'H1'

--cap nhat tinh tien
update ct_hd
set thanhtien=soluong*dongia from hh, ct_hd where hh.mahh=ct_hd.mahh

select * from ct_hd

select sohd, sum(thanhtien) as tongtien
from ct_hd
group by sohd
-- cho biết những hóa đơn có tổng tiền >= 150000
select sohd, sum(thanhtien) as tongtien
from ct_hd
group by sohd
having sum(thanhtien) >= 150000
-- cho biết số lượng hóa đơn có tổng tiền >= 150000
create view v_soluonghd as(
select sohd, sum(thanhtien) as tongtien
from ct_hd
group by sohd
having sum(thanhtien) >= 150000)

select * from v_soluonghd
select count(*) as soluong from v_soluonghd

create view v_tonghop1
as(
	select hd.sohd, ngaylap, ngaygiao, ct_hd.mahh, tenhh, dvt, dongia, soluong, trangthai, dongia*soluong as tt
	from hh, kh, hd, ct_hd
	where kh.makh = hd.makh and hd.sohd = ct_hd.sohd and hh.mahh = ct_hd.mahh)

drop view v_tonghop1
select * from v_tonghop1

-- trạng thái hàng hóa = 0
select * from v_tonghop1 where trangthai = 0
-- tạo view thông tin cho tiết hóa đơn các khách hàng có hình thức bằng 0
create view v_tonghop2 
as(
	select kh.makh, hoten, diachi, sodt, hinhthuc, hd.sohd, ngaylap, ngaygiao, tongtien, nguoilap
	from kh, hd
	where kh.makh=hd.makh)
drop view v_tonghop2
create view v_tonghop2 
as(
	select hd.sohd, ngaylap, ngaygiao, hd.makh, hoten, diachi, sodt, hinhthuc
	from kh, hd, ct_hd
	where kh.makh=hd.makh and hd.sohd=ct_hd.sohd and hinhthuc=0)

select * from v_tonghop2

create proc tinhtien @sohd char(10), @mahh char(10)
as
begin
	if(not exists (select * from ct_hd where sohd = @sohd))
	if(not exists (select * from ct_hd where mahh = @mahh))
		begin 
			print 'Khong co hoa don nay'
			return -1;
		end
else 
	begin
	update ct_hd
	set thanhtien = soluong * dongia from hh, ct_hd where hh.mahh = ct_hd.mahh
	end
end























