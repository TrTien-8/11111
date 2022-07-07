create database QLHE2022_BANHANG
use QLHE2022_BANHANG
create table HH(
MaHH char(10) primary key, TenHH char(50),
DVT char(5), Dongia float, Trangthai bit);
create table KH(
MaKH char(10)primary key, Hoten char(50),
Diachi char(100), SoDT char (12), Hinhthuc bit);
create table HD(
SoHD char(10) primary key,Ngaylap date, Ngaygiao date,
Tongtien float, MaKH char (10) references KH(MaKH), Nguoilap char(50));
create table CT_HD(SoHD char(10)references HD(SoHD),
MaHH char(10) references HH(MaHH), Soluong int, Thanhtien float);



--1.--Input du lieu vao tung bang
-- 2. Viet View tong hop



create view V_Tonghop
as
select HH.MaHH, TenHH, DVT, DonGia, Trangthai
from HH,CT_HD
where HH.MaHH = CT_HD.MaHH



Select * from V_Tonghop
Select * from HH



SELECT count (MAHH) as SoluongHD
FROM V_Tonghop WHERE MAHH='H1'




insert into HH values('H1',N'bánh oreo',N'túi','5000',1);
insert into HH values('H2',N'coca cola',N'chai','10000',1);
insert into HH values('H3',N'kẹo',N'túi','5000',0);
insert into HH values('H4',N'nước lọc',N'chai','7000',1);
insert into HH values('H5',N'kem',N'cái','2000',1);
insert into HH values('H6',N'đường',N'gói','12000',0);
insert into HH values('H7',N'sữa',N'hộp','20000',1);
insert into HH values('H8',N'cafe',N'hộp','35000',1);



insert into KH values ('K1',N'Linh',N'Trương Định',01623944,0);
insert into KH values ('K2',N'Tuấn',N'Hai Bà Trưng',0965821448,1);
insert into KH values ('K3',N'Hiệp',N'Thanh Xuân',0339562142,0);
insert into KH values ('K4',N'Quỳnh',N'Đống Đa',0987654112,1);
insert into KH values ('K5',N'Hùng',N'Mỹ Đình',0693125448,0);




insert into HD (soHD, Ngaylap,Ngaygiao, MaKH, Nguoilap) values('HD01','2021/03/30','2021/03/30','K1',N'Ngoc');
insert into HD (soHD, Ngaylap,Ngaygiao, MaKH, Nguoilap)values('HD02','2021/03/30','2021/04/01','K1',N'Nga');
insert into HD(soHD, Ngaylap,Ngaygiao, MaKH, Nguoilap) values('HD03','2021/03/29','2021/03/30','K1',N'Nga');
insert into HD (soHD, Ngaylap,Ngaygiao, MaKH, Nguoilap)values('HD04','2021/03/27','2021/03/28','K1',N'Nga');
insert into HD(soHD, Ngaylap,Ngaygiao, MaKH, Nguoilap) values('HD05','2021/03/29','2021/04/01','K2',N'Nga');
insert into HD (soHD, Ngaylap,Ngaygiao, MaKH, Nguoilap)values('HD06','2021/03/30','2021/04/09','K2',N'Nga');
insert into HD(soHD, Ngaylap,Ngaygiao, MaKH, Nguoilap) values('HD07','2021/02/25','2021/03/15','K2',N'Nga');



insert into CT_HD(SoHD, MaHH,Soluong) values('HD01','H1',5);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD01','H4',5);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD01','H3',5);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD01','H8',2);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD02','H2',10);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD02','H1',5);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD03','H4',5);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD03','H7',10);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD03','H5',15);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD04','H4',1);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD06','H1',10);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD07','H1',5);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD07','H2',5);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD07','H3',5);
insert into CT_HD(SoHD, MaHH,Soluong) values('HD07','H1',10);
--------



select * from HH;
select * from KH;
select * from HD;
select * from CT_HD;
-- Tạo VIEW_ Thông tin về HD, CT_HD mà các khách hàng có Hinhthuc = 0
create view V_Tonghop2
as
select HD.SoHD, Ngaylap, Ngaygiao, HD.MaKH, Hoten, Diachi,
SoDT, Hinhthuc
from KH, HD, CT_HD
where KH.MaKH = HD.MaKH and HD.SoHD = CT_HD.SoHD and Hinhthuc = 0



Select * From V_Tonghop2



DELETE FROM CT_HD
DELETE FROM KH
DELETE FROM HD
DELETE FROM HH



--1.--Input du lieu vao tung bang
--2. Viet View tong hop
--3. Viet thu tuc tinh tien (@mahd char(10),@makh char(10)
-- 4. Viet triger khi cap nhat lai So luong va Cap Nhat lai don gia thi Thanh tien thay doi???
create view V_Tonghop1
as
select HD.SoHD, Ngaylap, Ngaygiao, CT_HD.MaHH, TenHH, DVT,
DonGia, Soluong, Trangthai, Dongia* Soluong as TT
from HH,KH, HD, CT_HD
where KH.MaKH = HD.MaKH and HD.SoHD = CT_HD.SoHD
and HH.MaHH = CT_HD.MaHH



-- Trang thái Hàng Hóa = 0
Select * from V_Tonghop1 where Trangthai = 1
Select * from HH

CREATE proc Tinhtien @SoHD char (10),@MaHH char (10)
as
begin
if (not exists ( select* from CT_HD where SoHD=@SoHD))
if (not exists ( select* from CT_HD where MaHH=@MaHH))
begin
print 'Khong co hoa don nay';
return -1;
end
else
begin
update CT_HD
set Thanhtien=Soluong*Dongia from HH,CT_HD where HH.MaHH=CT_HD.MaHH
end
END;

alter trigger trg_updatesoluong on ct_hd for update
as begin
update ct_hd
--set ct_hd.thanhtien = ct_hd.thanhtien + (inserted.soluong*dongia) - (deleted.soluong*dongia)
set ct_hd.thanhtien =  (inserted.soluong*dongia) 

from hh, ct_hd, inserted, deleted
where hh.mahh = ct_hd.mahh and inserted.MaHH = ct_hd.MaHH and deleted.SoHD = ct_hd.SoHD
end

select * from ct_hd
update CT_HD set Soluong = 10 where SoHD = 'HD01' and MaHH ='H4'
-------------------------------------------------------
create trigger trg_suadongia on hh after update
as begin
update ct_hd
--set ct_hd.thanhtien = ct_hd.thanhtien + (inserted.soluong*dongia) - (deleted.soluong*dongia)
set thanhtien =  (inserted.dongia*soluong) 

from hh, ct_hd, inserted
where hh.mahh = ct_hd.mahh and inserted.MaHH = ct_hd.MaHH 
end

update CT_HD set Soluong = 20 where  MaHH ='H2'
update hh set dongia = 30000 where  MaHH ='H2'

select * from ct_hd where mahh = 'H2'
-----------------------------------------------------------


























