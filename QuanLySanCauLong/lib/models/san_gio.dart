class SanGio {
  final int sanId;
  final String tenSan;
  final List<GioStatus> gios;

  SanGio({required this.sanId, required this.tenSan, required this.gios});

  factory SanGio.fromJson(Map<String, dynamic> json) {
    return SanGio(
      sanId: json['SanId'],
      tenSan: json['TenSan'],
      gios: (json['Gios'] as List).map((e) => GioStatus.fromJson(e)).toList(),
    );
  }
}

class GioStatus {
  final int gioId;
  final String gio;
  final double donGia;
  final bool isBooked;

  GioStatus({required this.gioId, required this.gio, required this.donGia, required this.isBooked});

  factory GioStatus.fromJson(Map<String, dynamic> json) {
    return GioStatus(
      gioId: json['GioId'],
      gio: json['Gio'],
      donGia: json['DonGia'],
      isBooked: json['IsBooked'],
    );
  }
}
