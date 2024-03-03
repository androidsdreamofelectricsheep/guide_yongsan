import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/core/errors/exceptions.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/company_detail_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/main_info_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/medium_category_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late GuideYongsanRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = GuideYongsanRemoteDataSourceImpl(httpClient: mockHttpClient);
    registerFallbackValue(Uri.http('google.it'));
  });

  group('getMajorCategory', () {
    final tFixture = fixture('major_category.json');
    final majorCategories = jsonDecode(tFixture)['item'];

    List<MajorCategoryModel> majorCategoryList = [];

    for (var majorCategory in majorCategories) {
      majorCategoryList.add(MajorCategoryModel.fromJson(majorCategory));
    }
    test('should return major category when status code is 200', () async {
      // arrange
      setupMockHttpSuccess200(mockHttpClient, tFixture);

      // act
      final result = await dataSource.getMajorCategory();

      // assert
      expect(result, majorCategoryList);
      // expect(result, isA<List<MajorCategoryModel>>());
    });

    test('should throw ServerException when status code is not 200', () async {
      // arrange
      setupoMockHttpError404(mockHttpClient);

      // act
      final call = dataSource.getMajorCategory;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('getMediumCategory', () {
    final tFixture = fixture('medium_category.json');
    final mediumCategories = jsonDecode(tFixture)['item'];
    const params = MediumCategoryParams(majorId: "02");

    List<MediumCategoryModel> mediumCategoryList = [];

    for (var mediumCategory in mediumCategories) {
      mediumCategoryList.add(MediumCategoryModel.fromJson(mediumCategory));
    }

    test('should return medium category when status code is 200', () async {
      // arrange
      setupMockHttpSuccess200(mockHttpClient, tFixture);

      // act
      final result = await dataSource.getMediumCategory(majorId: params);

      // assert
      // expect(result, mediumCategoryList);
      expect(result, isA<List<MediumCategoryModel>>());
    });

    test('should throw ServerException when status code is not 200', () async {
      // arrange
      setupoMockHttpError404(mockHttpClient);

      // act
      final call = dataSource.getMediumCategory;

      // assert
      expect(() => call(majorId: params), throwsA(isA<ServerException>()));
    });
  });

  group('getMainInfo', () {
    final tFixture = fixture('main_info.json');
    final mainInfos = jsonDecode(tFixture)['item'];
    var params = MainInfoParams(
        majorId: "02", mediumId: "01", minorId: "001", numOfRows: 1, pageNo: 1);

    List<MainInfoModel> mainInfoList = [];

    for (var mainInfo in mainInfos) {
      mainInfoList.add(MainInfoModel.fromJson(mainInfo));
    }

    test('should return main info when status code is 200', () async {
      // arrange
      setupMockHttpSuccess200(mockHttpClient, tFixture);

      // act
      final result = await dataSource.getMainInfo(mainInfoParams: params);

      // assert
      // expect(result, mainInfoList);
      expect(result, isA<List<MainInfoModel>>());
    });

    test('should throw ServerException when status code is not 200', () async {
      // arrange
      setupoMockHttpError404(mockHttpClient);

      // act
      final call = dataSource.getMainInfo;

      // assert
      expect(
          () => call(mainInfoParams: params), throwsA(isA<ServerException>()));
    });
  });

  group('getCompanyDetailInfo', () {
    final tFixture = fixture('company_detail_info.json');
    final companyDetailInfos = jsonDecode(tFixture)['item'];
    const params = CompanyDetailInfoParams(
        companyId: "2021ACC91DD931EA4652B20D997E8BF27DE7");

    List<CompanyDetailInfoModel> companyDetailInfoList = [];

    for (var companyDetailInfo in companyDetailInfos) {
      companyDetailInfoList
          .add(CompanyDetailInfoModel.fromJson(companyDetailInfo));
    }

    test('should return main info when status code is 200', () async {
      // arrange
      setupMockHttpSuccess200(mockHttpClient, tFixture);

      // act
      final result = await dataSource.getCompanyDetailInfo(
          companyDetailInfoParams: params);

      // assert
      // expect(result, companyDetailInfoList);
      expect(result, isA<List<CompanyDetailInfoModel>>());
    });

    test('should throw ServerException when status code is not 200', () async {
      // arrange
      setupoMockHttpError404(mockHttpClient);

      // act
      final call = dataSource.getCompanyDetailInfo;

      // assert
      expect(() => call(companyDetailInfoParams: params),
          throwsA(isA<ServerException>()));
    });
  });
}

void setupoMockHttpError404(MockHttpClient mockHttpClient) {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
  };
  when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
      .thenAnswer((_) async => http.Response('Error!', 404, headers: headers));
}

void setupMockHttpSuccess200(MockHttpClient mockHttpClient, String tFixture) {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
  };
  when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
      .thenAnswer((_) async => http.Response(tFixture, 200, headers: headers));
}
