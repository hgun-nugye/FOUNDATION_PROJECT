USE QLNhanVien;
GO

-- ======== DỮ LIỆU PHÒNG BAN ========
INSERT INTO PhongBan (MaPB, TenPB, MoTa)
VALUES
('PB00001', N'Kinh Doanh', N'Phụ trách bán hàng và chăm sóc khách hàng'),
('PB00002', N'Kế Toán', N'Quản lý tài chính, sổ sách kế toán'),
('PB00003', N'Nhân Sự', N'Tuyển dụng và quản lý nhân sự'),
('PB00004', N'Kỹ Thuật', N'Bảo trì, phát triển và hỗ trợ kỹ thuật');
GO

-- ======== DỮ LIỆU CHỨC VỤ ========
INSERT INTO ChucVu (MaCV, TenCV, HeSoLuong)
VALUES
('CV001', N'Giám Đốc', 5.0),
('CV002', N'Trưởng Phòng', 3.5),
('CV003', N'Nhân Viên', 2.0),
('CV004', N'Thực Tập Sinh', 1.0);
GO

-- ======== DỮ LIỆU NHÂN VIÊN ========
INSERT INTO NhanVien (MaNV, HoTen, NgaySinh, GioiTinh, DiaChi, SDT, Email, MaPB, MaCV, NgayVaoLam, LuongCoBan, Anh)
VALUES
('NV0000000001', N'Nguyễn Văn A', '1990-03-15', N'Nam', N'Hà Nội', '0901234567', 'nguyenvana@gmail.com', 'PB00001', 'CV002', '2015-06-01', 15000000, N'anhA.jpg'),
('NV0000000002', N'Trần Thị B', '1995-07-20', N'Nữ', N'Đà Nẵng', '0912345678', 'tranthib@gmail.com', 'PB00002', 'CV003', '2018-05-15', 9000000, N'anhB.jpg'),
('NV0000000003', N'Lê Hoàng C', '1992-12-05', N'Nam', N'Hồ Chí Minh', '0923456789', 'lehoangc@gmail.com', 'PB00003', 'CV003', '2019-09-10', 10000000, N'anhC.jpg'),
('NV0000000004', N'Phạm Mỹ D', '2000-02-22', N'Nữ', N'Hải Phòng', '0934567890', 'phammyd@gmail.com', 'PB00004', 'CV004', '2023-01-02', 6000000, N'anhD.jpg');
GO

-- ======== DỮ LIỆU LƯƠNG ========
INSERT INTO Luong (MaNV, Thang, Nam, SoNgayCong, Thuong, Phat)
VALUES
('NV0000000001', 10, 2025, 26, 2000000, 500000),
('NV0000000002', 10, 2025, 25, 1500000, 0),
('NV0000000003', 10, 2025, 27, 1000000, 300000),
('NV0000000004', 10, 2025, 22, 500000, 0);
GO
