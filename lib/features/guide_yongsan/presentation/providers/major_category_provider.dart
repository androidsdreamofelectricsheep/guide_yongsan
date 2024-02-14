import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import 'package:guide_yongsan/core/errors/failure.dart';
import 'package:guide_yongsan/core/network/network_info.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/datasources/local/guide_yongsan_local_data_source_impl.dart';

import 'package:guide_yongsan/features/guide_yongsan/data/datasources/remote/guide_yongsan_remote_data_source_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/data/repositories/guide_yongsan_repository_impl.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/entities/marjor_category_entity.dart';
import 'package:guide_yongsan/features/guide_yongsan/domain/usecases/get_major_category.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MajorCategoryProvider with ChangeNotifier {
  List<MarjorCategoryEntity>? majorCategory;
  Failure? failure;

  MajorCategoryProvider({this.majorCategory, this.failure});

  void eitherFailureOrMajorCategory() async {
    GuideYongsanRepositoryImpl repository = GuideYongsanRepositoryImpl(
        remoteDataSource:
            GuideYongsanRemoteDataSourceImpl(httpClient: http.Client()),
        localDataSource: GuideYongsanLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        networkInfo: NetworkInfoImpl(connectivity: Connectivity()));

    final failureOrMajorCategory = await GetMajorCategory(repository).call();

    failureOrMajorCategory.fold((newFailure) {
      majorCategory = null;
      failure = newFailure;
      notifyListeners();
    }, (newMajorCategory) {
      majorCategory = newMajorCategory;
      failure = null;
      notifyListeners();
    });
  }
}
