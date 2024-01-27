import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/core/errors/exceptions.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/company_detail_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/main_info_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/medium_category_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late GuideYongsanLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = GuideYongsanLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getMajorCategory', () {
    final cachedMajorCategoryFixture = fixture('major_category.json');
    final cachedMajorCategoryJson =
        jsonDecode(cachedMajorCategoryFixture)['item'];

    List<MajorCategoryModel> majorCategoryList = [];

    for (var majorCategory in cachedMajorCategoryJson) {
      majorCategoryList.add(MajorCategoryModel.fromJson(majorCategory));
    }

    test('should return cached MajorCategory', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(cachedMajorCategoryFixture);
      // act
      final result = await dataSource.getCachedMajorCategory();
      // assert
      verify(() => mockSharedPreferences.getString(cachedMajorCategory));
      expect(result, majorCategoryList);
    });

    test('should throw CacheException when nothing cached', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      // act
      final call = dataSource.getCachedMajorCategory;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
      verify(() => mockSharedPreferences.getString(cachedMajorCategory));
    });
  });

  group('getMediumCategory', () {
    final cachedMediumCategoryFixture = fixture('medium_category.json');
    final cachedMediumCategoryJson =
        jsonDecode(cachedMediumCategoryFixture)['item'];

    const params = MediumCategoryParams(majorId: "02");

    List<MediumCategoryModel> mediumCategoryList = [];

    for (var mediumCategory in cachedMediumCategoryJson) {
      mediumCategoryList.add(MediumCategoryModel.fromJson(mediumCategory));
    }

    test('should return cached MediumCategory', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(cachedMediumCategoryFixture);
      // act
      final result = await dataSource.getCachedMediumCategory(majorId: params);
      // assert
      expect(result, mediumCategoryList);
    });

    test('should throw CacheException when nothing cached', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      // act
      final call = dataSource.getCachedMediumCategory;
      // assert
      expect(() => call(majorId: params), throwsA(isA<CacheException>()));
      verify(() => mockSharedPreferences.getString(cachedMediumCategory));
    });
  });

  group('getMainInfo', () {
    final cachedMainInfoFixture = fixture('main_info.json');
    final cachedMainInfoJson = jsonDecode(cachedMainInfoFixture)['item'];

    const params = MainInfoParams(
        majorId: "02", mediumId: "01", minorId: "001", numOfRows: 1, pageNo: 1);

    List<MainInfoModel> mainInfoList = [];

    for (var mainInfo in cachedMainInfoJson) {
      mainInfoList.add(MainInfoModel.fromJson(mainInfo));
    }

    test('should return cached MainInfo', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(cachedMainInfoFixture);
      // act
      final result = await dataSource.getCachedMainInfo(mainInfoParams: params);
      // assert
      expect(result, mainInfoList);
    });

    test('should throw CacheException when nothing cached', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      // act
      final call = dataSource.getCachedMainInfo;
      // assert
      expect(
          () => call(mainInfoParams: params), throwsA(isA<CacheException>()));
      verify(() => mockSharedPreferences.getString(cachedMainInfo));
    });
  });

  group('getCompanyDetailInfo', () {
    final cachedCompanyDetailInfoFixture = fixture('company_detail_info.json');
    final cachedCompanyDetailInfoJson =
        jsonDecode(cachedCompanyDetailInfoFixture)['item'];

    const params = CompanyDetailInfoParams(
        companyId: "2021ACC91DD931EA4652B20D997E8BF27DE7");

    List<CompanyDetailInfoModel> companyDetailInfoList = [];

    for (var companyDetailInfo in cachedCompanyDetailInfoJson) {
      companyDetailInfoList
          .add(CompanyDetailInfoModel.fromJson(companyDetailInfo));
    }

    test('should return cached MainInfo', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(cachedCompanyDetailInfoFixture);
      // act
      final result = await dataSource.getCachedCompanyDetail(
          companyDetailInfoParams: params);
      // assert
      expect(result, companyDetailInfoList);
    });

    test('should throw CacheException when nothing cached', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      // act
      final call = dataSource.getCachedCompanyDetail;
      // assert
      expect(() => call(companyDetailInfoParams: params),
          throwsA(isA<CacheException>()));
      verify(() => mockSharedPreferences.getString(cachedCompanyDetail));
    });
  });
}
