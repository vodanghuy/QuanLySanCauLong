namespace quan_ly_san_cau_long_API.Models
{
    public class PhieuDatSanGio
    {
        public int Id { get; set; }
        public int PhieuDatSanId { get; set; }
        public int SanId { get; set; }
        public DateTime NgayDat { get; set; }
        public PhieuDatSan PhieuDatSan { get; set; }
        public San San { get; set; }
    }
}
