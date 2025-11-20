using Microsoft.EntityFrameworkCore;
using QuanLyNhanVien.Models;

namespace QuanLyNhanVien.Data
{
	public class AppDbContext : DbContext
	{
		public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
		{
		}
		public DbSet<NhanVien> NhanViens { get; set; }
		public DbSet<PhongBan> PhongBan { get; set; }
		public DbSet<ChucVu> ChucVu { get; set; }
		public DbSet<Luong> Luong { get; set; }


	}
}
