class SanGioResponseDto {
  final int sanId;
  final String tenSan;
  final List<GioStatusDto> gios;

  SanGioResponseDto({required this.sanId, required this.tenSan, required this.gios});

  factory SanGioResponseDto.fromJson(Map<String, dynamic> json) {
    return SanGioResponseDto(
      sanId: json['SanId'],
      tenSan: json['TenSan'],
      gios: (json['Gios'] as List).map((e) => GioStatusDto.fromJson(e)).toList(),
    );
  }
}

class GioStatusDto {
  final int gioId;
  final String gio;
  final double donGia;
  final bool isBooked;

  GioStatusDto({required this.gioId, required this.gio, required this.donGia, required this.isBooked});

  factory GioStatusDto.fromJson(Map<String, dynamic> json) {
    return GioStatusDto(
      gioId: json['GioId'],
      gio: json['Gio'],
      donGia: json['DonGia'],
      isBooked: json['IsBooked'],
    );
  }
}
