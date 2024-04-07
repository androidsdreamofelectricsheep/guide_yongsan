import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static checkLoactionPermission(BuildContext context) async {
    var status = await Permission.location.status;
    var fromLocationAccessModal = await Permission.location.request();

    await Permission.location.request();

    // 최초 앱 실행 후 로케이션 엑세스 모달창에서 '앱 사용 중에만 허용' 선택을 하도라도
    // status는 디폴트로 isPermanentlyDenied 상태기 때문에 '위치 허용을 하지 않으면 앱을 이요할 수 없다'는 커스텀 모달창을 호출하는 로직을 타게 됨
    // 이를 방지하기 위함
    if (fromLocationAccessModal.isGranted) {
      await Geolocator.isLocationServiceEnabled();
    }

    if (status.isDenied) {
      // 앱 실행 > 허용 안함 > 앱 재시작 > 안드로이드 자체 모달(앱 사용 중에만 허용 / 이번만 허용 / 허용 안함 *여기서 다시 허용 안함 후 앱 재시작하면 커스텀 모달)
      await Permission.location.request();
    }

    if (status.isGranted || status.isLimited) {
      await Geolocator.isLocationServiceEnabled();
    }

    if (status.isRestricted && !fromLocationAccessModal.isGranted ||
        status.isPermanentlyDenied && !fromLocationAccessModal.isGranted) {
      if (!context.mounted) return;

      showDialog(
          context: context,
          builder: (context) {
            // 권한없음을 다이얼로그로 알림
            return AlertDialog(
              content: const Text(
                  'If location permission is not allowed, GuideYongsan is not available. Please allow to use GuideYongsan.'),
              actions: [
                TextButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      SystemNavigator.pop();
                    },
                    child: const Text('Close')),
                TextButton(
                    onPressed: () {
                      openAppSettings();
                      Navigator.of(context).pop();
                    },
                    child: const Text('To allow')),
              ],
            );
          });

      // openAppSettings();
    }
  }
}
