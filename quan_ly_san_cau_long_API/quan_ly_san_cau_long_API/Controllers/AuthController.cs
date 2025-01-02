using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using quan_ly_san_cau_long_API.DTOs;
using quan_ly_san_cau_long_API.Models;
using quan_ly_san_cau_long_API.Services;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace quan_ly_san_cau_long_API.Controllers
{
    
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly ApplicationDbContext _context;

        public AuthController(IConfiguration configuration, ApplicationDbContext context)
        {
            _configuration = configuration;
            _context = context;
        }

        [HttpPost]
        [Route("login")]
        public async Task<IActionResult> Login([FromBody] DTOs.LoginRequest request)
        {
            var user = await _context.Users
                .Include(u => u.Role)
                .Include(u => u.UserInfo)
                .FirstOrDefaultAsync(u => u.TenDangNhap == request.TenDangNhap);

            if (user == null || user.MatKhau != request.MatKhau)
            {
                return Unauthorized(new { message = "Tên đăng nhập hoặc mật khẩu không đúng." });
            }

            var token = GenerateJwtToken(user);

            var result = new
            {
                tenDangNhap = user.TenDangNhap,
                role = user.Role.Ten,
                token = token,
                userInfo = user.UserInfo != null ? new
                {
                    hoTen = user.UserInfo.HoTen,
                    email = user.UserInfo.Email,
                    sdt = user.UserInfo.SDT,
                    gioiTinh = user.UserInfo.GioiTinh
                } : null
            };

            return Ok(result);
        }

        private string GenerateJwtToken(User user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:SigningKey"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
            new Claim(JwtRegisteredClaimNames.Sub, user.TenDangNhap),
            new Claim("role", user.Role.Ten),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddHours(1),
                signingCredentials: credentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}
