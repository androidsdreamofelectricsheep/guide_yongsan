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

// TODO: 유틸함수로 리팩토링 필요
class GuideYongsanLocalDataSourceImpl implements GuideYongsanLocalDataSource {
  final SharedPreferences sharedPreferences;

  GuideYongsanLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CompanyDetailInfoModel>> getCachedCompanyDetail(
      {required CompanyDetailInfoParams companyDetailInfoParams}) {
    final jsonString = sharedPreferences.getString(cachedCompanyDetail);

    if (jsonString == null) throw CacheException();

    final companyDetailInfos = json.decode(jsonString)['item'];

    List<CompanyDetailInfoModel> companyDetailInfoList = [];

    for (var companyDetailInfo in companyDetailInfos) {
      companyDetailInfoList
          .add(CompanyDetailInfoModel.fromJson(companyDetailInfo));
    }

    return Future.value(companyDetailInfoList);
  }

  @override
  Future<List<MainInfoModel>> getCachedMainInfo(
      {required MainInfoParams mainInfoParams}) {
    final jsonString = sharedPreferences.getString(cachedMainInfo);

    if (jsonString == null) throw CacheException();

    final mainInfos = json.decode(jsonString)['item'];

    List<MainInfoModel> mainInfoList = [];

    for (var mainInfo in mainInfos) {
      mainInfoList.add(MainInfoModel.fromJson(mainInfo));
    }

    return Future.value(mainInfoList);
  }

  @override
  Future<List<MajorCategoryModel>> getCachedMajorCategory() {
    final jsonString = sharedPreferences.getString(cachedMajorCategory);

    if (jsonString == null) throw CacheException();

    final majorCategories = json.decode(jsonString)['item'];

    List<MajorCategoryModel> majorCategoryList = [];

    for (var majorCategory in majorCategories) {
      majorCategoryList.add(MajorCategoryModel.fromJson(majorCategory));
    }

    return Future.value(majorCategoryList);
  }

  @override
  Future<List<MediumCategoryModel>> getCachedMediumCategory(
      {required MediumCategoryParams majorId}) {
    final jsonString = sharedPreferences.getString(cachedMediumCategory);

    if (jsonString == null) throw CacheException();

    final mediumCategories = json.decode(jsonString)['item'];

    List<MediumCategoryModel> mediumCategoryList = [];

    for (var majorCategory in mediumCategories) {
      mediumCategoryList.add(MediumCategoryModel.fromJson(majorCategory));
    }

    return Future.value(mediumCategoryList);
  }

  @override
  Future<void> cacheYongsanRemoteData(
      String yongsanRemoteData, String listNameForCaching) async {
    if (yongsanRemoteData.isNotEmpty && listNameForCaching.isNotEmpty) {
      sharedPreferences.setString(listNameForCaching, yongsanRemoteData);
    } else {
      throw CacheException();
    }
  }
}
