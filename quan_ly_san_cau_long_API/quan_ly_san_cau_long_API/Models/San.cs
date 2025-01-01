namespace quan_ly_san_cau_long_API.Models
{
    public class San
    {
        public int Id { get; set; }
        public int TenSan { get; set; }
        public ICollection<SanGio> SanGios { get; set; }
        public ICollection<PhieuDatSanGio> PhieuDatSanGios { get; set; }
    }
}
