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
