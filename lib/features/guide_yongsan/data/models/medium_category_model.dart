import 'package:guide_yongsan/features/guide_yongsan/domain/entities/medium_category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part "medium_category_model.g.dart";

@JsonSerializable()
class MediumCategoryModel extends MediumCategoryEntity {
  const MediumCategoryModel(
      {required super.mediumId, required super.mediumName});

  factory MediumCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$MediumCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MediumCategoryModelToJson(this);
  }
}
