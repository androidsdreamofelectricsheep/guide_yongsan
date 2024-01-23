import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late GuideYongsanRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = GuideYongsanRemoteDataSourceImpl(httpClient: mockHttpClient);
    registerFallbackValue(Uri.http('google.it'));
  });

  group('getMajorCategory', () {
    final tFixture = fixture('major_category.json');
    final majorCategories = jsonDecode(tFixture)['items'];

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
