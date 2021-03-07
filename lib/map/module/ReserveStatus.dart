
import 'dart:ui';

import 'package:flutter/material.dart';

enum ReserveStatus { FULL, AVAILABLE , URGENT }

extension ParseToString on ReserveStatus {
  Color toColor() {
    Color bgColor;
    switch (this) {
      case ReserveStatus.AVAILABLE: {
        bgColor = Colors.green;
        break;
      };
      case ReserveStatus.FULL: {
        bgColor = Colors.red;
        break;
      };
      case ReserveStatus.URGENT: {
        bgColor = Colors.yellow;
        break;
      };
      default: {
        bgColor = Colors.white;
        break;
      };
    }
    return bgColor;
  }
}
