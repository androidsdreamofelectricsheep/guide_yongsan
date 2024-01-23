import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/main_info_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/main_info_entity.dart';

void main() {
  const tMainInfoModel = MainInfoModel(
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
      pointLat: "37.53881113761811");

  test('should be a subclass of entity', () async {
    expect(tMainInfoModel, isA<MainInfoEntity>());
  });

  group('toJson', () {
    test('should return a json map with proper data', () async {
      // act
      final result = tMainInfoModel.toJson();

      // assert
      final expectedJsonMap = {
        "num": 1,
        "administrtvAreaId": "3020000",
        "minorId": "001",
        "companyId": "2021579B12EBDF274E28ABB7622046FAF476",
        "companyName": "237페이지(237page)",
        "addr": "서울특별시 용산구 회나무로 13",
        "addrDetail": "1층",
        "keyWord": "#식당 #음식점 #한식 #육류 #고기요리 #화로구이 #파스타 #단체석",
        "addrId": "1117013000",
        "phone": null,
        "zipCode": "04343",
        "pointLng": "126.98827525591582",
        "pointLat": "37.53881113761811"
      };
      expect(result, expectedJsonMap);
    });
  });
}
