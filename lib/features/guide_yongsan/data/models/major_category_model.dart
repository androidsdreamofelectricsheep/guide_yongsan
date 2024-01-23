import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part "major_category_model.g.dart";

@JsonSerializable()
class MajorCategoryModel extends MarjorCategoryEntity {
  const MajorCategoryModel({required super.majorId, required super.majorName});

  factory MajorCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$MajorCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MajorCategoryModelToJson(this);
  }
}
