// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:vaccine_hk/counter/counter.dart';
import 'package:vaccine_hk/counter/view/counter_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: CounterPage()));
      expect(find.byType(CounterView), findsOneWidget);
    });
  });
}
