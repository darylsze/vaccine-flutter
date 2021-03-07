import 'package:flutter_counter/map/module/CenterInfo.dart';
import 'package:flutter_counter/map/module/ReserveStatus.dart';

class Repo {
  Future<Set<CenterInfo>> getAllCenterInfos() {
    return Future.delayed(Duration(seconds: 2),
        () => {
          CenterInfo("a", "a", 22.2900426, 114.1435092, ReserveStatus.FULL),
          CenterInfo("b", "b", 22.3173771, 114.259532, ReserveStatus.AVAILABLE),
          CenterInfo("c", "c", 22.2848009, 114.2236058, ReserveStatus.URGENT),
          CenterInfo("d", "d", 22.3608107, 114.1253342, ReserveStatus.FULL),
        });
  }
}
