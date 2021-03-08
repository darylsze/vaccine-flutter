extension DateTimeConvert on String {
  DateTime parseLiteral() {
    var _month = this.split("/")[1];
    var _date = this.split("/")[0];
    var date = DateTime(2021, int.parse(_month), int.parse(_date));
    return date;
  }
}
