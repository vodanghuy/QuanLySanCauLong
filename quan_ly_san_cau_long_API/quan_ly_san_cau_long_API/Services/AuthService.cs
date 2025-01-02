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

        //public async Task<User> Authenticate(string username, string password)
        //{
        //    var hashedPassword = HashPassword(password);
        //    return await _context.Users.FirstOrDefaultAsync(u => u.TenDangNhap == username && u.MatKhau == password);
        //}

        private string HashPassword(string password)
        {
            using var sha256 = SHA256.Create();
            var bytes = Encoding.UTF8.GetBytes(password);
            var hash = sha256.ComputeHash(bytes);
            return Convert.ToBase64String(hash);
        }
    }

}
