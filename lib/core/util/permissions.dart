import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static checkLoactionPermission(BuildContext context) async {
    var status = await Permission.location.status;

    await Permission.location.request();

    if (status.isDenied) {
      await Permission.location.request();
    }

    if (status.isGranted || status.isLimited) {
      await Geolocator.isLocationServiceEnabled();
    }

    if (status.isRestricted || status.isPermanentlyDenied) {
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
