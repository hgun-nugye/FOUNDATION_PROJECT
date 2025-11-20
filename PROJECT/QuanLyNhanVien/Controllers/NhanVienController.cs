using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using QuanLyNhanVien.Data;
using QuanLyNhanVien.Models;

namespace QuanLyNhanVien.Controllers
{

	public class NhanVienController : Controller
	{
		private readonly AppDbContext _context;

		public NhanVienController(AppDbContext context)
		{
			_context = context;
		}

		// =============================
		// DANH SÁCH
		// =============================
		public async Task<IActionResult> Index()
		{
			var ds = await _context.NhanViens
				.FromSqlRaw("EXEC NhanVien_GetAll")
				.ToListAsync();

			return View(ds);
		}

		// =============================
		// CHI TIẾT
		// =============================
		public async Task<IActionResult> Details(string id)
		{
			if (id == null) return NotFound();

			var nv = (await _context.NhanViens
				.FromSqlRaw("EXEC NhanVien_GetByID @MaNV",
					new SqlParameter("@MaNV", id))
				.ToListAsync()).FirstOrDefault();

			return View(nv);
		}

		// =============================
		// CREATE - GET
		// =============================
		public IActionResult Create()
		{
			ViewBag.PhongBan = new SelectList(_context.PhongBan, "MaPB", "TenPB");
			ViewBag.ChucVu = new SelectList(_context.ChucVu, "MaCV", "TenCV");
			return View();
		}

		// =============================
		// CREATE - POST
		// =============================
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> Create(NhanVien nv)
		{
			try
			{
				if (nv.AnhFile == null)
				{
					TempData["Error"] = "Vui lòng chọn ảnh!";
					return View(nv);
				}

				// upload ảnh
				string fileName = Guid.NewGuid() + Path.GetExtension(nv.AnhFile.FileName);
				string folder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images");
				if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);

				string savePath = Path.Combine(folder, fileName);
				using (var stream = new FileStream(savePath, FileMode.Create))
				{
					await nv.AnhFile.CopyToAsync(stream);
				}

				nv.Anh = fileName;

				await _context.Database.ExecuteSqlRawAsync(
					"EXEC NhanVien_Insert @HoTen, @NgaySinh, @GioiTinh, @DiaChi, @SDT, @Email, @MaPB, @MaCV, @NgayVaoLam, @Luong, @Anh",
					new SqlParameter("@HoTen", nv.HoTen),
					new SqlParameter("@NgaySinh", nv.NgaySinh ?? (object)DBNull.Value),
					new SqlParameter("@GioiTinh", nv.GioiTinh),
					new SqlParameter("@DiaChi", nv.DiaChi ?? (object)DBNull.Value),
					new SqlParameter("@SDT", nv.SDT ?? (object)DBNull.Value),
					new SqlParameter("@Email", nv.Email ?? (object)DBNull.Value),
					new SqlParameter("@MaPB", nv.MaPB),
					new SqlParameter("@MaCV", nv.MaCV),
					new SqlParameter("@NgayVaoLam", nv.NgayVaoLam ?? DateTime.Now),
					new SqlParameter("@Luong", nv.LuongCoBan),
					new SqlParameter("@Anh", nv.Anh)
				);

				TempData["Success"] = "Thêm nhân viên thành công!";
				return RedirectToAction(nameof(Index));
			}
			catch (Exception ex)
			{
				TempData["Error"] = ex.Message;
			}

			return View(nv);
		}

		// =============================
		// EDIT - GET
		// =============================
		public async Task<IActionResult> Edit(string id)
		{
			var nv = (await _context.NhanViens
				.FromSqlRaw("EXEC NhanVien_GetByID @MaNV",
					new SqlParameter("@MaNV", id))
				.ToListAsync())
				.FirstOrDefault();

			ViewBag.PhongBan = new SelectList(_context.PhongBan, "MaPB", "TenPB", nv.MaPB);
			ViewBag.ChucVu = new SelectList(_context.ChucVu, "MaCV", "TenCV", nv.MaCV);

			return View(nv);
		}

		// =============================
		// EDIT - POST
		// =============================
		[HttpPost]
		public async Task<IActionResult> Edit(string id, NhanVien nv, IFormFile? AnhFile)
		{
			try
			{
				// lấy bản ghi cũ
				var old = await _context.NhanViens
					.AsNoTracking()
					.FirstOrDefaultAsync(x => x.MaNV == id);

				if (old == null) return NotFound();

				string img = old.Anh;

				if (AnhFile != null)
				{
					string fileName = Guid.NewGuid() + Path.GetExtension(AnhFile.FileName);
					string save = Path.Combine("wwwroot/images", fileName);

					using (var stream = new FileStream(save, FileMode.Create))
					{
						await AnhFile.CopyToAsync(stream);
					}
					img = fileName;
				}

				await _context.Database.ExecuteSqlRawAsync(
					"EXEC NhanVien_Update @MaNV, @HoTen, @NgaySinh, @GioiTinh, @DiaChi, @SDT, @Email, @MaPB, @MaCV, @NgayVaoLam, @Luong, @Anh",
					new SqlParameter("@MaNV", id),
					new SqlParameter("@HoTen", nv.HoTen),
					new SqlParameter("@NgaySinh", nv.NgaySinh ?? (object)DBNull.Value),
					new SqlParameter("@GioiTinh", nv.GioiTinh),
					new SqlParameter("@DiaChi", nv.DiaChi ?? (object)DBNull.Value),
					new SqlParameter("@SDT", nv.SDT ?? (object)DBNull.Value),
					new SqlParameter("@Email", nv.Email ?? (object)DBNull.Value),
					new SqlParameter("@MaPB", nv.MaPB),
					new SqlParameter("@MaCV", nv.MaCV),
					new SqlParameter("@NgayVaoLam", nv.NgayVaoLam ?? (object)DBNull.Value),
					new SqlParameter("@Luong", nv.LuongCoBan),
					new SqlParameter("@Anh", img)
				);

				TempData["Success"] = "Cập nhật thành công!";
				return RedirectToAction(nameof(Index));
			}
			catch (Exception ex)
			{
				TempData["Error"] = ex.Message;
			}

			return View(nv);
		}

		// =============================
		// DELETE
		// =============================
		public async Task<IActionResult> Delete(string id)
		{
			var nv = (await _context.NhanViens
				.FromSqlRaw("EXEC NhanVien_GetByID @MaNV",
					new SqlParameter("@MaNV", id))
				.ToListAsync())
				.FirstOrDefault();

			return View(nv);
		}

		[HttpPost, ActionName("Delete")]
		public async Task<IActionResult> DeleteConfirmed(string id)
		{
			await _context.Database.ExecuteSqlRawAsync(
				"EXEC NhanVien_Delete @MaNV",
				new SqlParameter("@MaNV", id));

			TempData["Success"] = "Xóa thành công!";
			return RedirectToAction(nameof(Index));
		}
	}
}


