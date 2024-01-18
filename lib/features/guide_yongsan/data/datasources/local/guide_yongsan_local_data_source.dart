import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/company_detail_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/main_info_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/medium_category_model.dart';

abstract class GuideYongsanLocalDataSource {
  Future<List<MajorCategoryModel>> getCachedMajorCategory();

  Future<List<MediumCategoryModel>> getCachedMediumCategory(
      {required MediumCategoryParams majorId});

  Future<List<MainInfoModel>> getCachedMainInfo(
      {required MainInfoParams mainInfoParams});

  Future<List<CompanyDetailInfoModel>> getCachedCompanyDetail(
      {required CompanyDetailInfoParams companyDetailInfoParams});

  Future<void> cacheYongsanRemoteData(
      {required List<String> yongsanRemoteData,
      required String listNameForCaching});
}
