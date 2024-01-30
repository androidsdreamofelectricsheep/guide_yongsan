import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/core/errors/exceptions.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/network/network_info.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/company_detail_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/main_info_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/medium_category_model.dart';
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

  group('getMediumCategory', () {
    const tMediumCategoryModel = [
      MediumCategoryModel(mediumId: "01", mediumName: "식당")
    ];

    const params = MediumCategoryParams(majorId: "02");

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getMediumCategory(majorId: params))
          .thenAnswer((_) async => tMediumCategoryModel);
      // act
      repository.getMediumCategory(params: params);
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the remote data call is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getMediumCategory(majorId: params))
            .thenAnswer((_) async => tMediumCategoryModel);
        // act
        var result = await repository.getMediumCategory(params: params);
        // assert
        verify(() => mockRemoteDataSource.getMediumCategory(majorId: params));
        expect(result, const Right(tMediumCategoryModel));
      });

      test('should cache data locally when the remote data call is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getMediumCategory(majorId: params))
            .thenAnswer((_) async => tMediumCategoryModel);
        // act
        await repository.getMediumCategory(params: params);
        // assert
        verify(() => mockLocalDataSource.cacheYongsanRemoteData(
            jsonEncode(tMediumCategoryModel), cachedMediumCategory));
      });
    });

    runTestsOffline(() {
      test('should return cached data before it was successfully cached',
          () async {
        // arrange
        when(() => mockLocalDataSource.getCachedMediumCategory(majorId: params))
            .thenAnswer((_) async => tMediumCategoryModel);
        // act
        var result = await repository.getMediumCategory(params: params);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(
            () => mockLocalDataSource.getCachedMediumCategory(majorId: params));
        expect(result, const Right(tMediumCategoryModel));
      });

      test('should return CacheFailure when no local data is present',
          () async {
        // arrange
        when(() => mockLocalDataSource.getCachedMediumCategory(majorId: params))
            .thenThrow(CacheException());
        // act
        final result = await repository.getMediumCategory(params: params);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(
            () => mockLocalDataSource.getCachedMediumCategory(majorId: params));
        expect(result, const Left(CacheFailure(errorMsg: cacheFailureMsg)));
      });
    });
  });

  group('getMainInfo', () {
    const tMainInfoModel = [
      MainInfoModel(
          num: 1,
          administrtvAreaId: "3020000",
          minorId: "001",
          companyId: "2021579B12EBDF274E28ABB7622046FAF476",
          companyName: "237페이지(237page)",
          addr: "서울특별시 용산구 회나무로 13",
          addrDetail: "1층",
          keyWord: "#식당 #음식점 #한식 #육류 #고기요리 #화로구이 #파스타 #단체석",
          addrId: "1117013000",
          phone: null,
          zipCode: "04343",
          pointLng: "126.98827525591582",
          pointLat: "37.53881113761811")
    ];

    const params = MainInfoParams(
        majorId: "02", mediumId: "01", minorId: "001", numOfRows: 1, pageNo: 1);

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getMainInfo(mainInfoParams: params))
          .thenAnswer((_) async => tMainInfoModel);
      // act
      repository.getMainInfo(params: params);
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the remote data call is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getMainInfo(mainInfoParams: params))
            .thenAnswer((_) async => tMainInfoModel);
        // act
        var result = await repository.getMainInfo(params: params);
        // assert
        verify(() => mockRemoteDataSource.getMainInfo(mainInfoParams: params));
        expect(result, const Right(tMainInfoModel));
      });

      test('should cache data locally when the remote data call is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getMainInfo(mainInfoParams: params))
            .thenAnswer((_) async => tMainInfoModel);
        // act
        await repository.getMainInfo(params: params);
        // assert
        verify(() => mockLocalDataSource.cacheYongsanRemoteData(
            jsonEncode(tMainInfoModel), cachedMainInfo));
      });
    });

    runTestsOffline(() {
      test('should return cached data before it was successfully cached',
          () async {
        // arrange
        when(() =>
                mockLocalDataSource.getCachedMainInfo(mainInfoParams: params))
            .thenAnswer((_) async => tMainInfoModel);
        // act
        var result = await repository.getMainInfo(params: params);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() =>
            mockLocalDataSource.getCachedMainInfo(mainInfoParams: params));
        expect(result, const Right(tMainInfoModel));
      });

      test('should return CacheFailure when no local data is present',
          () async {
        // arrange
        when(() =>
                mockLocalDataSource.getCachedMainInfo(mainInfoParams: params))
            .thenThrow(CacheException());
        // act
        final result = await repository.getMainInfo(params: params);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() =>
            mockLocalDataSource.getCachedMainInfo(mainInfoParams: params));
        expect(result, const Left(CacheFailure(errorMsg: cacheFailureMsg)));
      });
    });
  });

  group('getCompanyDetailInfo', () {
    const tCompanyDetailInfoModel = [
      CompanyDetailInfoModel(
          companyItemId: 1,
          companyItem: "Operating Time",
          companyInfo: "Weekday 09:00~18:00")
    ];

    const params = CompanyDetailInfoParams(
        companyId: "2021ACC91DD931EA4652B20D997E8BF27DE7");

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getCompanyDetailInfo(
              companyDetailInfoParams: params))
          .thenAnswer((_) async => tCompanyDetailInfoModel);
      // act
      repository.getCompanyDetailInfo(params: params);
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the remote data call is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getCompanyDetailInfo(
                companyDetailInfoParams: params))
            .thenAnswer((_) async => tCompanyDetailInfoModel);
        // act
        var result = await repository.getCompanyDetailInfo(params: params);
        // assert
        verify(() => mockRemoteDataSource.getCompanyDetailInfo(
            companyDetailInfoParams: params));
        expect(result, const Right(tCompanyDetailInfoModel));
      });

      test('should cache data locally when the remote data call is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getCompanyDetailInfo(
                companyDetailInfoParams: params))
            .thenAnswer((_) async => tCompanyDetailInfoModel);
        // act
        await repository.getCompanyDetailInfo(params: params);
        // assert
        verify(() => mockLocalDataSource.cacheYongsanRemoteData(
            jsonEncode(tCompanyDetailInfoModel), cachedCompanyDetail));
      });
    });

    runTestsOffline(() {
      test('should return cached data before it was successfully cached',
          () async {
        // arrange
        when(() => mockLocalDataSource.getCachedCompanyDetailInfo(
                companyDetailInfoParams: params))
            .thenAnswer((_) async => tCompanyDetailInfoModel);
        // act
        var result = await repository.getCompanyDetailInfo(params: params);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCachedCompanyDetailInfo(
            companyDetailInfoParams: params));
        expect(result, const Right(tCompanyDetailInfoModel));
      });

      test('should return CacheFailure when no local data is present',
          () async {
        // arrange
        when(() => mockLocalDataSource.getCachedCompanyDetailInfo(
            companyDetailInfoParams: params)).thenThrow(CacheException());
        // act
        final result = await repository.getCompanyDetailInfo(params: params);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCachedCompanyDetailInfo(
            companyDetailInfoParams: params));
        expect(result, const Left(CacheFailure(errorMsg: cacheFailureMsg)));
      });
    });
  });
}
