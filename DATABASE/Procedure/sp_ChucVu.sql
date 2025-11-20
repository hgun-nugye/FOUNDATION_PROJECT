USE QLNhanVien;
GO

CREATE OR ALTER PROC ChucVu_Insert
    @TenCV NVARCHAR(50),
    @HeSoLuong FLOAT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @MaCV CHAR(5);
    SELECT @MaCV = 'CV' + RIGHT('000' + CAST(ISNULL(MAX(CAST(SUBSTRING(MaCV, 3, 3) AS INT)), 0) + 1 AS VARCHAR(3)), 3)
    FROM ChucVu;

    IF EXISTS (SELECT 1 FROM ChucVu WHERE TenCV=@TenCV)
    BEGIN
        RAISERROR(N'Tên chức vụ đã tồn tại!',16,1);
        RETURN;
    END

    INSERT INTO ChucVu(MaCV,TenCV,HeSoLuong)
    VALUES(@MaCV,@TenCV,@HeSoLuong);
END;
GO

CREATE OR ALTER PROC ChucVu_Update
    @MaCV CHAR(5),
    @TenCV NVARCHAR(50),
    @HeSoLuong FLOAT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ChucVu WHERE MaCV=@MaCV)
    BEGIN
        RAISERROR(N'Mã chức vụ không tồn tại!',16,1);
        RETURN;
    END
    UPDATE ChucVu SET TenCV=@TenCV, HeSoLuong=@HeSoLuong WHERE MaCV=@MaCV;
END;
GO

CREATE OR ALTER PROC ChucVu_Delete
    @MaCV CHAR(5)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ChucVu WHERE MaCV=@MaCV)
    BEGIN
        RAISERROR(N'Mã chức vụ không tồn tại!',16,1);
        RETURN;
    END
    DELETE FROM ChucVu WHERE MaCV=@MaCV;
END;
GO

CREATE OR ALTER PROC ChucVu_GetAll
AS
BEGIN
    SELECT * FROM ChucVu;
END;
GO
