﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using quan_ly_san_cau_long_API.Models;

#nullable disable

namespace quan_ly_san_cau_long_API.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    [Migration("20250101111953_AddRoleUserInfo")]
    partial class AddRoleUserInfo
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.10")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.Gio", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<double>("DonGia")
                        .HasColumnType("float");

                    b.Property<string>("ThoiGian")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("laCuoiTuan")
                        .HasColumnType("bit");

                    b.HasKey("Id");

                    b.ToTable("Gios");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.PhieuDatSan", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("NgayTao")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.ToTable("PhieuDatSans");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.PhieuDatSanGio", b =>
                {
                    b.Property<int>("SanId")
                        .HasColumnType("int");

                    b.Property<int>("PhieuDatSanId")
                        .HasColumnType("int");

                    b.Property<int>("Id")
                        .HasColumnType("int");

                    b.Property<DateTime>("NgayDat")
                        .HasColumnType("datetime2");

                    b.HasKey("SanId", "PhieuDatSanId");

                    b.HasIndex("PhieuDatSanId");

                    b.ToTable("PhieuDatSanGios");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.Role", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Ten")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Roles");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.San", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("TenSan")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.ToTable("Sans");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.SanGio", b =>
                {
                    b.Property<int>("SanId")
                        .HasColumnType("int");

                    b.Property<int>("GioId")
                        .HasColumnType("int");

                    b.Property<int>("Id")
                        .HasColumnType("int");

                    b.HasKey("SanId", "GioId");

                    b.HasIndex("GioId");

                    b.ToTable("SanGios");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("MatKhau")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("RoleId")
                        .HasColumnType("int");

                    b.Property<string>("TenDangNhap")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.UserInfo", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("GioiTinh")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("SDT")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("UserId")
                        .IsUnique();

                    b.ToTable("UserInfos");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.PhieuDatSanGio", b =>
                {
                    b.HasOne("quan_ly_san_cau_long_API.Models.PhieuDatSan", "PhieuDatSan")
                        .WithMany("PhieuDatSanGios")
                        .HasForeignKey("PhieuDatSanId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("quan_ly_san_cau_long_API.Models.San", "San")
                        .WithMany("PhieuDatSanGios")
                        .HasForeignKey("SanId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("PhieuDatSan");

                    b.Navigation("San");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.SanGio", b =>
                {
                    b.HasOne("quan_ly_san_cau_long_API.Models.Gio", "Gio")
                        .WithMany("SanGios")
                        .HasForeignKey("GioId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("quan_ly_san_cau_long_API.Models.San", "San")
                        .WithMany("SanGios")
                        .HasForeignKey("SanId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Gio");

                    b.Navigation("San");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.User", b =>
                {
                    b.HasOne("quan_ly_san_cau_long_API.Models.Role", "Role")
                        .WithMany("Users")
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Role");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.UserInfo", b =>
                {
                    b.HasOne("quan_ly_san_cau_long_API.Models.User", "User")
                        .WithOne("UserInfo")
                        .HasForeignKey("quan_ly_san_cau_long_API.Models.UserInfo", "UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.Gio", b =>
                {
                    b.Navigation("SanGios");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.PhieuDatSan", b =>
                {
                    b.Navigation("PhieuDatSanGios");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.Role", b =>
                {
                    b.Navigation("Users");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.San", b =>
                {
                    b.Navigation("PhieuDatSanGios");

                    b.Navigation("SanGios");
                });

            modelBuilder.Entity("quan_ly_san_cau_long_API.Models.User", b =>
                {
                    b.Navigation("UserInfo");
                });
#pragma warning restore 612, 618
        }
    }
}
