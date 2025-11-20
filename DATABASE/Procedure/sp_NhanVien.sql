USE QLNhanVien;
GO

CREATE OR ALTER PROC NhanVien_Insert
    @HoTen NVARCHAR(MAX),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(3),
    @DiaChi NVARCHAR(MAX),
    @SDT VARCHAR(15),
    @Email VARCHAR(50),
    @MaPB CHAR(7),
    @MaCV CHAR(5),
    @LuongCoBan MONEY,
    @Anh NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @MaNV CHAR(12);

    -- Sinh mã tự động NV000000000x
    SELECT @MaNV = 'NV' + RIGHT('000000000' + CAST(ISNULL(MAX(CAST(SUBSTRING(MaNV,3,9) AS INT)),0) + 1 AS VARCHAR(9)),9)
    FROM NhanVien;

    -- Kiểm tra liên kết phòng ban, chức vụ
    IF NOT EXISTS (SELECT 1 FROM PhongBan WHERE MaPB=@MaPB)
    BEGIN
        RAISERROR(N'Mã phòng ban không tồn tại!',16,1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM ChucVu WHERE MaCV=@MaCV)
    BEGIN
        RAISERROR(N'Mã chức vụ không tồn tại!',16,1);
        RETURN;
    END

    -- Kiểm tra trùng SDT hoặc Email
    IF EXISTS (SELECT 1 FROM NhanVien WHERE SDT=@SDT OR Email=@Email)
    BEGIN
        RAISERROR(N'SĐT hoặc Email đã tồn tại!',16,1);
        RETURN;
    END

    INSERT INTO NhanVien(MaNV,HoTen,NgaySinh,GioiTinh,DiaChi,SDT,Email,MaPB,MaCV,NgayVaoLam,LuongCoBan,Anh)
    VALUES(@MaNV,@HoTen,@NgaySinh,@GioiTinh,@DiaChi,@SDT,@Email,@MaPB,@MaCV,GETDATE(),@LuongCoBan,@Anh);
END;
GO

CREATE OR ALTER PROC NhanVien_Update
    @MaNV CHAR(12),
    @HoTen NVARCHAR(MAX),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(3),
    @DiaChi NVARCHAR(MAX),
    @SDT VARCHAR(15),
    @Email VARCHAR(50),
    @MaPB CHAR(7),
    @MaCV CHAR(5),
    @LuongCoBan MONEY,
    @Anh NVARCHAR(255)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV=@MaNV)
    BEGIN
        RAISERROR(N'Mã nhân viên không tồn tại!',16,1);
        RETURN;
    END
    UPDATE NhanVien
    SET HoTen=@HoTen, NgaySinh=@NgaySinh, GioiTinh=@GioiTinh,
        DiaChi=@DiaChi, SDT=@SDT, Email=@Email,
        MaPB=@MaPB, MaCV=@MaCV, LuongCoBan=@LuongCoBan, Anh=@Anh
    WHERE MaNV=@MaNV;
END;
GO

CREATE OR ALTER PROC NhanVien_Delete
    @MaNV CHAR(12)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV=@MaNV)
    BEGIN
        RAISERROR(N'Mã nhân viên không tồn tại!',16,1);
        RETURN;
    END
    DELETE FROM NhanVien WHERE MaNV=@MaNV;
END;
GO

CREATE OR ALTER PROC NhanVien_GetAll
AS
BEGIN
    SELECT nv.*, pb.TenPB as TenPB, cv.TenCV as TenCV, cv.HeSoLuong
    FROM NhanVien nv
    JOIN PhongBan pb ON nv.MaPB=pb.MaPB
    JOIN ChucVu cv ON nv.MaCV=cv.MaCV;
END;
GO

CREATE OR ALTER PROC NhanVien_GetByID
	@MaNV CHAR(12)
AS
BEGIN
    SELECT nv.*, pb.TenPB as TenPB, cv.TenCV as TenCV, cv.HeSoLuong
    FROM NhanVien nv
    JOIN PhongBan pb ON nv.MaPB=pb.MaPB
    JOIN ChucVu cv ON nv.MaCV=cv.MaCV
	WHERE nv.MaNV=@MaNV
END;
GO
