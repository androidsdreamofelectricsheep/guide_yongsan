import 'package:equatable/equatable.dart';

class MainInfoEntity extends Equatable {
  final int num;
  final String administrtvAreaId;
  final String minorId;
  final String companyId;
  final String? companyName;
  final String? addr;
  final String? addrDetail;
  final String? keyWord;
  final String addrId;
  final String? phone;
  final String? zipCode;
  final String pointLng;
  final String pointLat;

  const MainInfoEntity(
      {required this.num,
      required this.administrtvAreaId,
      required this.minorId,
      required this.companyId,
      required this.companyName,
      this.addr,
      this.addrDetail,
      this.keyWord,
      required this.addrId,
      this.phone,
      this.zipCode,
      required this.pointLng,
      required this.pointLat});

  @override
  List<Object?> get props => [
        num,
        administrtvAreaId,
        minorId,
        companyId,
        companyName,
        addr,
        addrDetail,
        keyWord,
        addrId,
        phone,
        zipCode,
        pointLng,
        pointLat
      ];
}
