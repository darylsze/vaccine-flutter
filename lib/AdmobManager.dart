import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_hk/stringRes.dart';

class AdmobManager {
  isDebug() {
    return kDebugMode == true;
  }

  Widget getBanner(String adUnitId) {
    if (isDebug() == true) {
      return Container(
        child: Text("ads banner"),
      );
    }
    return AdmobBanner(
      adUnitId: adUnitId,
      adSize: AdmobBannerSize.BANNER,
    );
  }
}
