import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/database_helper.dart';
import 'data/repositories/planet_repository_impl.dart';
import 'domain/repositories/planet_repository.dart';
import 'domain/usecases/seed_solar_system.dart';
import 'presentation/screens/home_screen.dart';
import 'domain/usecases/seed_cosmic_phenomena.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Database
  final databaseHelper = DatabaseHelper();

  // Initialize Repositories
  final planetRepository = PlanetRepositoryImpl(databaseHelper);

  // Seed solar system data if not already seeded
  final seedSolarSystem = SeedSolarSystem(planetRepository);
  if (!await seedSolarSystem.isSeeded()) {
    await seedSolarSystem.call();
  }

  // Seed cosmic phenomena data if not already seeded
  final seedCosmicPhenomena = SeedCosmicPhenomena(databaseHelper);
  if (!await seedCosmicPhenomena.isSeeded()) {
    await seedCosmicPhenomena.call();
  }

  runApp(CosmoEduApp(
    planetRepository: planetRepository,
  ));
}

class CosmoEduApp extends StatelessWidget {
  final PlanetRepository planetRepository;

  const CosmoEduApp({
    super.key,
    required this.planetRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PlanetRepository>.value(value: planetRepository),
      ],
      child: MaterialApp(
        title: 'Universe101',
        theme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
