import 'package:guide_yongsan/features/guide_yongsan/domain/entities/main_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part "main_info_model.g.dart";

@JsonSerializable()
class MainInfoModel extends MainInfoEntity {
  const MainInfoModel(
      {required super.num,
      required super.administrtvAreaId,
      required super.minorId,
      required super.companyId,
      super.companyName,
      super.addr,
      super.addrDetail,
      super.keyWord,
      required super.addrId,
      super.phone,
      super.zipCode,
      required super.pointLng,
      required super.pointLat});

  factory MainInfoModel.fromJson(Map<String, dynamic> json) {
    return _$MainInfoModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MainInfoModelToJson(this);
  }
}
