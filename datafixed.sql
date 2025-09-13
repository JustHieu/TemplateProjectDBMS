SET NOCOUNT ON;
BEGIN TRY
BEGIN TRAN;

------------------------------------------------------------
-- 1) Vai trò & Nhân viên
------------------------------------------------------------
INSERT INTO dbo.VaiTro (MaVaiTro, TenVaiTro) VALUES
(1, N'QUANLI'),
(2, N'NHANVIEN');

-- 4 Admin (mật khẩu  '123')
INSERT INTO dbo.NhanVien (TenDangNhap, MatKhau, HoTen, SoDienThoai, Email, MaVaiTro, LuongTheoGio, TrangThai) VALUES
(N'admin_hieu',  N'123', N'Việt Hiếu',             N'0900000001', N'hieu@example.com', 1, 35000, 1),
(N'admin_minh',  N'123', N'Phạm Thị Tuyết Minh',   N'0900000002', N'minh@example.com', 1, 35000, 1),
(N'admin_quan',  N'123', N'Công Quân',             N'0900000003', N'quan@example.com', 1, 35000, 1),
(N'admin_hoang', N'123', N'Thiên Hoàng',           N'0900000004', N'hoang@example.com',1, 35000, 1);

-- 6 nhân viên part-time (chỉ họ có CaLam)
INSERT INTO dbo.NhanVien (TenDangNhap, MatKhau, HoTen, SoDienThoai, Email, MaVaiTro, LuongTheoGio, TrangThai) VALUES
(N'pt_hoa', N'123', N'Nguyễn Thị Hoa',  N'0900001011', N'hoa@example.com', 2, 25000, 1),
(N'pt_huy', N'123', N'Trần Gia Huy',    N'0900001012', N'huy@example.com', 2, 26000, 1),
(N'pt_lan', N'123', N'Lê Mỹ Lan',       N'0900001013', N'lan@example.com', 2, 25000, 1),
(N'pt_tam', N'123', N'Phạm Văn Tâm',    N'0900001014', N'tam@example.com', 2, 24000, 1),
(N'pt_anh', N'123', N'Đỗ Nhật Anh',     N'0900001015', N'anh@example.com', 2, 26000, 1),
(N'pt_bao', N'123', N'Võ Hữu Bảo',      N'0900001016', N'bao@example.com', 2, 25000, 1);

------------------------------------------------------------
-- 2) Đơn vị & Danh mục
------------------------------------------------------------
INSERT INTO dbo.DonVi (MaDonVi, TenDonVi, IsActive) VALUES
(N'LON',  N'Lon', 1),
(N'CHAI', N'Chai',1),
(N'HOP',  N'Hộp', 1),
(N'GOI',  N'Gói', 1),
(N'LY',   N'Ly',  1);

INSERT INTO dbo.DanhMucSanPham (TenDanhMuc, TrangThai) VALUES
(N'Đồ uống có gas', 1),
(N'Trà & Nước tăng lực', 1),
(N'Nước uống đóng chai', 1),
(N'Sữa & Sản phẩm sữa', 1),
(N'Mì/Phở/Cháo ăn liền', 1),
(N'Gia vị & Nhu yếu phẩm', 1),
(N'Bánh kẹo', 1);

------------------------------------------------------------
-- 3) Nhà cung cấp (8 NCC)
------------------------------------------------------------
INSERT INTO dbo.NhaCungCap (TenNCC, SoDienThoai, DiaChi, TrangThai) VALUES
(N'Coca-Cola Vietnam',        N'028-111111', N'Quận 7, TP.HCM', 1),
(N'Suntory PepsiCo Vietnam',  N'028-222222', N'Thủ Đức, TP.HCM', 1),
(N'Tân Hiệp Phát (THP)',      N'0274-333333',N'Bình Dương', 1),
(N'Vinamilk',                 N'028-444444', N'Quận 7, TP.HCM', 1),
(N'TH True Milk',             N'024-555555', N'Ba Đình, Hà Nội', 1),
(N'Acecook Vietnam',          N'028-666666', N'Tân Bình, TP.HCM', 1),
(N'Masan Consumer',           N'028-777777', N'TP.Thủ Đức, TP.HCM', 1),
(N'URC Vietnam (Jack ''n Jill)', N'028-888888', N'Bình Tân, TP.HCM', 1);

------------------------------------------------------------
-- 4) Sản phẩm  + MaVach 6 số
--    Ngày SX/HSD mẫu: 2025-07..09; HSD +6..18 tháng
------------------------------------------------------------
DECLARE @d1 DATE='2025-07-15', @d2 DATE='2025-08-10', @d3 DATE='2025-09-01';
DECLARE @h6 DATE='2026-03-01', @h9 DATE='2026-06-10', @h12 DATE='2026-09-15', @h18 DATE='2027-03-01';

-- Helper: id danh mục & đơn vị
DECLARE @dm_gas INT=(SELECT MaDanhMuc FROM dbo.DanhMucSanPham WHERE TenDanhMuc=N'Đồ uống có gas');
DECLARE @dm_tea INT=(SELECT MaDanhMuc FROM dbo.DanhMucSanPham WHERE TenDanhMuc=N'Trà & Nước tăng lực');
DECLARE @dm_water INT=(SELECT MaDanhMuc FROM dbo.DanhMucSanPham WHERE TenDanhMuc=N'Nước uống đóng chai');
DECLARE @dm_milk INT=(SELECT MaDanhMuc FROM dbo.DanhMucSanPham WHERE TenDanhMuc=N'Sữa & Sản phẩm sữa');
DECLARE @dm_noodle INT=(SELECT MaDanhMuc FROM dbo.DanhMucSanPham WHERE TenDanhMuc=N'Mì/Phở/Cháo ăn liền');
DECLARE @dm_gia_vi INT=(SELECT MaDanhMuc FROM dbo.DanhMucSanPham WHERE TenDanhMuc=N'Gia vị & Nhu yếu phẩm');
DECLARE @dm_banh_keo INT=(SELECT MaDanhMuc FROM dbo.DanhMucSanPham WHERE TenDanhMuc=N'Bánh kẹo');

DECLARE @dv_lon  INT=(SELECT MaDV FROM dbo.DonVi WHERE MaDonVi='LON');
DECLARE @dv_chai INT=(SELECT MaDV FROM dbo.DonVi WHERE MaDonVi='CHAI');
DECLARE @dv_hop  INT=(SELECT MaDV FROM dbo.DonVi WHERE MaDonVi='HOP');
DECLARE @dv_goi  INT=(SELECT MaDV FROM dbo.DonVi WHERE MaDonVi='GOI');
DECLARE @dv_ly   INT=(SELECT MaDV FROM dbo.DonVi WHERE MaDonVi='LY');

-- Đồ uống có gas (Coke/Pepsi/Sprite/7Up/Fanta/Mtn Dew)
INSERT INTO dbo.SanPham (TenSP, MaDanhMuc, DonGia, TrangThai, MaDV, MaVach, NgaySanXuat, NgayHetHan) VALUES
(N'Coca-Cola lon 330ml',           @dm_gas, 10000, 1, @dv_lon,  '100001', @d2, @h12),
(N'Coca-Cola Zero lon 330ml',      @dm_gas, 11000, 1, @dv_lon,  '100002', @d2, @h12),
(N'Sprite lon 330ml',              @dm_gas, 10000, 1, @dv_lon,  '100003', @d2, @h12),
(N'Fanta cam lon 330ml',           @dm_gas, 10000, 1, @dv_lon,  '100004', @d2, @h12),
(N'Fanta nho lon 330ml',           @dm_gas, 10000, 1, @dv_lon,  '100005', @d2, @h12),
(N'Pepsi lon 330ml',               @dm_gas, 10000, 1, @dv_lon,  '100006', @d1, @h12),
(N'Pepsi Black 330ml',             @dm_gas, 11000, 1, @dv_lon,  '100007', @d1, @h12),
(N'7Up lon 330ml',                 @dm_gas, 10000, 1, @dv_lon,  '100008', @d1, @h12),
(N'Mirinda cam lon 330ml',         @dm_gas, 10000, 1, @dv_lon,  '100009', @d1, @h12),
(N'Mountain Dew lon 330ml',        @dm_gas, 11000, 1, @dv_lon,  '100010', @d1, @h12);

-- Trà & Nước tăng lực (THP/Suntory/Masan/URC)
INSERT INTO dbo.SanPham (TenSP, MaDanhMuc, DonGia, TrangThai, MaDV, MaVach, NgaySanXuat, NgayHetHan) VALUES
(N'Trà xanh Không Độ 455ml',       @dm_tea, 12000, 1, @dv_chai, '100011', @d3, @h12),
(N'Dr Thanh 350ml',                 @dm_tea, 12000, 1, @dv_chai, '100012', @d3, @h12),
(N'Number 1 Active chanh muối 455ml',@dm_tea,12000, 1, @dv_chai, '100013', @d3, @h12),
(N'Number 1 Energy dâu 330ml',      @dm_tea, 11000, 1, @dv_chai, '100014', @d3, @h12),
(N'TEA+ Ô Long 455ml',              @dm_tea, 14000, 1, @dv_chai, '100015', @d3, @h12),
(N'Revive Isotonic 500ml',          @dm_tea, 12000, 1, @dv_chai, '100016', @d3, @h12),
(N'Sting dâu 330ml',                @dm_tea, 11000, 1, @dv_chai, '100017', @d3, @h12),
(N'Sting vàng 330ml',               @dm_tea, 11000, 1, @dv_chai, '100018', @d3, @h12),
(N'C2 Trà xanh 500ml',              @dm_tea, 12000, 1, @dv_chai, '100019', @d3, @h12),
(N'Wake-Up 247 330ml',              @dm_tea, 11000, 1, @dv_chai, '100020', @d3, @h12);

-- Nước đóng chai
INSERT INTO dbo.SanPham (TenSP, MaDanhMuc, DonGia, TrangThai, MaDV, MaVach, NgaySanXuat, NgayHetHan) VALUES
(N'Aquafina 500ml',                 @dm_water, 7000, 1, @dv_chai, '100021', @d3, @h12),
(N'Aquafina 1.5L',                  @dm_water,14000, 1, @dv_chai, '100022', @d2, @h12),
(N'Dasani 500ml',                   @dm_water, 7000, 1, @dv_chai, '100023', @d2, @h12);

-- Sữa & sản phẩm sữa
INSERT INTO dbo.SanPham (TenSP, MaDanhMuc, DonGia, TrangThai, MaDV, MaVach, NgaySanXuat, NgayHetHan) VALUES
(N'Vinamilk 100% sữa tươi 180ml',   @dm_milk, 9000, 1, @dv_hop,  '100024', @d3, @h6),
(N'Vinamilk 100% sữa tươi 1L',      @dm_milk,32000, 1, @dv_hop,  '100025', @d3, @h6),
(N'Vinamilk sữa chua ăn có đường 100g x4', @dm_milk, 24000, 1, @dv_hop, '100026', @d3, @h6),
(N'Vinamilk Probi 65ml x5',         @dm_milk, 29000, 1, @dv_hop,  '100027', @d3, @h6),
(N'TH true MILK 180ml',             @dm_milk,10000, 1, @dv_hop,  '100028', @d2, @h6),
(N'TH true MILK 1L',                @dm_milk,32000, 1, @dv_hop,  '100029', @d2, @h6),
(N'TH true Yogurt 100g x4',         @dm_milk,26000, 1, @dv_hop,  '100030', @d2, @h6);

-- Mì/Phở/Cháo ăn liền (Acecook/Masan)
INSERT INTO dbo.SanPham (TenSP, MaDanhMuc, DonGia, TrangThai, MaDV, MaVach, NgaySanXuat, NgayHetHan) VALUES
(N'Hảo Hảo tôm chua cay 75g',       @dm_noodle, 5000, 1, @dv_goi, '100031', @d1, @h18),
(N'Hảo Hảo sa tế hành 75g',         @dm_noodle, 5000, 1, @dv_goi, '100032', @d1, @h18),
(N'Hảo Hảo ly tôm chua cay 67g',    @dm_noodle, 9000, 1, @dv_ly,  '100033', @d1, @h18),
(N'Phở Đệ Nhất bò 65g',             @dm_noodle, 7000, 1, @dv_goi, '100034', @d1, @h18),
(N'Đệ Nhất phở gà 65g',             @dm_noodle, 7000, 1, @dv_goi, '100035', @d1, @h18),
(N'Omachi bò hầm 80g',              @dm_noodle, 8000, 1, @dv_goi, '100036', @d2, @h18),
(N'Omachi xốt spaghetti 80g',       @dm_noodle, 9000, 1, @dv_goi, '100037', @d2, @h18),
(N'Mì Omachi ly 72g',               @dm_noodle,12000, 1, @dv_ly,  '100038', @d2, @h18),
(N'Kokomi 90g',                     @dm_noodle, 4000, 1, @dv_goi, '100039', @d1, @h18),
(N'Modern tôm chua cay 65g',        @dm_noodle, 5000, 1, @dv_goi, '100040', @d1, @h18);

-- Gia vị & nhu yếu phẩm (Masan)
INSERT INTO dbo.SanPham (TenSP, MaDanhMuc, DonGia, TrangThai, MaDV, MaVach, NgaySanXuat, NgayHetHan) VALUES
(N'Nước mắm Nam Ngư 500ml',         @dm_gia_vi, 38000,1, @dv_chai, '100041', @d1, @h18),
(N'Nước tương Chinsu 500ml',         @dm_gia_vi, 32000,1, @dv_chai, '100042', @d1, @h18),
(N'Tương ớt Chinsu 250g',            @dm_gia_vi, 25000,1, @dv_hop,  '100043', @d1, @h18),
(N'Dấm gạo Chinsu 500ml',            @dm_gia_vi, 22000,1, @dv_chai, '100044', @d1, @h18),
(N'Muối i-ốt Chinsu 500g',           @dm_gia_vi, 12000,1, @dv_goi,  '100045', @d1, @h18),
(N'Hạt nêm Chinsu 400g',             @dm_gia_vi, 38000,1, @dv_goi,  '100046', @d1, @h18);

-- Bánh kẹo (URC Jack 'n Jill)
INSERT INTO dbo.SanPham (TenSP, MaDanhMuc, DonGia, TrangThai, MaDV, MaVach, NgaySanXuat, NgayHetHan) VALUES
(N'Cream-O 137g',                    @dm_banh_keo, 18000,1, @dv_hop, '100047', @d2, @h12),
(N'Fun-O 198g',                      @dm_banh_keo, 24000,1, @dv_hop, '100048', @d2, @h12),
(N'Magic Flakes 25g x10',            @dm_banh_keo, 30000,1, @dv_hop, '100049', @d2, @h12),
(N'Jack ''n Jill Potato Chips 60g',  @dm_banh_keo, 18000,1, @dv_goi, '100050', @d2, @h12),
(N'Jack ''n Jill Piattos 50g',       @dm_banh_keo, 15000,1, @dv_goi, '100051', @d2, @h12),
(N'Jack ''n Jill Roller Coaster 60g',@dm_banh_keo, 17000,1, @dv_goi, '100052', @d2, @h12),
(N'Dynamite 100g',                   @dm_banh_keo, 15000,1, @dv_hop, '100053', @d2, @h12);

-- Bổ sung để đạt >=54
INSERT INTO dbo.SanPham (TenSP, MaDanhMuc, DonGia, TrangThai, MaDV, MaVach, NgaySanXuat, NgayHetHan) VALUES
(N'Sprite chai 390ml',               @dm_gas, 12000,1, @dv_chai, '100054', @d2, @h12);

------------------------------------------------------------
-- 5) Tồn kho & Kệ trưng bày (snapshot MaVach)
------------------------------------------------------------
INSERT INTO dbo.KhoHang (MaSP, MaVach, SoLuongTon)
SELECT s.MaSP, s.MaVach,
       CASE 
          WHEN s.TenSP LIKE N'%1.5L%' THEN 40
          WHEN s.TenSP LIKE N'%330ml%' OR s.TenSP LIKE N'%350ml%' OR s.TenSP LIKE N'%455ml%' OR s.TenSP LIKE N'%500ml%' THEN 120
          WHEN s.TenSP LIKE N'%180ml%' OR s.TenSP LIKE N'%100g%' OR s.TenSP LIKE N'%65g%' OR s.TenSP LIKE N'%75g%' OR s.TenSP LIKE N'%80g%' THEN 80
          ELSE 60
       END
FROM dbo.SanPham s;

INSERT INTO dbo.KeHang (MaSP, MaVach, SoLuongTrenKe)
SELECT s.MaSP, s.MaVach,
       CASE 
          WHEN s.TenSP LIKE N'%lon%' OR s.TenSP LIKE N'%LON%' THEN 24
          WHEN s.TenSP LIKE N'%LY%'  OR s.TenSP LIKE N'%ly%'  THEN 12
          ELSE 10
       END
FROM dbo.SanPham s;

------------------------------------------------------------
-- 6) Ca làm (CHỈ cho part-time)
------------------------------------------------------------
DECLARE @d DATE='2025-09-08';
-- Lấy danh sách part-time
;WITH PT AS (
  SELECT MaNV, ROW_NUMBER() OVER (ORDER BY MaNV) rn
  FROM dbo.NhanVien WHERE MaVaiTro=2 AND TrangThai=1
)
INSERT INTO dbo.CaLam (MaNV, Ngay, GioBatDau, GioKetThuc, TrangThai)
SELECT p.MaNV, DATEADD(DAY, d, @d),
       CAST(CASE WHEN (p.rn + d) % 2 = 0 THEN '08:00:00' ELSE '17:00:00' END AS TIME),
       CAST(CASE WHEN (p.rn + d) % 2 = 0 THEN '12:00:00' ELSE '21:00:00' END AS TIME),
       N'Chờ duyệt'
FROM PT p
CROSS APPLY (VALUES (0),(1),(2),(3),(4),(5),(6)) v(d);

------------------------------------------------------------
-- 7) Phiếu nhập (1 phiếu/NCC, trạng thái Đã duyệt) + Chi tiết
------------------------------------------------------------
DECLARE @nv_lap INT=(SELECT MaNV FROM dbo.NhanVien WHERE TenDangNhap=N'admin_hieu');
DECLARE @nv_xet INT=(SELECT MaNV FROM dbo.NhanVien WHERE TenDangNhap=N'admin_minh');

INSERT INTO dbo.PhieuNhap (MaNCC, MaNVLap, NgayLap, MaNVXetDuyet, NgayXetDuyet, TrangThai)
SELECT MaNCC, @nv_lap, DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY MaNCC)*-2, GETDATE()), @nv_xet, GETDATE(), N'Đã duyệt'
FROM dbo.NhaCungCap;

DECLARE @pn_coca  INT=(SELECT TOP 1 pn.MaPhieuNhap FROM dbo.PhieuNhap pn JOIN dbo.NhaCungCap n ON n.MaNCC=pn.MaNCC WHERE n.TenNCC=N'Coca-Cola Vietnam' ORDER BY MaPhieuNhap DESC);
DECLARE @pn_sps   INT=(SELECT TOP 1 pn.MaPhieuNhap FROM dbo.PhieuNhap pn JOIN dbo.NhaCungCap n ON n.MaNCC=pn.MaNCC WHERE n.TenNCC=N'Suntory PepsiCo Vietnam' ORDER BY MaPhieuNhap DESC);
DECLARE @pn_thp   INT=(SELECT TOP 1 pn.MaPhieuNhap FROM dbo.PhieuNhap pn JOIN dbo.NhaCungCap n ON n.MaNCC=pn.MaNCC WHERE n.TenNCC=N'Tân Hiệp Phát (THP)' ORDER BY MaPhieuNhap DESC);
DECLARE @pn_vnm   INT=(SELECT TOP 1 pn.MaPhieuNhap FROM dbo.PhieuNhap pn JOIN dbo.NhaCungCap n ON n.MaNCC=pn.MaNCC WHERE n.TenNCC=N'Vinamilk' ORDER BY MaPhieuNhap DESC);
DECLARE @pn_th    INT=(SELECT TOP 1 pn.MaPhieuNhap FROM dbo.PhieuNhap pn JOIN dbo.NhaCungCap n ON n.MaNCC=pn.MaNCC WHERE n.TenNCC=N'TH True Milk' ORDER BY MaPhieuNhap DESC);
DECLARE @pn_ace   INT=(SELECT TOP 1 pn.MaPhieuNhap FROM dbo.PhieuNhap pn JOIN dbo.NhaCungCap n ON n.MaNCC=pn.MaNCC WHERE n.TenNCC=N'Acecook Vietnam' ORDER BY MaPhieuNhap DESC);
DECLARE @pn_masan INT=(SELECT TOP 1 pn.MaPhieuNhap FROM dbo.PhieuNhap pn JOIN dbo.NhaCungCap n ON n.MaNCC=pn.MaNCC WHERE n.TenNCC=N'Masan Consumer' ORDER BY MaPhieuNhap DESC);
DECLARE @pn_urc   INT=(SELECT TOP 1 pn.MaPhieuNhap FROM dbo.PhieuNhap pn JOIN dbo.NhaCungCap n ON n.MaNCC=pn.MaNCC WHERE n.TenNCC=N'URC Vietnam (Jack ''n Jill)' ORDER BY MaPhieuNhap DESC);

-- Coca-Cola
INSERT INTO dbo.ChiTietPhieuNhap (MaPhieuNhap, MaSP, MaVach, SoLuong, DonGiaNhap) VALUES
(@pn_coca, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Coca-Cola lon 330ml'),          '100001', 300,  7000),
(@pn_coca, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Coca-Cola Zero lon 330ml'),     '100002', 200,  7500),
(@pn_coca, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Sprite lon 330ml'),             '100003', 200,  7000),
(@pn_coca, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Fanta cam lon 330ml'),          '100004', 150,  7000),
(@pn_coca, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Fanta nho lon 330ml'),          '100005', 150,  7000),
(@pn_coca, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Dasani 500ml'),                 '100023', 400,  4000),
(@pn_coca, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Sprite chai 390ml'),            '100054', 200,  8000);

-- Suntory PepsiCo
INSERT INTO dbo.ChiTietPhieuNhap (MaPhieuNhap, MaSP, MaVach, SoLuong, DonGiaNhap) VALUES
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Pepsi lon 330ml'),               '100006', 300, 7000),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Pepsi Black 330ml'),             '100007', 200, 7500),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'7Up lon 330ml'),                 '100008', 200, 7000),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Mirinda cam lon 330ml'),         '100009', 200, 7000),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Mountain Dew lon 330ml'),        '100010', 150, 7500),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Aquafina 500ml'),                '100021', 400, 4000),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Aquafina 1.5L'),                 '100022', 200, 8000),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Revive Isotonic 500ml'),         '100016', 200, 8000),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Sting dâu 330ml'),               '100017', 250, 8000),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Sting vàng 330ml'),              '100018', 200, 8000),
(@pn_sps, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'TEA+ Ô Long 455ml'),             '100015', 250, 9000);

-- Tân Hiệp Phát
INSERT INTO dbo.ChiTietPhieuNhap (MaPhieuNhap, MaSP, MaVach, SoLuong, DonGiaNhap) VALUES
(@pn_thp, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Trà xanh Không Độ 455ml'),       '100011', 300, 8000),
(@pn_thp, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Dr Thanh 350ml'),                '100012', 300, 8000),
(@pn_thp, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Number 1 Active chanh muối 455ml'),'100013', 250, 8500),
(@pn_thp, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Number 1 Energy dâu 330ml'),     '100014', 250, 8000);

-- Vinamilk
INSERT INTO dbo.ChiTietPhieuNhap (MaPhieuNhap, MaSP, MaVach, SoLuong, DonGiaNhap) VALUES
(@pn_vnm, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Vinamilk 100% sữa tươi 180ml'),  '100024', 400, 6000),
(@pn_vnm, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Vinamilk 100% sữa tươi 1L'),     '100025', 200, 24000),
(@pn_vnm, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Vinamilk sữa chua ăn có đường 100g x4'),'100026',150, 15000),
(@pn_vnm, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Vinamilk Probi 65ml x5'),        '100027', 200, 20000);

-- TH True Milk
INSERT INTO dbo.ChiTietPhieuNhap (MaPhieuNhap, MaSP, MaVach, SoLuong, DonGiaNhap) VALUES
(@pn_th, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'TH true MILK 180ml'),             '100028', 300, 7000),
(@pn_th, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'TH true MILK 1L'),                '100029', 200, 24000),
(@pn_th, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'TH true Yogurt 100g x4'),         '100030', 160, 16000);

-- Acecook
INSERT INTO dbo.ChiTietPhieuNhap (MaPhieuNhap, MaSP, MaVach, SoLuong, DonGiaNhap) VALUES
(@pn_ace, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Hảo Hảo tôm chua cay 75g'),      '100031', 1000, 3000),
(@pn_ace, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Hảo Hảo sa tế hành 75g'),        '100032', 800,  3000),
(@pn_ace, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Hảo Hảo ly tôm chua cay 67g'),   '100033', 400,  6000),
(@pn_ace, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Phở Đệ Nhất bò 65g'),            '100034', 500,  4500),
(@pn_ace, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Đệ Nhất phở gà 65g'),            '100035', 500,  4500),
(@pn_ace, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Modern tôm chua cay 65g'),       '100040', 600,  3200);

-- Masan Consumer
INSERT INTO dbo.ChiTietPhieuNhap (MaPhieuNhap, MaSP, MaVach, SoLuong, DonGiaNhap) VALUES
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Omachi bò hầm 80g'),           '100036', 600, 5000),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Omachi xốt spaghetti 80g'),    '100037', 500, 6000),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Mì Omachi ly 72g'),            '100038', 400, 8000),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Kokomi 90g'),                  '100039', 1000,2500),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Nước mắm Nam Ngư 500ml'),      '100041', 200, 28000),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Nước tương Chinsu 500ml'),     '100042', 200, 25000),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Tương ớt Chinsu 250g'),        '100043', 300, 18000),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Dấm gạo Chinsu 500ml'),        '100044', 150, 16000),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Muối i-ốt Chinsu 500g'),       '100045', 200, 7000),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Hạt nêm Chinsu 400g'),         '100046', 200, 27000),
(@pn_masan, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Wake-Up 247 330ml'),           '100020', 250, 8000);

-- URC Vietnam
INSERT INTO dbo.ChiTietPhieuNhap (MaPhieuNhap, MaSP, MaVach, SoLuong, DonGiaNhap) VALUES
(@pn_urc, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Cream-O 137g'),                   '100047', 300, 12000),
(@pn_urc, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Fun-O 198g'),                     '100048', 250, 15000),
(@pn_urc, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Magic Flakes 25g x10'),           '100049', 200, 22000),
(@pn_urc, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Jack ''n Jill Potato Chips 60g'), '100050', 300, 12000),
(@pn_urc, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Jack ''n Jill Piattos 50g'),      '100051', 320, 10000),
(@pn_urc, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Jack ''n Jill Roller Coaster 60g'),'100052', 320, 12000),
(@pn_urc, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Dynamite 100g'),                  '100053', 260, 10000),
(@pn_urc, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'C2 Trà xanh 500ml'),              '100019', 320,  8000);

------------------------------------------------------------
-- 8) Hóa đơn bán hàng (mẫu) + chi tiết + cập nhật tổng tiền
------------------------------------------------------------
DECLARE @pt1 INT=(SELECT MaNV FROM dbo.NhanVien WHERE TenDangNhap=N'pt_hoa');
DECLARE @pt2 INT=(SELECT MaNV FROM dbo.NhanVien WHERE TenDangNhap=N'pt_huy');
DECLARE @pt3 INT=(SELECT MaNV FROM dbo.NhanVien WHERE TenDangNhap=N'pt_lan');

DECLARE @hd1 INT, @hd2 INT, @hd3 INT;

INSERT INTO dbo.HoaDon (MaNV, NgayLap, TongTien) VALUES (@pt1, '2025-09-10T09:15:00', 0); SET @hd1=SCOPE_IDENTITY();
INSERT INTO dbo.HoaDon (MaNV, NgayLap, TongTien) VALUES (@pt2, '2025-09-11T18:30:00', 0); SET @hd2=SCOPE_IDENTITY();
INSERT INTO dbo.HoaDon (MaNV, NgayLap, TongTien) VALUES (@pt3, '2025-09-12T19:45:00', 0); SET @hd3=SCOPE_IDENTITY();

INSERT INTO dbo.ChiTietHoaDon (MaHD, MaSP, SoLuong, DonGiaBan) VALUES
(@hd1, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Coca-Cola lon 330ml'), 2, 10000),
(@hd1, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Hảo Hảo tôm chua cay 75g'), 5, 5000),
(@hd1, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Cream-O 137g'), 1, 18000),

(@hd2, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Aquafina 500ml'), 3, 7000),
(@hd2, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Omachi bò hầm 80g'), 4, 8000),

(@hd3, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Vinamilk 100% sữa tươi 180ml'), 6, 9000),
(@hd3, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Jack ''n Jill Potato Chips 60g'), 2, 18000);


------------------------------------------------------------
-- 9) Hàng hủy & Trả hàng 
------------------------------------------------------------
-- Hàng hủy (ví dụ: Hết hạn / Hư hỏng)
INSERT INTO dbo.HangHuy (MaSanPham, MaVach, SoLuong, NgayHuy, LyDo, MaNhanVien) VALUES
((SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Vinamilk Probi 65ml x5'),      '100027', 10, '2025-09-05', N'Hết hạn', (SELECT MaNV FROM dbo.NhanVien WHERE TenDangNhap=N'admin_quan')),
((SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Jack ''n Jill Roller Coaster 60g'), '100052', 5,  '2025-09-06', N'Hư hỏng', (SELECT MaNV FROM dbo.NhanVien WHERE TenDangNhap=N'admin_hoang'));

-- Phiếu trả hàng về NCC 
INSERT INTO dbo.PhieuTraHang (MaPhieuTra, NgayTra, MaNhaCungCap, MaNhanVien, LyDo, TrangThai) VALUES
(1, '2025-09-12', (SELECT MaNCC FROM dbo.NhaCungCap WHERE TenNCC=N'Masan Consumer'),
 (SELECT MaNV FROM dbo.NhanVien WHERE TenDangNhap=N'admin_minh'), N'Hàng lỗi bao bì', N'Đã duyệt');

INSERT INTO dbo.ChiTietPhieuTra (MaPhieuTra, MaSanPham, MaVach, SoLuong, GhiChu) VALUES
(1, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Omachi xốt spaghetti 80g'), '100037', 40, N'Rách bao'),
(1, (SELECT MaSP FROM dbo.SanPham WHERE TenSP=N'Nước mắm Nam Ngư 500ml'),  '100041', 20, N'Nắp lỏng');

COMMIT;
PRINT N'Done: Seed dữ liệu đã được tạo thành công.';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT ERROR_MESSAGE();
    THROW;
END CATCH;
