class PhieuDatSanDto {
  final int userId;
  final List<SanGioNgayDto> sanGioNgay;

  PhieuDatSanDto({required this.userId, required this.sanGioNgay});

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'SanGioNgay': sanGioNgay.map((e) => e.toJson()).toList(),
    };
  }
}

class SanGioNgayDto {
  final int sanId;
  final int gioId;
  final DateTime ngayDat;

  SanGioNgayDto({required this.sanId, required this.gioId, required this.ngayDat});

  Map<String, dynamic> toJson() {
    return {
      'SanId': sanId,
      'GioId': gioId,
      'NgayDat': ngayDat.toIso8601String(),
    };
  }
}
