create database qlluong;
use qlluong;

create table chucvu(
    ma_cv char(10) primary key,
    ten_cv nchar(100),
    phu_cap float check(phu_cap >= 0));

create table phongban(
    ma_pb char(10) primary key,
    ten_pb nchar(100),
    dien_thoai char(12));

create table nhanvien(
    ma_nv char(10) primary key,
    ten_nv nchar(40) not null,
    he_so_luong float check(he_so_luong >= 0),
    ma_cv char(10),
    ma_pb char(10),
    foreign key (ma_CV) references chucvu(ma_cv),
    foreign key (ma_PB) references phongban(ma_pb));

create table luong(
    ma_luong char(10) primary key,
    ma_nv char(10) references nhanvien(ma_nv),
    luong_co_ban float check(luong_co_ban > 0),
    khoan_cong_them float check(khoan_cong_them >= 0),
    khoan_tru float check(khoan_tru >= 0),
    thuc_linh float);

insert into chucvu values ('cv1', N'Trưởng phòng', 100000)
insert into chucvu values ('cv2', N'Phó phòng', 300000)
insert into chucvu values ('cv3', N'Nhân viên', 200000)
insert into chucvu values ('cv4', N'Nhân viên', 400000)
insert into chucvu values ('cv5', N'Nhân viên', 500000)
insert into chucvu values ('cv6', N'Bảo vệ', 600000)
insert into chucvu values ('cv7', N'Bảo vệ', 600000)
insert into chucvu values ('cv8', N'Bảo vệ', 200000)
insert into chucvu values ('cv9', N'Bảo vệ', 100000)

insert into phongban values ('pb1', N'Phòng kỹ thuật', 0123456789)
insert into phongban values ('pb2', N'Phòng cán bộ', 023451345)
insert into phongban values ('pb3', N'Phòng y tế', 012356784)
insert into phongban values ('pb4', N'Phòng bảo vệ', 013648367)
insert into phongban values ('pb5', N'Phòng giáo viên', 016482647)
insert into phongban values ('pb6', N'Phòng học', 0864725364)

insert into nhanvien values ('nv1', 'Hải', 2.5, 'cv1', 'pb2')
insert into nhanvien values ('nv2', 'Long', 2.5, 'cv2', 'pb1')
insert into nhanvien values ('nv3', 'Tuấn', 2.5, 'cv3', 'pb3')
insert into nhanvien values ('nv4', 'Hùng', 2.5, 'cv4', 'pb4')
insert into nhanvien values ('nv5', 'Trang', 2.5, 'cv5', 'pb5')
insert into nhanvien values ('nv6', 'Hoa', 2.5, 'cv6', 'pb6')

insert into luong values ('ml1', 'nv1', 10000000, 1000000, 100000, 0)
insert into luong values ('ml2', 'nv2', 6000000, 500000, 500000, 0)
insert into luong values ('ml3', 'nv3', 4000000, 200000, 300000, 0)
insert into luong values ('ml4', 'nv4', 3000000, 100000, 200000, 0)
insert into luong values ('ml5', 'nv5', 3000000, 100000, 200000, 0)
insert into luong values ('ml6', 'nv6', 3000000, 100000, 200000, 0)

------------------------------- tạo thủ tục thêm nhân viên------------------------------------------
exec sp_help nhanvien

create proc sp_themnv @ma_nv char(10), @ten_nv nchar(80), @he_so_luong float, @ma_cv char(10), @ma_pb char(10)
as
begin 
	if exists (select ma_nv from nhanvien where ma_nv = @ma_nv)
		print N'Mã nhân viên này đã có trong bảng'
	else
		if not exists (select ma_cv from chucvu where ma_cv = @ma_cv)
			print N'Mã nhân viên này đã có trong bảng'
	else
		if not exists (select ma_pb from phongban where ma_pb = @ma_pb)
			print N'Mã nhân viên này đã có trong bảng'
	else 
		insert into nhanvien values (@ma_nv, @ten_nv, @he_so_luong, @ma_cv, @ma_pb)
end;

exec sp_themnv 'nv7', N'Ly', 2.0, cv1, pb2

exec sp_helptext sp_themsv 
-------------------------------------------------------------------------------------------------------
------------------------------tạo thủ tục xóa 1 nhân viên bất kỳ --------------------------------------

create proc sp_xoa @ma_nv char(10)
as
begin
if (exists (select ma_nv from luong where ma_nv = @ma_nv))
print N'Mã nhân viên này đang được sử dụng ở bảng khác, không thể thực hiện xóa được';
else
delete from nhanvien where ma_nv = @ma_nv
end;

exec sp_xoa'nv7'
select * from nhanvien


---------------------tạo view cập nhật lại lương thực tế được nhận-------------------------------------

select * from luong
select * from nhanvien

-------------------------------------------------------------------------------------------------------
 
---------------------------------------------------------------------
alter view v_luong1 as
(
select nhanvien.ma_nv, ten_nv, he_so_luong, nhanvien.ma_cv, ten_cv, phu_cap, nhanvien.ma_pb, ten_pb, dien_thoai, luong.ma_luong, luong_co_ban, khoan_cong_them, khoan_tru, 
(luong_co_ban + (he_so_luong+phu_cap) + khoan_cong_them - khoan_tru) as luongthucte
from nhanvien, chucvu, phongban, luong
where chucvu.ma_cv = nhanvien.ma_cv and phongban.ma_pb = nhanvien.ma_pb and nhanvien.ma_nv = luong.ma_nv)

drop view v_luong1
select * from v_luong1
---------------------------------------------------
create function inbangnhanvien()
returns table
as return (select * from nhanvien)

select * from inbangnhanvien()
---------------------------------------------------

update luong set thuc_linh = luong_co_ban + (he_so_luong+phu_cap) + khoan_cong_them - khoan_tru
from luong,nhanvien,chucvu
where luong.ma_nv = nhanvien.ma_nv and nhanvien.ma_cv =chucvu.ma_cv

select * from luong

update luong set khoan_cong_them = 400000 where ma_luong = 'ml1'

------------------------trigger--------------------------
create trigger trg_thuclinh on luong for insert --them ban ghi moi
as begin
update luong
	set thuc_linh = inserted.luong_co_ban + (he_so_luong + phu_cap)
		+ inserted.khoan_cong_them + inserted.khoan_tru
from luong, nhanvien, chucvu, inserted
where luong.ma_nv = nhanvien.ma_nv and nhanvien.ma_cv = chucvu.ma_cv and inserted.ma_luong = luong.ma_luong
end

insert into luong (ma_luong, ma_nv, luong_co_ban, khoan_cong_them, khoan_tru) values ('ml7', 'nv4', 10000000, 1000000, 0)

select * from luong

---------------------------------------

create view v_tonghop as (
	select luong.ma_luong, luong.ma_nv, nhanvien.ten_nv, nhanvien.ma_pb, 
			luong.luong_co_ban, chucvu.phu_cap, nhanvien.he_so_luong, luong.khoan_cong_them,
			luong.khoan_tru, luong.thuc_linh
	from chucvu, nhanvien, luong
	where chucvu.ma_cv = nhanvien.ma_cv and nhanvien.ma_nv = luong.ma_nv);
	
select * from v_tonghop
-------------viet trigger khi thay doi luong co ban, khoan cong, khoan tru trong bang luong
create trigger trg_update on luong for update --them ban ghi moi
as begin
update luong
	set thuc_linh = inserted.luong_co_ban + (he_so_luong + phu_cap)
		+ inserted.khoan_cong_them + inserted.khoan_tru
from luong, nhanvien, chucvu, inserted
where luong.ma_nv = nhanvien.ma_nv and nhanvien.ma_cv = chucvu.ma_cv and inserted.ma_luong = luong.ma_luong
end

update luong set khoan_cong_them = 0 where ma_luong = 'ml1'

select * from luong


--------------- viet trigger thay doi phu cap trong bang chuc vu 
create trigger trg_phucap on chucvu for update --them ban ghi moi
as begin
update luong
	set thuc_linh = luong_co_ban + (he_so_luong + inserted.phu_cap)
		+ khoan_cong_them + khoan_tru
from luong, nhanvien, chucvu, inserted
where luong.ma_nv = nhanvien.ma_nv and nhanvien.ma_cv = chucvu.ma_cv and inserted.ma_cv = chucvu.ma_cv
end

select * from chucvu
update chucvu set phu_cap = '6' where ma_cv = 'cv2'
update nhanvien set ma_cv = 'cv2' where ma_nv = 'nv2'

select * from v_tonghop
select * from nhanvien




--------------- viet trigger thay doi luong trong bang nhan vien

create trigger trg_nhanvien on nhanvien for update --them ban ghi moi
as begin
update luong
	set thuc_linh = luong_co_ban + (inserted.he_so_luong + phu_cap)
		+ khoan_cong_them + khoan_tru
from luong, nhanvien, chucvu, inserted
where luong.ma_nv = nhanvien.ma_nv and nhanvien.ma_cv = chucvu.ma_cv and inserted.ma_cv = chucvu.ma_cv
end

update nhanvien set ma_cv = 'cv2' , he_so_luong = 1000 where ma_nv = 'nv2'
select * from v_tonghop where ma_nv = 'nv2'

-------------cho biet so luong nha vien tung phong ban
select ma_pb, count(ma_nv) as so_nv from nhanvien group by ma_pb

select nhanvien.ma_pb, ten_pb, count(ma_nv) as so_nv from nhanvien, phongban 
where nhanvien.ma_pb = phongban.ma_pb
group by nhanvien.ma_pb, ten_pb

-------------cho biet so luong nha vien tung phong ban, co so nhan vien lon hon...

select nhanvien.ma_pb, ten_pb, count(ma_nv) as so_nv from nhanvien, phongban 
where nhanvien.ma_pb = phongban.ma_pb
group by nhanvien.ma_pb, ten_pb
having count(ma_nv) >1






















