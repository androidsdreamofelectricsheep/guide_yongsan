import 'package:dartz/dartz.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/main_info_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/repositories/guide_yongsan_repository.dart';

class GetMainInfo {
  final GuideYongsanRepository repository;

  GetMainInfo(this.repository);

  Future<Either<Failure, List<MainInfoEntity>>> call(
      {required MainInfoParams params}) async {
    return await repository.getMainInfo(params: params);
  }
}
