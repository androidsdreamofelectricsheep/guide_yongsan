import 'package:guide_yongsan/features/guide_yongsan/domain/entities/main_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part "main_info_model.g.dart";

@JsonSerializable()
class MainInfoModel extends MainInfoEntity {
  MainInfoModel(
      {required super.num,
      required super.administrtvAreaId,
      required super.minorId,
      required super.companyId,
      required super.companyName,
      required super.addr,
      required super.addrDetail,
      required super.keyWord,
      required super.addrId,
      required super.phone,
      required super.zipCode,
      required super.pointLng,
      required super.pointLat});

  factory MainInfoModel.fromJson(Map<String, dynamic> json) {
    return _$MainInfoModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MainInfoModelToJson(this);
  }
}
