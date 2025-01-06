namespace quan_ly_san_cau_long_API.DTOs
{
    public class SanGioResponseDto
    {
        public int SanId { get; set; } // ID của sân
        public string TenSan { get; set; } // Tên sân
        public List<GioStatusDto> Gios { get; set; } // Danh sách giờ và trạng thái
    }

    public class GioStatusDto
    {
        public int GioId { get; set; } // ID giờ
        public string Gio { get; set; } // Thời gian (VD: "18:00")
        public double DonGia { get; set; } // Giá giờ chơi
        public bool IsBooked { get; set; } // Trạng thái: true nếu đã đặt, false nếu còn trống
    }

}
