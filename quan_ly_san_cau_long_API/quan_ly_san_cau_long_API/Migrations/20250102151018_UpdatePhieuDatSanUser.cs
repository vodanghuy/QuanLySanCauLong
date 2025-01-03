using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace quan_ly_san_cau_long_API.Migrations
{
    /// <inheritdoc />
    public partial class UpdatePhieuDatSanUser : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "TongTien",
                table: "PhieuDatSans",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<int>(
                name: "UserId",
                table: "PhieuDatSans",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_PhieuDatSans_UserId",
                table: "PhieuDatSans",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_PhieuDatSans_Users_UserId",
                table: "PhieuDatSans",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PhieuDatSans_Users_UserId",
                table: "PhieuDatSans");

            migrationBuilder.DropIndex(
                name: "IX_PhieuDatSans_UserId",
                table: "PhieuDatSans");

            migrationBuilder.DropColumn(
                name: "TongTien",
                table: "PhieuDatSans");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "PhieuDatSans");
        }
    }
}
