import 'package:intl/intl.dart';

extension DateTimeConvert on String {
  DateTime parseDateLiteral() {
    var _month = this.split("/")[1];
    var _date = this.split("/")[0];
    var date = DateTime(2021, int.parse(_month), int.parse(_date));
    return date;
  }

  DateTime parseDateTimeLiteral() {
    String pattern = DateFormat("dd/MM/yyyy HH:mm a").pattern!;
    return DateFormat(pattern).parse(this);
  }
}

extension DateTimeExtension on DateTime {
  String toHumanFriendly() {
    var diff = this.difference(DateTime.now()).inDays.abs();
    print("diff: $diff");
    if (diff == 0) {
      return "今天";
    } else if (diff == 1) {
      return "明天";
    }
    return "${this.day}/${this.month}";
  }

  String toWeekDay() {
    switch (this.weekday) {
      case 1:
        return "星期一";
      case 2:
        return "星期二";
      case 3:
        return "星期三";
      case 4:
        return "星期四";
      case 5:
        return "星期五";
      case 6:
        return "星期六";
      case 7:
        return "星期日";
      default:
        return "N/A";
    }
  }
}
