import 'package:flutter/material.dart';

class ErrorRetryDialogWidget extends StatefulWidget {
  @override
  _ErrorRetryDialogWidgetState createState() => _ErrorRetryDialogWidgetState();
}

class _ErrorRetryDialogWidgetState extends State<ErrorRetryDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text("噢！發生問題\n請稍候重試😖"),
      ),
    );
  }
}
