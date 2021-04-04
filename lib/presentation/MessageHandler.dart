import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_hk/presentation/articleDetails/article_details_page.dart';

class MessageHandler extends StatefulWidget {
  final Widget child;
  MessageHandler({required this.child});
  @override
  State createState() => MessageHandlerState();
}

class MessageHandlerState extends State<MessageHandler> {
  late Widget child;
  @override
  void initState() {
    super.initState();
    child = widget.child;

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("on push click to open app: $message");
      if (message.data.containsKey("id") &&
          message.data.containsKey("path") &&
          (message.data['path'] as String).contains("/articles/")) {
        Navigator.pushNamed(
          context,
          ArticleDetailsPage.routeName,
          arguments: ArticleDetailsPageArguments(message.data['id'] as String),
        );
      } else {
        print("either id or path not satifished, skip navigation");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
