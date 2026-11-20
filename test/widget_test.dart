import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

void main() {
  // Verifica que los créditos del desarrollador se muestren
  testWidgets('Muestra los créditos del desarrollador', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: DeveloperCredits())),
    );

    expect(find.text('Hecho por el ingeniero'), findsOneWidget);
    expect(find.text('Ernesto Alfonso Sánchez Montiel'), findsOneWidget);
  });
}
