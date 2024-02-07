import 'dart:convert';

import 'package:guide_yongsan/core/constants/constants.dart';
import 'package:guide_yongsan/core/errors/exceptions.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/company_detail_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/main_info_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/major_category_model.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/models/medium_category_model.dart';
import 'package:http/http.dart' as http;

class GuideYongsanRemoteDataSourceImpl implements GuideYongsanRemoteDataSource {
  final http.Client httpClient;

  GuideYongsanRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<CompanyDetailInfoModel>> getCompanyDetailInfo(
      {required CompanyDetailInfoParams companyDetailInfoParams}) async {
    var companyId = companyDetailInfoParams.companyId;
    final url = Uri.parse(
        '$baseUrl/$companyDetailInfo?$necessaryParams&$companyIdParam=$companyId');

    final response = await httpClient.get(url);

    List<CompanyDetailInfoModel> companyDetailList = [];
    if (response.statusCode == 200) {
      final companyDetails = jsonDecode(response.body)['item'];

      for (var companyDetail in companyDetails) {
        companyDetailList.add(CompanyDetailInfoModel.fromJson(companyDetail));
      }

      return companyDetailList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MainInfoModel>> getMainInfo(
      {required MainInfoParams mainInfoParams}) async {
    var majorId = mainInfoParams.majorId;
    var mediumId = mainInfoParams.mediumId;
    var minorId = mainInfoParams.minorId;
    final url = Uri.parse(
        '$baseUrl/$mainInfo?$necessaryParams&$majorCategory=$majorId&$mediumCategory=$mediumId&$minorIdParam=$minorId&$numOfRowsParam=$numOfRows&$pageNoParam=$pageNo');
    final response = await httpClient.get(url);

    List<MainInfoModel> mainInfoList = [];
    if (response.statusCode == 200) {
      final mainInfos = json.decode(response.body)['item'];

      for (var mainInfo in mainInfos) {
        mainInfoList.add(MainInfoModel.fromJson(mainInfo));
      }

      return mainInfoList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MajorCategoryModel>> getMajorCategory() async {
    final url = Uri.parse('$baseUrl/$majorCategory?$necessaryParams');
    final response = await httpClient.get(url);

    List<MajorCategoryModel> majorCategoryList = [];
    if (response.statusCode == 200) {
      final majorCategories = jsonDecode(response.body)['body']['item'];
      // print('#################');
      // print(majorCategories);
      // print('#################');
      for (var majorCategory in majorCategories) {
        majorCategoryList.add(MajorCategoryModel.fromJson(majorCategory));
      }
      // print('#################');
      // print(majorCategoryList);
      // print('#################');
      return majorCategoryList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MediumCategoryModel>> getMediumCategory(
      {required MediumCategoryParams majorId}) async {
    final url = Uri.parse(
        '$baseUrl/$mediumCategory?$necessaryParams&$majorCategory=${majorId.majorId}');

    final response = await httpClient.get(url);

    List<MediumCategoryModel> mediumCategoryList = [];
    if (response.statusCode == 200) {
      final mediumCategories = jsonDecode(response.body)['body']['item'];

      for (var mediumCategory in mediumCategories) {
        mediumCategoryList.add(MediumCategoryModel.fromJson(mediumCategory));
      }

      return mediumCategoryList;
    } else {
      throw ServerException();
    }
  }
}
