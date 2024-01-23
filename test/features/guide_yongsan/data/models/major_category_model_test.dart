import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';

void main() {
  const tMajorCategoryModel =
      MajorCategoryModel(majorId: "01", majorName: "공공");

  test('should be a subclass of entity', () async {
    expect(tMajorCategoryModel, isA<MarjorCategoryEntity>());
  });

  group('toJson', () {
    test('should return a json map with proper data', () async {
      // act
      final result = tMajorCategoryModel.toJson();

      // assert
      final expectedJsonMap = {
        "majorId": "01",
        "majorName": "공공",
      };
      expect(result, expectedJsonMap);
    });
  });
}
