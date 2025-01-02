namespace quan_ly_san_cau_long_API.Models
{
    public class SanGio
    {
        public int Id { get; set; }
        public int SanId { get; set; }
        public int GioId { get; set; }
        public San San { get; set; }
        public Gio Gio { get; set; }
    }
}
