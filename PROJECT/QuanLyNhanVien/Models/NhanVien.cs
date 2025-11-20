namespace QuanLyNhanVien.Models;
using Microsoft.AspNetCore.Http;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class NhanVien
{
	[Key]
	[StringLength(12)]
	public string MaNV { get; set; }
	public string HoTen { get; set; }
	public DateTime? NgaySinh { get; set; }
	public string GioiTinh { get; set; }
	public string DiaChi { get; set; }
	public string SDT { get; set; }
	public string Email { get; set; }
	public string MaPB { get; set; }
	public string TenPB { get; set; }
	public string MaCV { get; set; } = string.Empty;
	public string TenCV { get; set; }
	public DateTime? NgayVaoLam { get; set; }
	public decimal LuongCoBan { get; set; }
	public string Anh { get; set; }

	// File upload
	[NotMapped]
	public IFormFile? AnhFile { get; set; }

	[ForeignKey(nameof(MaPB))]
	public PhongBan? PhongBan { get; set; }

	[ForeignKey(nameof(MaCV))]
	public ChucVu? ChucVu { get; set; }
}
