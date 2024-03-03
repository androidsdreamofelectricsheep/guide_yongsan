import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/main_info_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/repositories/guide_yongsan_repository.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/usecases/get_main_info.dart';
import 'package:mocktail/mocktail.dart';

class MockGetMainInfoRepository extends Mock
    implements GuideYongsanRepository {}

void main() {
  late GetMainInfo usecase;
  late MockGetMainInfoRepository repository;
  late MainInfoParams params;

  setUp(() {
    repository = MockGetMainInfoRepository();
    usecase = GetMainInfo(repository);
    params = MainInfoParams(
        majorId: "02", mediumId: "01", minorId: "001", numOfRows: 1, pageNo: 1);
  });

  const mainInfoList = [
    MainInfoEntity(
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

  test('should get main info', () async {
    // arrange
    when(() => repository.getMainInfo(params: params))
        .thenAnswer((_) async => const Right(mainInfoList));

    // act
    final result = await (usecase(params: params));

    // assert
    expect(result, const Right(mainInfoList));
    verify(() => repository.getMainInfo(params: params));
    verifyNoMoreInteractions(repository);
  });
}
