using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace quan_ly_san_cau_long_API.Migrations
{
    /// <inheritdoc />
    public partial class InitialUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Gios",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ThoiGian = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DonGia = table.Column<double>(type: "float", nullable: false),
                    laCuoiTuan = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Gios", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "PhieuDatSans",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NgayTao = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PhieuDatSans", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Sans",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TenSan = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Sans", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "PhieuDatSanGios",
                columns: table => new
                {
                    PhieuDatSanId = table.Column<int>(type: "int", nullable: false),
                    SanId = table.Column<int>(type: "int", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false),
                    NgayDat = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PhieuDatSanGios", x => new { x.SanId, x.PhieuDatSanId });
                    table.ForeignKey(
                        name: "FK_PhieuDatSanGios_PhieuDatSans_PhieuDatSanId",
                        column: x => x.PhieuDatSanId,
                        principalTable: "PhieuDatSans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PhieuDatSanGios_Sans_SanId",
                        column: x => x.SanId,
                        principalTable: "Sans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SanGios",
                columns: table => new
                {
                    SanId = table.Column<int>(type: "int", nullable: false),
                    GioId = table.Column<int>(type: "int", nullable: false),
                    Id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SanGios", x => new { x.SanId, x.GioId });
                    table.ForeignKey(
                        name: "FK_SanGios_Gios_GioId",
                        column: x => x.GioId,
                        principalTable: "Gios",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SanGios_Sans_SanId",
                        column: x => x.SanId,
                        principalTable: "Sans",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PhieuDatSanGios_PhieuDatSanId",
                table: "PhieuDatSanGios",
                column: "PhieuDatSanId");

            migrationBuilder.CreateIndex(
                name: "IX_SanGios_GioId",
                table: "SanGios",
                column: "GioId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PhieuDatSanGios");

            migrationBuilder.DropTable(
                name: "SanGios");

            migrationBuilder.DropTable(
                name: "PhieuDatSans");

            migrationBuilder.DropTable(
                name: "Gios");

            migrationBuilder.DropTable(
                name: "Sans");
        }
    }
}
