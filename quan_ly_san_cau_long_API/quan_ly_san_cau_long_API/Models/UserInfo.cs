namespace quan_ly_san_cau_long_API.Models
{
    public class UserInfo
    {
        public int Id { get; set; }
        public string HoTen { get; set; }
        public string Email { get; set; }
        public string SDT { get; set; }
        public string GioiTinh { get; set; }

        public int UserId { get; set; }
        public User User { get; set; }
    }
}
