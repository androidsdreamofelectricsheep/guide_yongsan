import 'package:guide_yongsan/features/guide_yongsan/domain/entities/company_detail_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part "company_detail_model.g.dart";

@JsonSerializable()
class CompanyDetailInfoModel extends CompanyDetailInfoEntity {
  const CompanyDetailInfoModel(
      {required super.companyItemId,
      required super.companyItem,
      required super.companyInfo});

  factory CompanyDetailInfoModel.fromJson(Map<String, dynamic> json) {
    return _$CompanyDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CompanyDetailModelToJson(this);
  }
}
