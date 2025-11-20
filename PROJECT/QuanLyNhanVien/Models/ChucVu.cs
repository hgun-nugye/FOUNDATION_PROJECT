using System.ComponentModel.DataAnnotations;

namespace QuanLyNhanVien.Models
{
	public class ChucVu
	{
		[Key]
		[StringLength(7)]
		public string MaCV { get; set; }  // Ví dụ: CV00001

		[Required(ErrorMessage = "Tên chức vụ không được để trống.")]
		[StringLength(100)]
		public string TenCV { get; set; }

		[StringLength(200)]
		public string MoTa { get; set; }

		// Quan hệ 1 - N với nhân viên
		public ICollection<NhanVien> NhanViens { get; set; }
	}
}
