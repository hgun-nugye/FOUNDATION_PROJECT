USE QLNhanVien;
GO

-- Tự động tạo mã PBxxxxx
CREATE OR ALTER PROC sp_PhongBan_Insert
    @TenPB NVARCHAR(50),
    @MoTa NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @MaPB CHAR(7);

    -- Tạo mã tự động
    SELECT @MaPB = 'PB' + RIGHT('00000' + CAST(ISNULL(MAX(CAST(SUBSTRING(MaPB, 3, 5) AS INT)), 0) + 1 AS VARCHAR(5)), 5)
    FROM PhongBan;

    -- Kiểm tra trùng tên
    IF EXISTS (SELECT 1 FROM PhongBan WHERE TenPB = @TenPB)
    BEGIN
        RAISERROR(N'Tên phòng ban đã tồn tại!', 16, 1);
        RETURN;
    END

    INSERT INTO PhongBan(MaPB, TenPB, MoTa)
    VALUES (@MaPB, @TenPB, @MoTa);
END;
GO

CREATE OR ALTER PROC sp_PhongBan_Update
    @MaPB CHAR(7),
    @TenPB NVARCHAR(50),
    @MoTa NVARCHAR(200)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM PhongBan WHERE MaPB = @MaPB)
    BEGIN
        RAISERROR(N'Không tồn tại mã phòng ban này!', 16, 1);
        RETURN;
    END
    UPDATE PhongBan SET TenPB=@TenPB, MoTa=@MoTa WHERE MaPB=@MaPB;
END;
GO

CREATE OR ALTER PROC sp_PhongBan_Delete
    @MaPB CHAR(7)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM PhongBan WHERE MaPB=@MaPB)
    BEGIN
        RAISERROR(N'Mã phòng ban không tồn tại!',16,1);
        RETURN;
    END
    DELETE FROM PhongBan WHERE MaPB=@MaPB;
END;
GO

CREATE OR ALTER PROC sp_PhongBan_GetAll
AS
BEGIN
    SELECT * FROM PhongBan;
END;
GO
