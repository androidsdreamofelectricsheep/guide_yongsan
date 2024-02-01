import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/network/network_info.dart';
import 'package:guide_yongsan/core/params/params.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/repositories/guide_yongsan_repository_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/medium_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/usecases/get_medium_category.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MediumCategoryProvider with ChangeNotifier {
  List<MediumCategoryEntity>? mediumCategory;
  Failure? failure;

  MediumCategoryProvider({this.mediumCategory, this.failure});

  void eitherFailureOrMediumCategorya(
      {required String majorId,
      required MediumCategoryProvider mediumCategoryProvider}) async {
    GuideYongsanRepositoryImpl repository = GuideYongsanRepositoryImpl(
        remoteDataSource:
            GuideYongsanRemoteDataSourceImpl(httpClient: http.Client()),
        localDataSource: GuideYongsanLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        networkInfo: NetworkInfoImpl(connectivity: Connectivity()));

    final failureOrMediumCategory = await GetMediumCategory(repository)
        .call(params: MediumCategoryParams(majorId: majorId));

    failureOrMediumCategory.fold((newFailure) {
      mediumCategory = null;
      failure = newFailure;
      notifyListeners();
    }, (newMediumCategory) {
      mediumCategory = newMediumCategory;
      failure = null;
      notifyListeners();
    });
  }
}
