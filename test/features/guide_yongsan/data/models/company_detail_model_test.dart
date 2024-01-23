import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/company_detail_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/company_detail_info_entity.dart';

void main() {
  const tCompanyDetailInfoModel = CompanyDetailInfoModel(
      companyItemId: 1,
      companyItem: "Operating Time",
      companyInfo: "Weekday 09:00~18:00");

  test('should be a subclass of entity', () async {
    expect(tCompanyDetailInfoModel, isA<CompanyDetailInfoEntity>());
  });

  group('toJson', () {
    test('should return a json map with proper data', () async {
      // act
      final result = tCompanyDetailInfoModel.toJson();

      // assert
      final expectedJsonMap = {
        "companyItemId": 1,
        "companyItem": "Operating Time",
        "companyInfo": "Weekday 09:00~18:00"
      };
      expect(result, expectedJsonMap);
    });
  });
}
