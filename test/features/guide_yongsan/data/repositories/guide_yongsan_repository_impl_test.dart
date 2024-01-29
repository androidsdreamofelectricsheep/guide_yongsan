import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/core/errors/exceptions.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/network/network_info.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/repositories/guide_yongsan_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock
    implements GuideYongsanRemoteDataSource {}

class MockLocalDataSource extends Mock implements GuideYongsanLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late GuideYongsanRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GuideYongsanRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);

    when(() => mockLocalDataSource.cacheYongsanRemoteData(any(), any()))
        .thenAnswer((_) => Future.value());
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getMajorCategory', () {
    const tMajorCategoryModel = [
      MajorCategoryModel(majorId: "01", majorName: "공공")
    ];

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getMajorCategory())
          .thenAnswer((_) async => tMajorCategoryModel);
      // act
      repository.getMajorCategory();
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the remote data call is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getMajorCategory())
            .thenAnswer((_) async => tMajorCategoryModel);
        // act
        var result = await repository.getMajorCategory();
        // assert
        verify(() => mockRemoteDataSource.getMajorCategory());
        expect(result, const Right(tMajorCategoryModel));
      });

      test('should cache data locally when the remote data call is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getMajorCategory())
            .thenAnswer((_) async => tMajorCategoryModel);
        // act
        await repository.getMajorCategory();
        // assert
        verify(() => mockLocalDataSource.cacheYongsanRemoteData(
            jsonEncode(tMajorCategoryModel), cachedMajorCategory));
      });
    });

    runTestsOffline(() {
      test('should return cached data before it was successfully cached',
          () async {
        // arrange
        when(() => mockLocalDataSource.getCachedMajorCategory())
            .thenAnswer((_) async => tMajorCategoryModel);
        // act
        var result = await repository.getMajorCategory();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCachedMajorCategory());
        expect(result, const Right(tMajorCategoryModel));
      });

      test('should return CacheFailure when no local data is present',
          () async {
        // arrange
        when(() => mockLocalDataSource.getCachedMajorCategory())
            .thenThrow(CacheException());
        // act
        final result = await repository.getMajorCategory();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCachedMajorCategory());
        expect(result, const Left(CacheFailure(errorMsg: cacheFailureMsg)));
      });
    });
  });
}
