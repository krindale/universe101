// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:universe101/main.dart';
import 'package:universe101/data/datasources/database_helper.dart';
import 'package:universe101/data/repositories/planet_repository_impl.dart';
import 'package:universe101/core/providers/theme_provider.dart';

void main() {
  testWidgets('CosmoEdu app smoke test', (WidgetTester tester) async {
    final databaseHelper = DatabaseHelper();
    final planetRepository = PlanetRepositoryImpl(databaseHelper);
    final themeProvider = ThemeProvider();

    await tester.pumpWidget(CosmoEduApp(
      planetRepository: planetRepository,
      themeProvider: themeProvider,
    ));

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
