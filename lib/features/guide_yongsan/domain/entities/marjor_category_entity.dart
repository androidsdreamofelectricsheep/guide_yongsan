import 'package:equatable/equatable.dart';

class MarjorCategoryEntity extends Equatable {
  final String majorId;
  final String majorName;

  const MarjorCategoryEntity({required this.majorId, required this.majorName});

  @override
  List<Object?> get props => [majorId, majorName];
}
