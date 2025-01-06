namespace quan_ly_san_cau_long_API.DTOs
{
    public class PhieuDatSanDto
    {
        public int UserId { get; set; }
        public Dictionary<int, DateTime> SanNgayDatMap { get; set; } // Map sân và ngày đặt
        public Dictionary<int, List<int>> SanGioMap { get; set; }
    }
}
