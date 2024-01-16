import 'package:guide_yongsan/features/guide_yongsan/domain/entities/company_detail_info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part "company_detail_model.g.dart";

@JsonSerializable()
class CompanyDetailModel extends CompanyDetailInfoEntity {
  CompanyDetailModel(
      {required super.companyItemId,
      required super.companyItem,
      required super.companyInfo});

  factory CompanyDetailModel.fromJson(Map<String, dynamic> json) {
    return _$CompanyDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CompanyDetailModelToJson(this);
  }
}
