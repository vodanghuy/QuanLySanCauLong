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
        public DbSet<PhieuDatSanGio> PhieuDatSanGios { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserInfo> UserInfos { get; set; }
        public DbSet<Role> Roles { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

            // Cấu hình San - Gio
            modelBuilder.Entity<SanGio>()
            .HasKey(pt => new { pt.SanId, pt.GioId }); // Composite key

            modelBuilder.Entity<SanGio>()
                .HasOne(pt => pt.San)
                .WithMany(p => p.SanGios)
                .HasForeignKey(pt => pt.SanId);

            modelBuilder.Entity<SanGio>()
                .HasOne(pt => pt.Gio)
                .WithMany(t => t.SanGios)
                .HasForeignKey(pt => pt.GioId);

            // Cấu hình PhieuDatSan - San
            modelBuilder.Entity<PhieuDatSanGio>()
            .HasKey(pt => new { pt.SanId, pt.PhieuDatSanId }); // Composite key

            modelBuilder.Entity<PhieuDatSanGio>()
                .HasOne(pt => pt.San)
                .WithMany(p => p.PhieuDatSanGios)
                .HasForeignKey(pt => pt.SanId);

            modelBuilder.Entity<PhieuDatSanGio>()
                .HasOne(pt => pt.PhieuDatSan)
                .WithMany(t => t.PhieuDatSanGios)
                .HasForeignKey(pt => pt.PhieuDatSanId);

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
