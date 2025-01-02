namespace quan_ly_san_cau_long_API.Models
{
    public class Gio
    {
        public int Id { get; set; }
        public string ThoiGian { get; set; }
        public double DonGia { get; set; }
        public bool laCuoiTuan { get; set; }
        public ICollection<SanGio> SanGios { get; set; }
    }
}
