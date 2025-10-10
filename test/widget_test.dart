// This is a basic Flutter widget test.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:universe101/main.dart';
import 'package:universe101/data/datasources/database_helper.dart';
import 'package:universe101/data/repositories/planet_repository_impl.dart';

void main() {
  testWidgets('CosmoEdu app smoke test', (WidgetTester tester) async {
    // Initialize dependencies for test
    final databaseHelper = DatabaseHelper();
    final planetRepository = PlanetRepositoryImpl(databaseHelper);

    // Build our app and trigger a frame.
    await tester.pumpWidget(CosmoEduApp(
      planetRepository: planetRepository,
    ));

    // Verify that the app builds without errors.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
