import 'package:equatable/equatable.dart';

class CompanyDetailInfoEntity extends Equatable {
  final int companyItemId;
  final String companyItem;
  final String companyInfo;

  const CompanyDetailInfoEntity(
      {required this.companyItemId,
      required this.companyItem,
      required this.companyInfo});

  @override
  List<Object?> get props => [companyItemId, companyItem, companyInfo];
}
