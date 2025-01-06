namespace quan_ly_san_cau_long_API.Models
{
    public class SanGio
    {
        public int SanId { get; set; } // ID của sân
        public San San { get; set; } // Thông tin sân

        public int GioId { get; set; } // ID của giờ
        public Gio Gio { get; set; } // Thông tin giờ
    }
}
