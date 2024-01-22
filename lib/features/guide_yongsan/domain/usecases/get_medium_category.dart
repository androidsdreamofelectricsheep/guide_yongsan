import 'package:dartz/dartz.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/medium_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/repositories/guide_yongsan_repository.dart';

class GetMediumCategory {
  final GuideYongsanRepository repository;

  GetMediumCategory(this.repository);

  Future<Either<Failure, List<MediumCategoryEntity>>> call(
      {required MediumCategoryParams params}) async {
    return await repository.getMediumCategory(params: params);
  }
}
