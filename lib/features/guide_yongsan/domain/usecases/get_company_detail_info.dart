import 'package:dartz/dartz.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/company_detail_info_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/repositories/guide_yongsan_repository.dart';

class GetCompanyDetailInfo {
  final GuideYongsanRepository repository;

  GetCompanyDetailInfo(this.repository);

  Future<Either<Failure, List<CompanyDetailInfoEntity>>> call(
      {required CompanyDetailInfoParams params}) async {
    return await repository.getCompanyDetailInfo(params: params);
  }
}
