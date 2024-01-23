import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/medium_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/repositories/guide_yongsan_repository.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/usecases/get_medium_category.dart';
import 'package:mocktail/mocktail.dart';

class MockGetMediumCategoryRepository extends Mock
    implements GuideYongsanRepository {}

void main() {
  late GetMediumCategory usecase;
  late MockGetMediumCategoryRepository repository;
  late MediumCategoryParams params;

  setUp(() {
    repository = MockGetMediumCategoryRepository();
    usecase = GetMediumCategory(repository);
    params = const MediumCategoryParams(majorId: "01");
  });

  const mediumCategoryList = [
    MediumCategoryEntity(mediumId: "01", mediumName: "식당"),
    MediumCategoryEntity(mediumId: "02", mediumName: "유흥주점"),
  ];

  test('should get medium category', () async {
    // arrange
    when(() => repository.getMediumCategory(params: params))
        .thenAnswer((_) async => const Right(mediumCategoryList));

    // act
    final result = await (usecase(params: params));

    // assert
    expect(result, const Right(mediumCategoryList));
    verify(() => repository.getMediumCategory(params: params));
    verifyNoMoreInteractions(repository);
  });
}
