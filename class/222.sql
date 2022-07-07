create database qlbanhang1
use qlbanhang1
drop database qlbanhang1



CREATE table DMHANGHOA(
MaHang char(10) not null primary key,
TenHang nchar(50) not null,
Soluongton int not null,
Dongia int);



CREATE table HANGBAN(
MaBan char(10) not null primary key,
MaHang char(10) references DMHANGHOA(MaHang),
NgayBan datetime,
NguoiBan char(50),
Soluongban int not null, thanhtien int)



--Drop table HANGBAN



insert into DMHANGHOA values('HH1','Bia 33', 200, 100)
insert into DMHANGHOA values('HH2','Bia HN', 600, 150)
insert into DMHANGHOA values('HH3','Ruou 123', 200, 40)
insert into DMHANGHOA values('HH4','Coca Cola 1', 30, 10)
insert into DMHANGHOA values('HH5','Nuoc ngot 1', 400, 50)



insert into HANGBAN values('MB1','HH1','12/12/2020',' Hong',20,0)
insert into HANGBAN values('MB2','HH2','11/12/2020',' Ha',20,0)
insert into HANGBAN values('MB3','HH2','15/12/2020',' Nga',10,0)
insert into HANGBAN values('MB4','HH3','10/12/2020',' Minh',20,0)
insert into HANGBAN values('MB5','HH1','09/12/2020',' Hung',30,0)



Select * from DMHANGHOA
Select * from HANGBAN


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

update hangban set soluongban = 40 from hangban where maban = 'MB5' and mahang = 'HH1'

