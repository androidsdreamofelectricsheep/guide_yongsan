import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/network/network_info.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/repositories/guide_yongsan_repository_impl.dart';

import 'package:guide_yongsan/features/guide_yongsan/domain/usecases/get_main_info.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainInfoProvider with ChangeNotifier {
  Map mainInfoMap = {};
  Failure? failure;
  bool loading = false;
  final int numOfRows = 999;
  String? majorId;
  String? mediumId;
  String? minorId;
  String? keyName;

  void eitherFailureOrMainInfo({required MainInfoParams mainInfoParams}) async {
    GuideYongsanRepositoryImpl repository = GuideYongsanRepositoryImpl(
        remoteDataSource:
            GuideYongsanRemoteDataSourceImpl(httpClient: http.Client()),
        localDataSource: GuideYongsanLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        networkInfo: NetworkInfoImpl(connectivity: Connectivity()));

    keyName = mainInfoParams.majorId +
        mainInfoParams.mediumId +
        mainInfoParams.minorId;
    loading = true;

    notifyListeners();

    final failureOrMainInfo = await GetMainInfo(repository).call(
        params: MainInfoParams(
            majorId: mainInfoParams.majorId,
            mediumId: mainInfoParams.mediumId,
            minorId: mainInfoParams.minorId,
            numOfRows: numOfRows,
            pageNo: mainInfoMap[mainInfoParams.minorId]?['page'] ?? 1));

    failureOrMainInfo.fold((newFailure) {
      failure = newFailure;
      loading = false;
      notifyListeners();
    }, (newMainInfo) {
      if (!mainInfoMap.containsKey(mainInfoParams.minorId)) {
        mainInfoMap[keyName] = {};
        mainInfoMap[keyName]?['list'] = [];

        mainInfoMap[keyName]?['page'] = 1;
      }
      mainInfoMap[keyName]?['list']?.addAll(newMainInfo);
      mainInfoMap[keyName]?['page'] = mainInfoMap[keyName]?['page'] += 1;
      failure = null;
      loading = false;
      notifyListeners();
    });
  }
}
