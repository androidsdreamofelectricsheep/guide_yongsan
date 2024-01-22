import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/repositories/guide_yongsan_repository.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/usecases/get_major_category.dart';
import 'package:mocktail/mocktail.dart';

class MockGetMajorCategoryRepository extends Mock
    implements GuideYongsanRepository {}

void main() {
  late GetMajorCategory usecase;
  late MockGetMajorCategoryRepository repository;

  setUp(() {
    repository = MockGetMajorCategoryRepository();
    usecase = GetMajorCategory(repository);
  });

  const majorCategoryList = [
    MarjorCategoryEntity(majorId: "01", majorName: "공공"),
    MarjorCategoryEntity(majorId: "02", majorName: "음식")
  ];

  test('should get major category', () async {
    when(() => repository.getMajorCategory())
        .thenAnswer((_) async => const Right(majorCategoryList));

    // act
    final result = await (usecase());

    // assert
    expect(result, const Right(majorCategoryList));
    verify(() => repository.getMajorCategory());
    verifyNoMoreInteractions(repository);
  });
}
