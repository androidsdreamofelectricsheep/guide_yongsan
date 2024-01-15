class NoParams {}

class BaseParams {
  final String serviceKey;
  final String returnType;
  final String global;

  BaseParams(
      {required this.serviceKey,
      required this.returnType,
      required this.global});
}

// 중분류
class MediumCategoryParams extends BaseParams {
  final String majorId;

  MediumCategoryParams(
      {required super.serviceKey,
      required super.returnType,
      required super.global,
      required this.majorId});
}

// 편의시설/업체 정보
class MainInfoParams extends MediumCategoryParams {
  final String mediumId;
  final String minorId;
  final int numOfRows;
  final int pageNo;

  MainInfoParams(
      {required super.serviceKey,
      required super.returnType,
      required super.global,
      required super.majorId,
      required this.mediumId,
      required this.minorId,
      required this.numOfRows,
      required this.pageNo});
}

// 시설/업체 세부정보
class CompanyDetailInfoParams extends BaseParams {
  final String companyId;

  CompanyDetailInfoParams(
      {required super.serviceKey,
      required super.returnType,
      required super.global,
      required this.companyId});
}
