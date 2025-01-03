namespace quan_ly_san_cau_long_API.Models
{
    public class PhieuDatSan
    {
        public int Id { get; set; }
        public DateTime NgayTao { get; set; }
        public double TongTien { get; set; }
        public int UserId { get; set; }
        public User User { get; set; }
        public ICollection<PhieuDatSanGio> PhieuDatSanGios { get; set; }
    }
}
