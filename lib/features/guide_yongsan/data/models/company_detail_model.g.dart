// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDetailModel _$CompanyDetailModelFromJson(Map<String, dynamic> json) =>
    CompanyDetailModel(
      companyItemId: json['companyItemId'] as int,
      companyItem: json['companyItem'] as String,
      companyInfo: json['companyInfo'] as String,
    );

Map<String, dynamic> _$CompanyDetailModelToJson(CompanyDetailModel instance) =>
    <String, dynamic>{
      'companyItemId': instance.companyItemId,
      'companyItem': instance.companyItem,
      'companyInfo': instance.companyInfo,
    };
