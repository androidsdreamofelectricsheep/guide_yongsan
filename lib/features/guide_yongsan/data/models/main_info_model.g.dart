// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainInfoModel _$MainInfoModelFromJson(Map<String, dynamic> json) =>
    MainInfoModel(
      num: json['num'] as int,
      administrtvAreaId: json['administrtvAreaId'] as String,
      minorId: json['minorId'] as String,
      companyId: json['companyId'] as String,
      companyName: json['companyName'] as String?,
      addr: json['addr'] as String?,
      addrDetail: json['addrDetail'] as String?,
      keyWord: json['keyWord'] as String?,
      addrId: json['addrId'] as String,
      phone: json['phone'] as String?,
      zipCode: json['zipCode'] as String?,
      pointLng: json['pointLng'] as String,
      pointLat: json['pointLat'] as String,
    );

Map<String, dynamic> _$MainInfoModelToJson(MainInfoModel instance) =>
    <String, dynamic>{
      'num': instance.num,
      'administrtvAreaId': instance.administrtvAreaId,
      'minorId': instance.minorId,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'addr': instance.addr,
      'addrDetail': instance.addrDetail,
      'keyWord': instance.keyWord,
      'addrId': instance.addrId,
      'phone': instance.phone,
      'zipCode': instance.zipCode,
      'pointLng': instance.pointLng,
      'pointLat': instance.pointLat,
    };
