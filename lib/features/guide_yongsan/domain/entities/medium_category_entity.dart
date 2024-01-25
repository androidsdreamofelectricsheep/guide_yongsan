import 'package:equatable/equatable.dart';

class MediumCategoryEntity extends Equatable {
  final String mediumId;
  final String mediumName;

  const MediumCategoryEntity(
      {required this.mediumId, required this.mediumName});

  @override
  List<Object?> get props => [mediumId, mediumName];
}
