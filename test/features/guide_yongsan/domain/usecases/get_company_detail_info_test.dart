import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/company_detail_info_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/repositories/guide_yongsan_repository.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/usecases/get_company_detail_info.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCompanyDetailInfoRepository extends Mock
    implements GuideYongsanRepository {}

void main() {
  late GetCompanyDetailInfo usecase;
  late MockGetCompanyDetailInfoRepository repository;
  late CompanyDetailInfoParams params;

  setUp(() {
    repository = MockGetCompanyDetailInfoRepository();
    usecase = GetCompanyDetailInfo(repository);
    params = CompanyDetailInfoParams(
        companyId: "2021ACC91DD931EA4652B20D997E8BF27DE7");
  });

  const companyDetailInfoList = [
    CompanyDetailInfoEntity(
        companyItemId: 1,
        companyItem: "Operating Time",
        companyInfo: "Weekday 09:00~18:00"),
    CompanyDetailInfoEntity(
        companyItemId: 1,
        companyItem: "Home Page",
        companyInfo: "http://www.yongsan.go.kr"),
  ];

  test('should get company detail info', () async {
    // arragne
    when(() => repository.getCompanyDetailInfo(params: params))
        .thenAnswer((_) async => const Right(companyDetailInfoList));

    // act
    final result = await (usecase(params: params));

    // assert
    expect(result, const Right(companyDetailInfoList));
    verify(() => repository.getCompanyDetailInfo(params: params));
    verifyNoMoreInteractions(repository);
  });
}
