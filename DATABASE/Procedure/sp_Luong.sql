USE QLNhanVien;
GO

CREATE OR ALTER PROC sp_Luong_Insert
    @MaNV CHAR(12),
    @Thang INT,
    @Nam INT,
    @SoNgayCong INT,
    @Thuong MONEY,
    @Phat MONEY
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV=@MaNV)
    BEGIN
        RAISERROR(N'Mã nhân viên không tồn tại!',16,1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Luong WHERE MaNV=@MaNV AND Thang=@Thang AND Nam=@Nam)
    BEGIN
        RAISERROR(N'Lương tháng này của nhân viên đã tồn tại!',16,1);
        RETURN;
    END
    INSERT INTO Luong(MaNV,Thang,Nam,SoNgayCong,Thuong,Phat)
    VALUES(@MaNV,@Thang,@Nam,@SoNgayCong,@Thuong,@Phat);
END;
GO

CREATE OR ALTER PROC sp_Luong_Update
    @MaLuong INT,
    @SoNgayCong INT,
    @Thuong MONEY,
    @Phat MONEY
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Luong WHERE MaLuong=@MaLuong)
    BEGIN
        RAISERROR(N'Mã lương không tồn tại!',16,1);
        RETURN;
    END
    UPDATE Luong SET SoNgayCong=@SoNgayCong, Thuong=@Thuong, Phat=@Phat WHERE MaLuong=@MaLuong;
END;
GO

CREATE OR ALTER PROC sp_Luong_Delete
    @MaLuong INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Luong WHERE MaLuong=@MaLuong)
    BEGIN
        RAISERROR(N'Mã lương không tồn tại!',16,1);
        RETURN;
    END
    DELETE FROM Luong WHERE MaLuong=@MaLuong;
END;
GO

CREATE OR ALTER PROC sp_Luong_GetAll
AS
BEGIN
    SELECT l.*, nv.HoTen, nv.LuongCoBan, (nv.LuongCoBan + l.Thuong - l.Phat) AS TongLuong
    FROM Luong l
    JOIN NhanVien nv ON l.MaNV=nv.MaNV;
END;
GO