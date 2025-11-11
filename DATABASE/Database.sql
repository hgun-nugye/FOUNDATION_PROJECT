-- Tạo Database
CREATE DATABASE QLNhanVien;
GO
USE QLNhanVien;
GO

-- Bảng Phòng Ban
CREATE TABLE PhongBan (
    MaPB CHAR(7) PRIMARY KEY, -- maPB dạng PB0000x
    TenPB NVARCHAR(50) NOT NULL,
    MoTa NVARCHAR(200)
);
GO

-- Bảng Chức Vụ
CREATE TABLE ChucVu (
    MaCV CHAR(5) PRIMARY KEY, -- MaCV dạng CV00x
    TenCV NVARCHAR(50) NOT NULL,
    HeSoLuong FLOAT CHECK (HeSoLuong > 0)
);
GO

-- Bảng Nhân Viên
CREATE TABLE NhanVien (
    MaNV CHAR(12) PRIMARY KEY, -- MaNV dạng NV000000000x
    HoTen NVARCHAR(MAX) NOT NULL,
    NgaySinh DATE,
    GioiTinh NVARCHAR(3) CHECK (GioiTinh IN (N'Nam',N'Nữ')),
    DiaChi NVARCHAR(MAX),
    SDT VARCHAR(15),
    Email VARCHAR(50),
    MaPB CHAR(7) FOREIGN KEY REFERENCES PhongBan(MaPB),
    MaCV CHAR(5) FOREIGN KEY REFERENCES ChucVu(MaCV),
    NgayVaoLam DATE DEFAULT GETDATE(),
    LuongCoBan MONEY CHECK (LuongCoBan > 0),
    Anh NVARCHAR(255)
);
GO

-- Bảng Lương
CREATE TABLE Luong (
    MaLuong INT IDENTITY(1,1) PRIMARY KEY,
    MaNV CHAR(12) FOREIGN KEY REFERENCES NhanVien(MaNV),
    Thang INT CHECK (Thang BETWEEN 1 AND 12),
    Nam INT,
    SoNgayCong INT,
    Thuong MONEY DEFAULT 0,
    Phat MONEY DEFAULT 0,
);
GO
