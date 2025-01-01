using Microsoft.AspNetCore.Identity;

namespace quan_ly_san_cau_long_API.Models
{
    public class User
    {
        public int Id { get; set; }
        public string MatKhau { get; set; }
        public string TenDangNhap { get; set; }
        public int RoleId { get; set; }
        public Role Role { get; set; }
        public UserInfo? UserInfo { get; set; }
    }
}
