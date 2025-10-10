import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:universe101/database/database_helper.dart';
import 'package:universe101/models/celestial_body.dart';
import 'package:universe101/models/cosmic_phenomenon.dart';
import 'package:universe101/models/space_exploration.dart';
import 'package:universe101/models/user_progress.dart';

void main() {
  // Initialize FFI for testing
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('Database Tests', () {
    late DatabaseHelper dbHelper;

    setUp(() async {
      dbHelper = DatabaseHelper();
      // Delete any existing database before each test
      await dbHelper.deleteDatabase();
    });

    tearDown(() async {
      await dbHelper.close();
    });

    test('Database creation', () async {
      final db = await dbHelper.database;
      expect(db.isOpen, true);
    });

    test('Insert and retrieve Planet', () async {
      final planet = Planet(
        id: 'earth',
        name: 'Earth',
        description: 'Our home planet',
        imageUrl: 'https://example.com/earth.jpg',
        facts: {'Population': '8 billion'},
        episodes: ['Formation of Earth'],
        diameter: 12742,
        distanceFromSun: 1.0,
        orbitalPeriod: 365.25,
        rotationPeriod: 24.0,
        mass: 1.0,
        gravity: 9.8,
        moons: ['Moon'],
        hasRings: false,
        composition: 'Rocky',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await dbHelper.insertPlanet(planet);
      final retrieved = await dbHelper.getPlanetById('earth');

      expect(retrieved, isNotNull);
      expect(retrieved!.name, 'Earth');
      expect(retrieved.diameter, 12742);
      expect(retrieved.moons.length, 1);
    });

    test('Get all Planets', () async {
      final earth = Planet(
        id: 'earth',
        name: 'Earth',
        description: 'Our home planet',
        imageUrl: 'https://example.com/earth.jpg',
        facts: {},
        episodes: [],
        diameter: 12742,
        distanceFromSun: 1.0,
        orbitalPeriod: 365.25,
        rotationPeriod: 24.0,
        mass: 1.0,
        gravity: 9.8,
        moons: ['Moon'],
        composition: 'Rocky',
      );

      final mars = Planet(
        id: 'mars',
        name: 'Mars',
        description: 'The Red Planet',
        imageUrl: 'https://example.com/mars.jpg',
        facts: {},
        episodes: [],
        diameter: 6779,
        distanceFromSun: 1.52,
        orbitalPeriod: 687,
        rotationPeriod: 24.6,
        mass: 0.107,
        gravity: 3.7,
        moons: ['Phobos', 'Deimos'],
        composition: 'Rocky',
      );

      await dbHelper.insertPlanet(earth);
      await dbHelper.insertPlanet(mars);

      final planets = await dbHelper.getAllPlanets();
      expect(planets.length, 2);
    });

    test('Update Planet', () async {
      final planet = Planet(
        id: 'earth',
        name: 'Earth',
        description: 'Our home planet',
        imageUrl: 'https://example.com/earth.jpg',
        facts: {},
        episodes: [],
        diameter: 12742,
        distanceFromSun: 1.0,
        orbitalPeriod: 365.25,
        rotationPeriod: 24.0,
        mass: 1.0,
        gravity: 9.8,
        moons: ['Moon'],
        composition: 'Rocky',
      );

      await dbHelper.insertPlanet(planet);

      final updatedPlanet = Planet(
        id: 'earth',
        name: 'Earth - Updated',
        description: 'Updated description',
        imageUrl: 'https://example.com/earth.jpg',
        facts: {'New': 'Fact'},
        episodes: [],
        diameter: 12742,
        distanceFromSun: 1.0,
        orbitalPeriod: 365.25,
        rotationPeriod: 24.0,
        mass: 1.0,
        gravity: 9.8,
        moons: ['Moon'],
        composition: 'Rocky',
      );

      await dbHelper.updatePlanet(updatedPlanet);
      final retrieved = await dbHelper.getPlanetById('earth');

      expect(retrieved!.name, 'Earth - Updated');
      expect(retrieved.description, 'Updated description');
    });

    test('Delete Planet', () async {
      final planet = Planet(
        id: 'earth',
        name: 'Earth',
        description: 'Our home planet',
        imageUrl: 'https://example.com/earth.jpg',
        facts: {},
        episodes: [],
        diameter: 12742,
        distanceFromSun: 1.0,
        orbitalPeriod: 365.25,
        rotationPeriod: 24.0,
        mass: 1.0,
        gravity: 9.8,
        moons: ['Moon'],
        composition: 'Rocky',
      );

      await dbHelper.insertPlanet(planet);
      await dbHelper.deletePlanet('earth');
      final retrieved = await dbHelper.getPlanetById('earth');

      expect(retrieved, isNull);
    });

    test('Insert and retrieve CosmicPhenomenon', () async {
      final phenomenon = CosmicPhenomenon(
        id: 'solar-eclipse-2024',
        name: 'Solar Eclipse 2024',
        description: 'Total solar eclipse',
        type: PhenomenonType.eclipse,
        imageUrl: 'https://example.com/eclipse.jpg',
        facts: ['Rare event', 'Visible from North America'],
        historicalContext: 'One of the most observed eclipses',
        location: 'North America',
        rarity: 8,
        relatedBodies: ['sun', 'moon'],
        createdAt: DateTime.now(),
      );

      await dbHelper.insertPhenomenon(phenomenon);
      final retrieved = await dbHelper.getPhenomenonById('solar-eclipse-2024');

      expect(retrieved, isNotNull);
      expect(retrieved!.name, 'Solar Eclipse 2024');
      expect(retrieved.type, PhenomenonType.eclipse);
    });

    test('Insert and retrieve SpaceExploration', () async {
      final exploration = SpaceExploration(
        id: 'apollo-11',
        name: 'Apollo 11',
        description: 'First moon landing',
        type: ExplorationType.mannedMission,
        spacecraftName: 'Apollo 11',
        agency: 'NASA',
        launchDate: DateTime(1969, 7, 16),
        endDate: DateTime(1969, 7, 24),
        destination: 'Moon',
        achievements: ['First humans on the Moon'],
        imageUrl: 'https://example.com/apollo11.jpg',
        crewMembers: ['Neil Armstrong', 'Buzz Aldrin', 'Michael Collins'],
        status: ExplorationStatus.completed,
        historicalSignificance: 'Historic achievement',
        createdAt: DateTime.now(),
      );

      await dbHelper.insertExploration(exploration);
      final explorations = await dbHelper.getAllExplorations();

      expect(explorations.length, 1);
      expect(explorations.first.name, 'Apollo 11');
      expect(explorations.first.crewMembers.length, 3);
    });

    test('User Progress tracking', () async {
      final progress = UserProgress(
        id: 'user-progress-1',
        userId: 'user-1',
        favoriteCelestialBodies: ['earth', 'mars'],
        favoritePhenomena: ['solar-eclipse-2024'],
        favoriteExplorations: ['apollo-11'],
        completedLearningCards: {'card-1': true, 'card-2': false},
        totalCardsViewed: 5,
        totalTimeSpentMinutes: 120,
        createdAt: DateTime.now(),
      );

      await dbHelper.insertUserProgress(progress);
      final retrieved = await dbHelper.getUserProgress('user-1');

      expect(retrieved, isNotNull);
      expect(retrieved!.favoriteCelestialBodies.length, 2);
      expect(retrieved.totalCardsViewed, 5);
    });

    test('User Progress add favorite', () async {
      final progress = UserProgress(
        id: 'user-progress-1',
        userId: 'user-1',
        favoriteCelestialBodies: ['earth'],
        favoritePhenomena: [],
        favoriteExplorations: [],
        completedLearningCards: {},
        totalCardsViewed: 0,
        totalTimeSpentMinutes: 0,
      );

      final updated = progress.addFavoriteCelestialBody('mars');
      expect(updated.favoriteCelestialBodies.length, 2);
      expect(updated.favoriteCelestialBodies, contains('mars'));
    });

    test('User Progress completion percentage', () async {
      final progress = UserProgress(
        id: 'user-progress-1',
        userId: 'user-1',
        favoriteCelestialBodies: [],
        favoritePhenomena: [],
        favoriteExplorations: [],
        completedLearningCards: {
          'card-1': true,
          'card-2': true,
          'card-3': false,
          'card-4': false,
        },
        totalCardsViewed: 2,
        totalTimeSpentMinutes: 0,
      );

      expect(progress.completionPercentage, 50.0);
    });
  });
}
