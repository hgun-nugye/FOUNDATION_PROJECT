using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuanLyNhanVien.Models
{
	public class PhongBan
	{
		[Key]
		[StringLength(7, ErrorMessage = "Mã phòng ban tối đa 7 ký tự.")]
		public string MaPB { get; set; }   // VD: PB00001

		[Required(ErrorMessage = "Tên phòng ban không được để trống.")]
		[StringLength(100)]
		public string TenPB { get; set; }

		[StringLength(200)]
		public string DiaChi { get; set; }

		[StringLength(20)]
		public string SoDienThoai { get; set; }

		// Quan hệ 1 - N với nhân viên
		public ICollection<NhanVien> NhanViens { get; set; }
	}
}
