import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/network/network_info.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/repositories/guide_yongsan_repository_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/main_info_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/usecases/get_main_info.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainInfoProvider with ChangeNotifier {
  List<MainInfoEntity>? mainInfo;
  Failure? failure;

  MainInfoProvider({this.mainInfo, this.failure});

  void eitherFailureOrMediumCategorya(
      {required MainInfoParams mainInfoParams,
      required MainInfoProvider mainInfoProvider}) async {
    GuideYongsanRepositoryImpl repository = GuideYongsanRepositoryImpl(
        remoteDataSource:
            GuideYongsanRemoteDataSourceImpl(httpClient: http.Client()),
        localDataSource: GuideYongsanLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        networkInfo: NetworkInfoImpl(connectivity: Connectivity()));

    final failureOrMediumCategory = await GetMainInfo(repository).call(
        params: MainInfoParams(
            majorId: mainInfoParams.majorId,
            mediumId: mainInfoParams.mediumId,
            minorId: mainInfoParams.minorId,
            numOfRows: mainInfoParams.numOfRows,
            pageNo: mainInfoParams.pageNo));

    failureOrMediumCategory.fold((newFailure) {
      mainInfo = null;
      failure = newFailure;
      notifyListeners();
    }, (newMainInfo) {
      mainInfo = newMainInfo;
      failure = null;
      notifyListeners();
    });
  }
}
