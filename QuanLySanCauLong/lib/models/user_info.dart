class UserInfo {
  final String email;
  final String sdt;
  final String gioiTinh;
  final String hoTen;

  UserInfo({
    required this.email,
    required this.sdt,
    required this.gioiTinh,
    required this.hoTen,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      email: json['email'],
      sdt: json['sdt'],
      gioiTinh: json['gioiTinh'],
      hoTen : json['hoTen']
    );
  }
}