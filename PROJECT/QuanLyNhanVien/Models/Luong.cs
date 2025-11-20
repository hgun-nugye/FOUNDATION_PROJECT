using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyNhanVien.Models
{
	public class Luong
	{
		[Key]
		public int MaLuong { get; set; }

		[Required]
		[StringLength(7)]
		public string MaNV { get; set; }

		[ForeignKey("MaNV")]
		public NhanVien NhanVien { get; set; }

		[Required]
		public decimal LuongCoBan { get; set; }

		public decimal PhuCap { get; set; }

		public decimal Thuong { get; set; }

		public decimal KhauTru { get; set; }

		[NotMapped]
		public decimal LuongThucLinh => LuongCoBan + PhuCap + Thuong - KhauTru;
	}
}
