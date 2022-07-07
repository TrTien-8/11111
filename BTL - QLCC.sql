create database QLDV_CHUNGCU
use QLDV_CHUNGCU

drop database qldv_chungcu

-------------------- A. TẠO BẢNG DỮ LIỆU --------------------

---------- A1. Bảng thông tin các nhân viên quản lý ----------
CREATE TABLE QUANLYKHUNHA(
	MAQL CHAR(10) PRIMARY KEY,
	HOTEN NVARCHAR(50) NOT NULL,
	NGAYSINH DATE NOT NULL,
	GIOITINH NCHAR(3) NOT NULL,
	SDT char(10) CHECK (SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))

---------- A2. Bảng liệt kê các khu nhà trong khu chung cư ----------
CREATE TABLE KHUNHA(
	MANHA CHAR(10) PRIMARY KEY,
	MAQL CHAR(10) REFERENCES QUANLYKHUNHA(MAQL) NOT NULL,
	SOLUONGPHONG CHAR(10) NOT NULL)

---------- A3. Bảng liệt kê các loại/hạng mục phòng ở ----------
CREATE TABLE LOAIPHONGO(
	LOAIPHONG NVARCHAR(15) PRIMARY KEY,
	DIENTICH INT)

---------- A4. Bảng thông tin các số phòng ở trong khu chung cư ----------
CREATE TABLE PHONGO(
	MAPHONG CHAR(10) PRIMARY KEY,
	MANHA CHAR(10) REFERENCES KHUNHA(MANHA) NOT NULL, 
	LOAIPHONG NVARCHAR(15) REFERENCES LOAIPHONGO(LOAIPHONG),
	TINHTRANGPHONG BIT)

---------- A5. Bảng thông tin các hộ gia đình đã nhận phòng trong khu chung cư ----------
CREATE TABLE HOGIADINH(
	MAHO CHAR(10) PRIMARY KEY,
	MAPHONG CHAR(10) REFERENCES PHONGO(MAPHONG))
	-- MANHA CHAR(10) REFERENCES KHUNHA(MANHA)

---------- A6. Bảng thông tin người dân trong khu chung cư ----------
CREATE TABLE NGUOIDAN(
	MANGUOIDAN CHAR(10) PRIMARY KEY,
	TENNGUOIDAN NVARCHAR(20) NOT NULL,
	MAHO CHAR(10) REFERENCES HOGIADINH(MAHO),
	GIOITINH BIT,
	NGAYSINH DATE,
	SDT char(10) check (SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))

---------- A7. Bảng liệt kê hợp đồng thuê phòng ----------
CREATE TABLE HOPDONG(
	MAHD CHAR(5) PRIMARY KEY,
	MAHO CHAR(10) REFERENCES HOGIADINH(MAHO) NOT NULL,
	MAPHONG CHAR(10) REFERENCES PHONGO(MAPHONG) NOT NULL,
 	MACHUHO CHAR(10) REFERENCES NGUOIDAN(MANGUOIDAN),
 	THOIGIANTHUETHEOTHANG INT,
 	TUNGAY DATE)

---------- A8. Bảng liệt kê các loại hình dịch vụ chung cư cung cấp, bảng giá dịch vụ: [đơn giá] / m2. Mỗi loại/mạng mục phòng ở có một đơn giá DV khác nhau. ----------
CREATE TABLE DICHVU(
	MADV CHAR(10) PRIMARY KEY,
	TENDICHVU NVARCHAR(50) NOT NULL,
	DONGIADV FLOAT CHECK (DONGIADV > 0))

---------- A9. Bảng thành tiền sử dụng dịch vụ của mỗi hộ gia đình ----------
create TABLE THUTIENDICHVU(
	-- MANHA CHAR(10) REFERENCES KHUNHA(MANHA),
	MAHO CHAR(10) REFERENCES HOGIADINH(MAHO),
	MADV CHAR(10) REFERENCES DICHVU(MADV),
	SOTHANG INT CHECK(SOTHANG>=1 AND SOTHANG<=6),
	THANHTIEN FLOAT,
	TINHTRANGTHU BIT)



-------------------- B. NHẬP DỮ LIỆU VÀO BẢNG--------------------

---------- B1. Nhập thông tin các nhân viên quản lý mỗi khu nhà ----------
INSERT INTO QUANLYKHUNHA VALUES ('QL1',N'Nguyễn Vân Anh','1/1/1994',N'Nữ','0123456789')
INSERT INTO QUANLYKHUNHA VALUES ('QL2',N'Trần Thị Bích','2/2/1995',N'Nữ','0987654321')
SELECT * FROM QUANLYKHUNHA

---------- B2. Nhập thông tin các khu nhà ----------
INSERT INTO KHUNHA VALUES ('N1','QL1',8)
INSERT INTO KHUNHA VALUES ('N2','QL2',8)
SELECT * FROM KHUNHA

---------- B3. Nhập thông tin các loại / phân khúc phòng ở ----------
INSERT INTO LOAIPHONGO VALUES ('L1','30')
INSERT INTO LOAIPHONGO VALUES ('L2','50')
INSERT INTO LOAIPHONGO VALUES ('L3','70')
SELECT * FROM LOAIPHONGO

---------- B4. Nhập thông tin của từng phòng ở ----------
INSERT INTO PHONGO VALUES ('P0101','N1','L1',1)
INSERT INTO PHONGO VALUES ('P0102','N1','L2',0)
INSERT INTO PHONGO VALUES ('P0103','N1','L1',1)
INSERT INTO PHONGO VALUES ('P0104','N1','L2',1)
INSERT INTO PHONGO VALUES ('P0105','N1','L2',0)
INSERT INTO PHONGO VALUES ('P0106','N1','L2',0)
INSERT INTO PHONGO VALUES ('P0107','N1','L3',1)
INSERT INTO PHONGO VALUES ('P0108','N1','L3',0)
INSERT INTO PHONGO VALUES ('P0201','N2','L1',0)
INSERT INTO PHONGO VALUES ('P0202','N2','L2',1)
INSERT INTO PHONGO VALUES ('P0203','N2','L2',0)
INSERT INTO PHONGO VALUES ('P0204','N2','L3',1)
INSERT INTO PHONGO VALUES ('P0205','N2','L3',1)
INSERT INTO PHONGO VALUES ('P0206','N2','L3',0)
INSERT INTO PHONGO VALUES ('P0207','N2','L2',0)
INSERT INTO PHONGO VALUES ('P0208','N2','L3',1)
SELECT * FROM PHONGO

---------- B5. Nhập thông tin các hộ gia đình đã nhận phòng ----------
INSERT INTO HOGIADINH VALUES ('H0101','P0101')
INSERT INTO HOGIADINH VALUES ('H0103','P0103')
INSERT INTO HOGIADINH VALUES ('H0104','P0104')
INSERT INTO HOGIADINH VALUES ('H0107','P0107')
INSERT INTO HOGIADINH VALUES ('H0202','P0202')
INSERT INTO HOGIADINH VALUES ('H0204','P0204')
INSERT INTO HOGIADINH VALUES ('H0205','P0205')
INSERT INTO HOGIADINH VALUES ('H0208','P0208')
SELECT * FROM HOGIADINH

---------- B6. Nhập thông tin người dân ----------
INSERT INTO NGUOIDAN VALUES ('ND1001',N'Nguyễn Hồng Anh','H0101','0','2/9/1990','0876549321')
INSERT INTO NGUOIDAN VALUES ('ND1002',N'Phạm Hoài Ngọc','H0103','0','9/4/1993','0213456789')
INSERT INTO NGUOIDAN VALUES ('ND1003',N'Trần Quốc Việt','H0104','1','2/9/1997','0132465789')
INSERT INTO NGUOIDAN VALUES ('ND1004',N'Đặng Long Hải','H0107','1','10/2/1982','0345672189')
INSERT INTO NGUOIDAN VALUES ('ND1005',N'Vũ Kim Chi','H0107','0','10/5/1996','0897654321')
INSERT INTO NGUOIDAN VALUES ('ND1006',N'Bùi Văn Chiến','H0104','0','8/19/1986','0456832179')
INSERT INTO NGUOIDAN VALUES ('ND1007',N'Đinh Việt Lý','H0101','1','12/18/1983','0945673218')
INSERT INTO NGUOIDAN VALUES ('ND1008',N'Lê Ngọc Châu','H0103','0','5/1/1990','0325416987')
INSERT INTO NGUOIDAN VALUES ('ND1009',N'Lê Đình Long','H0202','1','11/19/1978','0945873751')
INSERT INTO NGUOIDAN VALUES ('ND1010',N'Lê Minh Hùng','H0103','1','9/5/1980','0975354820')
INSERT INTO NGUOIDAN VALUES ('ND1011',N'Nguyễn Phương Thảo','H0205','0','2/15/2009','0977657581')
INSERT INTO NGUOIDAN VALUES ('ND1012',N'Phạm Thị Yến','H0208','0','1/10/2005','0913444679')
INSERT INTO NGUOIDAN VALUES ('ND1013',N'Trần Bích Nhung','H0204','0','6/18/1999','0946368999')
INSERT INTO NGUOIDAN VALUES ('ND1014',N'Lý Quang Hùng','H0204','1','3/4/1967','0977578125')
INSERT INTO NGUOIDAN VALUES ('ND1015',N'Tống Lê Huy','H0202','1','5/5/1993','0975225753')
INSERT INTO NGUOIDAN VALUES ('ND1016',N'Hoàng Minh Giang','H0101','0','1/31/1998','0154689753')
INSERT INTO NGUOIDAN VALUES ('ND1017',N'Đặng Đình Hoàng','H0202','1','12/19/2002','0978254687')
INSERT INTO NGUOIDAN VALUES ('ND1018',N'Trần Vinh','H0204','1','7/2/1979','0325416987')
INSERT INTO NGUOIDAN VALUES ('ND1019',N'Lê Đình Long','H0208','1','12/19/1972','0945120687')
INSERT INTO NGUOIDAN VALUES ('ND1020',N'Đào Minh Quang','H0205','1','4/5/1988','0984654112')
SELECT * FROM NGUOIDAN
SELECT * FROM NGUOIDAN where maho='h0205'

---------- B7. Nhập thông tin các hợp đồng thuê phòng ----------
INSERT INTO HOPDONG VALUES ('HD01','H0101','P0101','ND1001','6','1-21-2022')
INSERT INTO HOPDONG VALUES ('HD02','H0103','P0103','ND1002','6','1-30-2022')
INSERT INTO HOPDONG VALUES ('HD03','H0104','P0104','ND1003','6','3-2-2022')
INSERT INTO HOPDONG VALUES ('HD04','H0107','P0107','ND1004','12','3-3-2022')
INSERT INTO HOPDONG VALUES ('HD05','H0202','P0202','ND1009','12','3-10-2022')
INSERT INTO HOPDONG VALUES ('HD06','H0204','P0204','ND1014','12','4-21-2022')
INSERT INTO HOPDONG VALUES ('HD07','H0205','P0205','ND1020','6','5-4-2022')
INSERT INTO HOPDONG VALUES ('HD08','H0208','P0208','ND1019','12','6-14-2022')
SELECT * FROM HOPDONG

---------- B8. Nhập thông tin các loại dịch vụ chung cư cung cấp ----------
INSERT INTO DICHVU VALUES ('DV1',N'Phí dịch vụ chung',12000)
INSERT INTO DICHVU VALUES ('DV2',N'Phí quản lý chung cư',7500)
SELECT * FROM DICHVU

---------- B9. Nhập thông tin thành tiền mà từng hộ gia đình phải thanh toán, tình trạng thanh toán ----------
INSERT INTO THUTIENDICHVU VALUES ('H0101','DV1',1,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0101','DV2',1,null,0)
INSERT INTO THUTIENDICHVU VALUES ('H0103','DV1',2,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0103','DV2',1,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0104','DV1',3,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0104','DV2',3,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0107','DV1',6,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0107','DV2',6,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0202','DV1',1,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0202','DV2',1,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0204','DV1',3,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0204','DV2',3,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0205','DV1',1,null,0)
INSERT INTO THUTIENDICHVU VALUES ('H0205','DV2',1,null,1)
INSERT INTO THUTIENDICHVU VALUES ('H0208','DV1',1,null,0)
INSERT INTO THUTIENDICHVU VALUES ('H0208','DV2',1,null,1)

SELECT * FROM THUTIENDICHVU

SELECT * FROM THUTIENDICHVU
SELECT * FROM DICHVU
SELECT * FROM HOPDONG
SELECT * FROM NGUOIDAN
SELECT * FROM HOGIADINH
SELECT * FROM PHONGO
SELECT * FROM LOAIPHONGO
SELECT * FROM KHUNHA
SELECT * FROM QUANLYKHUNHA
 
drop table THUTIENDICHVU
drop table DICHVU
drop table HOPDONG
drop table NGUOIDAN
drop table HOGIADINH
drop table PHONGO
drop table LOAIPHONGO
drop table KHUNHA
drop table QUANLYKHUNHA


-------------------- C. TẠO VIEW --------------------

---------- C1. View thông tin hộ GĐ đã nộp tiền từng loại dịch vụ ----------
create VIEW V_DATHUDV
AS
SELECT HOGIADINH.MAHO, MAPHONG, MADV, SOTHANG, TINHTRANGTHU
FROM HOGIADINH, THUTIENDICHVU
WHERE HOGIADINH.MAHO = THUTIENDICHVU.MAHO AND TINHTRANGTHU = 1

SELECT * FROM V_DATHUDV

---------- C2. View thông tin hộ GĐ chưa nộp tiền từng loại dịch vụ ----------
create VIEW V_CHUATHUDV
AS
SELECT HOGIADINH.MAHO, MAPHONG, MADV, SOTHANG, TINHTRANGTHU
FROM HOGIADINH, THUTIENDICHVU
WHERE HOGIADINH.MAHO = THUTIENDICHVU.MAHO AND TINHTRANGTHU = 0

select * from V_CHUATHUDV

---------- C3. View số thành viên trong từng hộ gia đình (từ số người dân đã nhập vào hệ thống) ----------
create VIEW V_SOTHANHVIENTRONGHOGD
AS
SELECT HOGIADINH.MAHO, COUNT(MANGUOIDAN) as SOTHANHVIEN
FROM HOGIADINH, NGUOIDAN
WHERE HOGIADINH.MAHO = NGUOIDAN.MAHO
GROUP BY HOGIADINH.MAHO

SELECT * FROM V_SOTHANHVIENTRONGHOGD

---------- C4. View thông tin phòng ở của người dân ----------
create VIEW V_THONGTINNGUOIDAN
AS
SELECT MANGUOIDAN, TENNGUOIDAN, HOGIADINH.MAHO, PHONGO.MAPHONG, KHUNHA.MANHA
FROM HOGIADINH, KHUNHA, NGUOIDAN, PHONGO
WHERE HOGIADINH.MAHO = NGUOIDAN.MAHO AND HOGIADINH.MAHO = NGUOIDAN.MAHO AND PHONGO.MAPHONG = HOGIADINH.MAPHONG AND KHUNHA.MANHA = PHONGO.MANHA

SELECT * FROM V_THONGTINNGUOIDAN

---------- C5. View thông tin mô tả phòng ở + update thành tiền dịch vụ ----------
-- View thông tin mô tả phòng ở (loại phòng + diện tích m2) --
create VIEW v_loaiphongo_phongo
AS
SELECT maho, phongo.maphong, loaiphongo.loaiphong, dientich
FROM phongo, loaiphongo, hogiadinh WHERE loaiphongo.loaiphong = phongo.loaiphong and phongo.maphong = hogiadinh.maphong

select * from v_loaiphongo_phongo
drop view v_loaiphongo_phongo

-- Tính thành tiền dịch vụ 1 và 2 --
update thutiendichvu
set thanhtien = sothang*dongiadv*dientich
from thutiendichvu, dichvu, v_loaiphongo_phongo where thutiendichvu.madv = dichvu.madv and thutiendichvu.maho = v_loaiphongo_phongo.maho

select * from thutiendichvu

---------- C6. tính tổng số tiền mỗi hộ gia đình phải nộp ----------
-- Tính tổng tiền dịch vụ của mỗi hộ
-- alter view v_tongtien as
-- select manha, maho, sum(thanhtien) as tongtien
-- from thutiendichvu
-- group by manha, maho
-- select * from v_tongtien

-- Function tạo phép tính tổng --
CREATE FUNCTION tongtienphainop (@maho CHAR(10))
RETURNS int
AS
BEGIN
	return (select (sum(thanhtien)) from thutiendichvu where maho = @maho group by maho)
END

drop function tongtienphainop

-- Tạo view xem tổng số tiền mỗi hộ phải nộp --
CREATE VIEW v_tongtienphainop (maho, tongtienphainop)
AS
SELECT DISTINCT maho, dbo.tongtienphainop(maho)
FROM thutiendichvu

SELECT * FROM v_tongtienphainop
drop view v_tongtienphainop



-------------------- D. TẠO THỦ TỤC --------------------

---------- D1. Thủ tục thêm hộ gia đình ----------
create proc sp_themhogiadinh @maho CHAR(10), @maphong char(10)
as
begin
	if exists(select maho from hogiadinh where @maho = maho)
		print (N'Mã hộ đã có trong hệ thống! Xin hãy nhập mã khác.')
	else if not exists(select maphong from phongo where @maphong = maphong)
		print (N'Mã phòng khòng có trong hệ thống! Xin hãy nhập mã khác.')
	else if exists(select maphong from hogiadinh where @maphong = maphong)
		print (N'Mã phòng đang sử dụng! Xin hãy nhập mã khác.')
	else
		insert into hogiadinh values (@maho, @maphong)
end

exec sp_themhogiadinh 'H0102','P0102'
exec sp_themhogiadinh 'H0102','P0104'
exec sp_themhogiadinh 'H0108','P0108'
exec sp_themhogiadinh 'H0201','P0201'
exec sp_themhogiadinh 'H0206','P0206'
delete from hogiadinh where maphong ='p0206'

SELECT * FROM hogiadinh

drop proc sp_themhogiadinh

---------- D2. Thủ tục thêm người dân ----------
create proc sp_themnguoidan @MANGUOIDAN CHAR(10), @TENNGUOIDAN NVARCHAR(20), @MAHO CHAR(10), @GIOITINH BIT, @NGAYSINH DATE, @SDT CHAR(10)
as
begin
	if exists(select manguoidan from nguoidan where @manguoidan = manguoidan)
		print (N'Mã người dân đã có trong hệ thống! Xin hãy nhập mã khác.')
	if not exists(select maho from hogiadinh where @maho = maho)
		print (N'Mã hộ không có trong hệ thống! Xin hãy nhập mã khác.')
	else
		insert into nguoidan values (@manguoidan, @tennguoidan, @maho, @gioitinh, @ngaysinh, @sdt)
end

exec sp_themnguoidan 'ND1021',N'Đặng Đình Vũ','H0201','1','7/6/1982','0915479682'
exec sp_themnguoidan 'ND1022',N'Đặng Mỹ Hằng','H0201','0','2/18/2005','0945015792'
exec sp_themnguoidan 'ND1023',N'Lê Hải Hà','H0102','0','3/19/1989','0922658420'
exec sp_themnguoidan 'ND1024',N'Vũ Đăng Huy','H0108','1','3/5/1997','0915648752'

---------- D3. Thủ tục thêm hợp đồng ----------
create proc sp_themhopdong @MAHD CHAR(5), @MAHO CHAR(10), @MAPHONG CHAR(10), @MACHUHO CHAR(10), @THOIGIANTHUETHEOTHANG INT, @TUNGAY DATE
as
begin
	if exists(select mahd from hopdong where @mahd = mahd)
		print (N'Mã hợp đồng đã được sử dụng! Xin hãy nhập mã khác.')
	else if not exists(select maho from hogiadinh where @maho = maho)
		print (N'Mã hộ không có trong hệ thống! Xin hãy nhập mã khác.')
	else if exists(select maho from hopdong where @maho = maho)
		print (N'Mã hộ đã được sử dụng! Xin hãy nhập mã khác.')
	else if not exists(select maphong from phongo where @maphong = maphong)
		print (N'Mã phòng không có trong hệ thống! Xin hãy nhập mã khác.')
	else if exists(select maphong from hopdong where @maphong = maphong)
		print (N'Mã phòng đã được sử dụng! Xin hãy nhập mã khác.')
	else if not exists(select manguoidan from nguoidan where @machuho = manguoidan)
		print (N'Mã chủ hộ không có trong hệ thống! Xin hãy nhập mã khác.')
	else if exists(select machuho from hopdong where @machuho = machuho)
		print (N'Mã chủ hộ đã được sử dụng để đăng ký hợp đồng! Xin hãy nhập mã khác.')
	else
		insert into hopdong values (@mahd, @maho, @maphong, @machuho, @thoigianthuetheothang, @tungay)
end

select * from hopdong where mahd='hd09'
exec sp_themhopdong 'HD09','H0108','P0108','ND1024','6','1-20-2022'
exec sp_themhopdong 'HD10','H0102','P0102','ND1023','9','5-25-2021'

select * from hopdong

---------- D4. Thủ tục sửa thông tin hộ GĐ ----------
create proc sp_suahogd @maho CHAR(10), @maphong char(10)
as
begin
	if not exists(select maho from hogiadinh where @maho = maho)
		print (N'Mã hộ không có trong hệ thống!')
	else if not exists(select maphong from phongo where @maphong = maphong)
		print (N'Mã phòng không có trong hệ thống!')
	else
		update hogiadinh
		set maphong = @maphong
		where maho = @maho
end
drop proc sp_suahogd
exec sp_suahogd 'H0104','P0105'
exec sp_suahogd 'H0208','P0202'
exec sp_suahogd 'H0209','P0204'
exec sp_suahogd 'H0208','P0208'
exec sp_suahogd 'H0104','P0104'

select * from V_THONGTINNGUOIDAN where manha='n1'

---------- D5. Thủ tục xóa hợp đồng ----------
create proc sp_xoahopdong @MAHD CHAR(5)
as
begin
	if not exists(select mahd from hopdong where @mahd = mahd)
		print (N'Mã hợp đồng không tồn tại! Xin hãy nhập lại mã.')
	else
		delete from hopdong where mahd = @mahd
end

exec sp_xoahopdong 'HD08'
select * from hopdong
drop proc sp_xoahopdong

---------- D6. Thủ tục cập nhật lại tình trạng phòng ----------
create PROC SP_Capnhatphong @MAPHONG CHAR(10)
as
begin
	if (not exists(select maphong from phongo where maphong=@maphong))
		print N'Mã phòng không tồn tại, hãy nhập lại'
	else if (exists (select maphong from hogiadinh where maphong=@maphong))
		update phongo set tinhtrangphong = 1 where maphong=@maphong
	else update phongo set tinhtrangphong = 0 where maphong=@maphong
end

select * from phongo
exec sp_themhogiadinh 'H0203','P0203'
exec sp_capnhatphong 'P0203'
select * from phongo



-------------------- E. TẠO TRIGGER --------------------

---------- E1. Cập nhật tổng tiền dịch vụ khi thay đổi số tháng cần thanh toán ----------
CREATE TRIGGER TGR_CAPNHATTIENDV ON THUTIENDICHVU FOR UPDATE
AS
BEGIN
UPDATE THUTIENDICHVU
SET thanhtien = inserted.sothang*dongiadv*dientich
FROM THUTIENDICHVU, v_loaiphongo_phongo, dichvu, INSERTED
WHERE thutiendichvu.maho = inserted.maho AND THUTIENDICHVU.MADV = inserted.madv and thutiendichvu.madv = dichvu.madv and dichvu.madv = inserted.madv
and v_loaiphongo_phongo.maho = thutiendichvu.maho
END
GO

enable trigger TGR_CAPNHATTIENDV on thutiendichvu
disable trigger TGR_CAPNHATTIENDV on thutiendichvu
drop trigger TGR_CAPNHATTIENDV

select * from V_tongtienphainop

select * from thutiendichvu

UPDATE THUTIENDICHVU SET sothang = '2' where maho = 'H0208' AND madv = 'dv2';
UPDATE THUTIENDICHVU SET sothang = '3' where maho = 'H0101' AND madv = 'dv1';
UPDATE THUTIENDICHVU SET dongiadv = '2' where maho = 'H0208' AND madv = 'dv2';

---------- E2. Cập nhật thành tiền dịch vụ khi 1 hộ đăng ký thêm dịch vụ ----------
alter proc sp_dangkydv @maho char(10), @madv char(10), @sothang int, @thanhtien float, @tinhtrangthu bit
as begin
	if not exists(select maho from hogiadinh where @maho = maho)
		print (N'Mã hộ không có trong hệ thống!')
	else if not exists(select madv from dichvu where @madv = madv)
		print (N'Mã dịch vụ không có trong hệ thống!')
	else if exists (select madv from thutiendichvu where madv=@madv and maho=@maho)
		print (N'Hộ đã đăng ký dịch vụ này')
	else
	insert into thutiendichvu values (@maho, @madv, @sothang, @thanhtien, @tinhtrangthu)
end

create trigger tgr_themtiendv on thutiendichvu after insert
as
begin
	UPDATE THUTIENDICHVU
	SET thanhtien = inserted.sothang*dongiadv*dientich
	from thutiendichvu, dichvu, v_loaiphongo_phongo, INSERTED
	WHERE thutiendichvu.maho = inserted.maho AND THUTIENDICHVU.MADV = inserted.madv and thutiendichvu.madv = dichvu.madv and dichvu.madv = inserted.madv
	and v_loaiphongo_phongo.maho = thutiendichvu.maho
END

select * from hogiadinh
select * from thutiendichvu
exec sp_dangkydv 'H0206','DV2',1, null, 1
exec sp_dangkydv 'H0102','DV1',2, null, 0

enable trigger tgr_themtiendv
disable trigger tgr_themtiendv
drop trigger tgr_themtiendv