using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using System.Reflection.Metadata;

namespace quan_ly_san_cau_long_API.Models
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }
        public DbSet<San> Sans { get; set; }
        public DbSet<Gio> Gios { get; set; }
        public DbSet<PhieuDatSan> PhieuDatSans { get; set; }
        public DbSet<SanGio> SanGios { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserInfo> UserInfos { get; set; }
        public DbSet<Role> Roles { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

            // Mối quan hệ n-n giữa Sân và Giờ
            modelBuilder.Entity<SanGio>()
                .HasKey(sg => new { sg.SanId, sg.GioId });
            modelBuilder.Entity<SanGio>()
                .HasOne(sg => sg.San)
                .WithMany(s => s.SanGios)
                .HasForeignKey(sg => sg.SanId);
            modelBuilder.Entity<SanGio>()
                .HasOne(sg => sg.Gio)
                .WithMany(g => g.SanGios)
                .HasForeignKey(sg => sg.GioId);

           

           

            // User - UserInfo
            modelBuilder.Entity<User>()
                .HasOne(e => e.UserInfo)
                    .WithOne(e => e.User)
                .HasForeignKey<UserInfo>(e => e.UserId)
                .IsRequired();

            modelBuilder.Entity<UserInfo>()
                .HasOne(e => e.User)
                .WithOne(e => e.UserInfo)
                .HasForeignKey<UserInfo>(e => e.UserId)
                .IsRequired();

            // User - Role
            modelBuilder.Entity<Role>()
                .HasMany(e => e.Users)
                .WithOne(e => e.Role)
                .HasForeignKey(e => e.RoleId)
                    .IsRequired();

            modelBuilder.Entity<User>()
                .HasOne(e => e.Role)
                .WithMany(e => e.Users)
                .HasForeignKey(e => e.RoleId)
                .IsRequired();

            //PhieuDatSan - User
            modelBuilder.Entity<User>()
                .HasMany(e => e.PhieuDatSans)
                .WithOne(e => e.User)
                .HasForeignKey(e => e.UserId)
                    .IsRequired();

            modelBuilder.Entity<PhieuDatSan>()
                .HasOne(e => e.User)
                .WithMany(e => e.PhieuDatSans)
                .HasForeignKey(e => e.UserId)
                .IsRequired();

           
        }
    }
    
}
