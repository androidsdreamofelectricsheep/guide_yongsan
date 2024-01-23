class MainInfoEntity {
  final int num;
  final String administrtvAreaId;
  final String minorId;
  final String companyId;
  final String companyName;
  final String addr;
  final String? addrDetail;
  final String? keyWord;
  final String? addrId;
  final String? phone;
  final String zipCode;
  final String pointLng;
  final String pointLat;

  const MainInfoEntity(
      {required this.num,
      required this.administrtvAreaId,
      required this.minorId,
      required this.companyId,
      required this.companyName,
      required this.addr,
      required this.addrDetail,
      required this.keyWord,
      required this.addrId,
      required this.phone,
      required this.zipCode,
      required this.pointLng,
      required this.pointLat});
}
