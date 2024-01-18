import 'dart:convert';

import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/core/errors/exceptions.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/company_detail_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/main_info_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/medium_category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuideYongsanLocalDataSourceImpl implements GuideYongsanLocalDataSource {
  final SharedPreferences sharedPreferences;

  GuideYongsanLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CompanyDetailInfoModel>> getCachedCompanyDetail(
      {required CompanyDetailInfoParams companyDetailInfoParams}) {
    final jsonString = sharedPreferences.getStringList(cachedCompanyDetail);

    return Future.value(jsonString
        ?.map((m) => CompanyDetailInfoModel.fromJson(json.decode(m)))
        .toList());
  }

  @override
  Future<List<MainInfoModel>> getCachedMainInfo(
      {required MainInfoParams mainInfoParams}) {
    final jsonString = sharedPreferences.getStringList(cachedMainInfo);

    return Future.value(jsonString
        ?.map((m) => MainInfoModel.fromJson(json.decode(m)))
        .toList());
  }

  @override
  Future<List<MajorCategoryModel>> getCachedMajorCategory() {
    final jsonString = sharedPreferences.getStringList(cachedMajorCategory);

    return Future.value(jsonString
        ?.map((m) => MajorCategoryModel.fromJson(json.decode(m)))
        .toList());
  }

  @override
  Future<List<MediumCategoryModel>> getCachedMediumCategory(
      {required MediumCategoryParams majorId}) {
    final jsonString = sharedPreferences.getStringList(cachedMediumCategory);

    return Future.value(jsonString
        ?.map((m) => MediumCategoryModel.fromJson(json.decode(m)))
        .toList());
  }

  // TODO: yongsanRemoteData 반드시 toJson으로 이루어진 문자열 배열이 파라미터로 들어와야 함
  @override
  Future<void> cacheYongsanRemoteData(
      {required List<String> yongsanRemoteData,
      required String listNameForCaching}) async {
    if (yongsanRemoteData.isNotEmpty && listNameForCaching.isNotEmpty) {
      sharedPreferences.setStringList(listNameForCaching, yongsanRemoteData);
    } else {
      throw CacheException();
    }
  }
}
