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
class MediumCategoryParams {
  final String majorId;

  const MediumCategoryParams({required this.majorId});
}

// 편의시설/업체 정보
class MainInfoParams extends MediumCategoryParams {
  final String mediumId;
  final String minorId;
  int? numOfRows;
  int? pageNo;

  MainInfoParams(
      {required super.majorId,
      required this.mediumId,
      required this.minorId,
      this.numOfRows,
      this.pageNo});
}

// 시설/업체 세부정보
class CompanyDetailInfoParams {
  final String companyId;

  const CompanyDetailInfoParams({required this.companyId});
}
