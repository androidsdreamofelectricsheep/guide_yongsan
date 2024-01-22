import 'package:dartz/dartz.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/company_detail_info_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/main_info_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/medium_category_entity.dart';

abstract class GuideYongsanRepository {
  // 대분류 카테고리
  Future<Either<Failure, List<MarjorCategoryEntity>>> getMajorCategory();
  // 중분류 카테고리
  Future<Either<Failure, List<MediumCategoryEntity>>> getMediumCategory(
      {required MediumCategoryParams params});
  // 편의시설/업체 정보
  Future<Either<Failure, List<MainInfoEntity>>> getMainInfo(
      {required MainInfoParams params});
  // 시설/업체 세부정보
  Future<Either<Failure, List<CompanyDetailInfoEntity>>> getCompanyDetailInfo(
      {required CompanyDetailInfoParams params});
}
