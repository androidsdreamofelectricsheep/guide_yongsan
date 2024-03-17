import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/network/network_info.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/repositories/guide_yongsan_repository_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/company_detail_info_entity.dart';

import 'package:guide_yongsan/features/guide_yongsan/domain/usecases/get_company_detail_info.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CompanyDetailInfoProvider with ChangeNotifier {
  List<CompanyDetailInfoEntity>? companyDetailInfo;
  Failure? failure;

  CompanyDetailInfoProvider({this.companyDetailInfo, this.failure});

  void eitherFailureOrCompanyDetailInfo({required String companyId}) async {
    GuideYongsanRepositoryImpl repository = GuideYongsanRepositoryImpl(
        remoteDataSource:
            GuideYongsanRemoteDataSourceImpl(httpClient: http.Client()),
        localDataSource: GuideYongsanLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        networkInfo: NetworkInfoImpl(connectivity: Connectivity()));

    final failureOrMediumCategory = await GetCompanyDetailInfo(repository)
        .call(params: CompanyDetailInfoParams(companyId: companyId));

    failureOrMediumCategory.fold((newFailure) {
      companyDetailInfo = null;
      failure = newFailure;
      notifyListeners();
    }, (newCompanyDetailInfo) {
      companyDetailInfo = newCompanyDetailInfo;
      failure = null;
      notifyListeners();
    });
  }
}
