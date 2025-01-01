namespace quan_ly_san_cau_long_API.Models
{
    public class Role
    {
        public int Id { get; set; }
        public string Ten { get; set; }
        public ICollection<User> Users { get; set; }
    }
}
