import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture6/main.dart';

void main() {
  testWidgets('main page builds scaffold', (tester) async {
    await tester.pumpWidget(const MainApp());
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
