import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/company_detail_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/main_info_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/medium_category_model.dart';

abstract class GuideYongsanRemoteDataSource {
  Future<List<MajorCategoryModel>> getMajorCategory();

  Future<List<MediumCategoryModel>> getMediumCategory(
      {required MediumCategoryParams majorId});

  Future<List<MainInfoModel>> getMainInfo(
      {required MainInfoParams mainInfoParams});

  Future<List<CompanyDetailInfoModel>> getCompanyDetailInfo(
      {required CompanyDetailInfoParams companyDetailInfoParams});
}
