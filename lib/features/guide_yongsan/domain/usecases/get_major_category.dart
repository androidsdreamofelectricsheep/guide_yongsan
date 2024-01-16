import 'package:dartz/dartz.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/repositories/guide_yongsan_repository.dart';

class GetMajorCategory {
  final GuideYongsanRepository repository;

  GetMajorCategory(this.repository);

  Future<Either<Failure, MarjorCategoryEntity>> call(
      {required BaseParams params}) async {
    return await repository.getMajorCategory(params: params);
  }
}
