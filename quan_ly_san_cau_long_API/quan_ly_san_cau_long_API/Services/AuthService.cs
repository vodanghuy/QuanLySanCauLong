using Microsoft.EntityFrameworkCore;
using quan_ly_san_cau_long_API.Models;
using System.Security.Cryptography;
using System.Text;

namespace quan_ly_san_cau_long_API.Services
{


    public class AuthService
    {
        private readonly ApplicationDbContext _context;

        public AuthService(ApplicationDbContext context)
        {
            _context = context;
        }

        // Kiểm tra tên đăng nhập đã tồn tại hay chưa
        public async Task<bool> IsUsernameTaken(string username)
        {
            return await _context.Users.AnyAsync(u => u.TenDangNhap == username);
        }

        // Đăng ký người dùng mới
        public async Task<bool> RegisterUser(User user)
        {
            try
            {
                _context.Users.Add(user);
                await _context.SaveChangesAsync();
                return true;
            }
            catch
            {
                return false;
            }
        }

        // Hàm băm mật khẩu (giữ nguyên như trước)
        public string HashPassword(string password)
        {
            using var sha256 = SHA256.Create();
            var bytes = Encoding.UTF8.GetBytes(password);
            var hash = sha256.ComputeHash(bytes);
            return Convert.ToBase64String(hash);
        }

        // Xác thực người dùng (giữ nguyên như trước)
        public async Task<User> Authenticate(string username, string password)
        {
            var hashedPassword = HashPassword(password);
            return await _context.Users
                .Include(u => u.UserInfo) // Bao gồm thông tin UserInfo
                .FirstOrDefaultAsync(u => u.TenDangNhap == username && u.MatKhau == hashedPassword);
        }
    }

}
