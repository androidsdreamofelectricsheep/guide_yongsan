import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/medium_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/medium_category_entity.dart';

void main() {
  const tMediumCategoryModel =
      MediumCategoryModel(mediumId: "01", mediumName: "식당");

  test('should be a subclass of entity', () async {
    expect(tMediumCategoryModel, isA<MediumCategoryEntity>());
  });

  group('toJson', () {
    test('should return a json map with proper data', () async {
      // act
      final result = tMediumCategoryModel.toJson();

      // assert
      final expectedJsonMap = {"mediumId": "01", "mediumName": "식당"};
      expect(result, expectedJsonMap);
    });
  });
}
