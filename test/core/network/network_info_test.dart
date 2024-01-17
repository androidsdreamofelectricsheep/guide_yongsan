import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_yongsan/core/network/network_info.dart';
import 'package:mocktail/mocktail.dart';

class ConnectivityMock extends Mock implements Connectivity {}

void main() {
  late ConnectivityMock connectivityMock;
  late NetworkInfo networkInfo;

  setUp(() {
    connectivityMock = ConnectivityMock();
    networkInfo = NetworkInfoImpl(connectivity: connectivityMock);
  });

  group('network info', () {
    test('should return true if mobile network', () async {
      // arrange
      when(() => connectivityMock.checkConnectivity())
          .thenAnswer((invocation) async => ConnectivityResult.mobile);

      // act
      final result = await networkInfo.isConnected;

      // assert
      verify(() => connectivityMock.checkConnectivity());
      expect(result, isTrue);
    });

    test('should return true if wifi', () async {
      // arrange
      when(() => connectivityMock.checkConnectivity())
          .thenAnswer((invocation) async => ConnectivityResult.wifi);

      // act
      final result = await networkInfo.isConnected;

      // assert
      verify(() => connectivityMock.checkConnectivity());
      expect(result, isTrue);
    });

    test('should return true if wifi ethernet', () async {
      // arrange
      when(() => connectivityMock.checkConnectivity())
          .thenAnswer((invocation) async => ConnectivityResult.ethernet);

      // act
      final result = await networkInfo.isConnected;

      // assert
      verify(() => connectivityMock.checkConnectivity());
      expect(result, isTrue);
    });

    test('should return false if no network connection', () async {
      // arrange
      when(() => connectivityMock.checkConnectivity())
          .thenAnswer((invocation) async => ConnectivityResult.none);

      // act
      final result = await networkInfo.isConnected;

      // assert
      verify(() => connectivityMock.checkConnectivity());
      expect(result, isFalse);
    });
  });
}
