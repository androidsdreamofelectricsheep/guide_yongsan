import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/core/errors/exceptions.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/network/network_info.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/company_detail_info_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/main_info_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/medium_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/repositories/guide_yongsan_repository.dart';

// TODO: 유틸함수로 리팩토링 필요
class GuideYongsanRepositoryImpl implements GuideYongsanRepository {
  final GuideYongsanRemoteDataSource remoteDataSource;
  final GuideYongsanLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GuideYongsanRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<CompanyDetailInfoEntity>>> getCompanyDetailInfo(
      {required CompanyDetailInfoParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCompanyDetailInfo = await remoteDataSource
            .getCompanyDetailInfo(companyDetailInfoParams: params);

        localDataSource.cacheYongsanRemoteData(
            jsonEncode(remoteCompanyDetailInfo), cachedCompanyDetail);

        return Right(remoteCompanyDetailInfo);
      } on ServerException {
        return const Left(ServerFailure(errorMsg: serverFailureMsg));
      }
    } else {
      try {
        final localCompanyDetailInfo = await localDataSource
            .getCachedCompanyDetailInfo(companyDetailInfoParams: params);
        return Right(localCompanyDetailInfo);
      } on CacheException {
        return const Left(CacheFailure(errorMsg: cacheFailureMsg));
      }
    }
  }

  @override
  Future<Either<Failure, List<MainInfoEntity>>> getMainInfo(
      {required MainInfoParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMainInfo =
            await remoteDataSource.getMainInfo(mainInfoParams: params);

        localDataSource.cacheYongsanRemoteData(
            jsonEncode(remoteMainInfo), cachedMainInfo);

        return Right(remoteMainInfo);
      } on ServerException {
        return const Left(ServerFailure(errorMsg: serverFailureMsg));
      }
    } else {
      try {
        final localMainInfo =
            await localDataSource.getCachedMainInfo(mainInfoParams: params);
        return Right(localMainInfo);
      } on CacheException {
        return const Left(CacheFailure(errorMsg: cacheFailureMsg));
      }
    }
  }

  @override
  Future<Either<Failure, List<MarjorCategoryEntity>>> getMajorCategory() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMajorCategory = await remoteDataSource.getMajorCategory();

        await localDataSource.cacheYongsanRemoteData(
            jsonEncode(remoteMajorCategory), cachedMajorCategory);

        return Right(remoteMajorCategory);
      } on ServerException {
        return const Left(ServerFailure(errorMsg: serverFailureMsg));
      }
    } else {
      try {
        final localMajorCategory =
            await localDataSource.getCachedMajorCategory();
        return Right(localMajorCategory);
      } on CacheException {
        return const Left(CacheFailure(errorMsg: cacheFailureMsg));
      }
    }
  }

  @override
  Future<Either<Failure, List<MediumCategoryEntity>>> getMediumCategory(
      {required MediumCategoryParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMediumCategory =
            await remoteDataSource.getMediumCategory(majorId: params);

        localDataSource.cacheYongsanRemoteData(
            jsonEncode(remoteMediumCategory), cachedMediumCategory);

        return Right(remoteMediumCategory);
      } on ServerException {
        return const Left(ServerFailure(errorMsg: serverFailureMsg));
      }
    } else {
      try {
        final localMediumCategory =
            await localDataSource.getCachedMediumCategory(majorId: params);
        return Right(localMediumCategory);
      } on CacheException {
        return const Left(CacheFailure(errorMsg: cacheFailureMsg));
      }
    }
  }
}
