import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/celestial_body.dart';
import '../../domain/entities/cosmic_phenomenon.dart';
import '../../domain/entities/space_exploration.dart';
import '../../domain/entities/user_progress.dart';

/// SQLite database helper for local storage
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'universe101.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Celestial Bodies table
    await db.execute('''
      CREATE TABLE celestial_bodies (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        modelUrl TEXT,
        facts TEXT NOT NULL,
        episodes TEXT NOT NULL,
        type TEXT NOT NULL,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // Planets table (extends celestial_bodies)
    await db.execute('''
      CREATE TABLE planets (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        modelUrl TEXT,
        facts TEXT NOT NULL,
        episodes TEXT NOT NULL,
        type TEXT NOT NULL,
        diameter REAL NOT NULL,
        distanceFromSun REAL NOT NULL,
        orbitalPeriod REAL NOT NULL,
        rotationPeriod REAL NOT NULL,
        mass REAL NOT NULL,
        gravity REAL NOT NULL,
        moons TEXT NOT NULL,
        hasRings INTEGER NOT NULL DEFAULT 0,
        composition TEXT NOT NULL,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // Cosmic Phenomena table
    await db.execute('''
      CREATE TABLE cosmic_phenomena (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        type TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        videoUrl TEXT,
        facts TEXT NOT NULL,
        historicalContext TEXT NOT NULL,
        nextOccurrence TEXT,
        location TEXT NOT NULL,
        rarity INTEGER NOT NULL,
        relatedBodies TEXT NOT NULL,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // Space Exploration table
    await db.execute('''
      CREATE TABLE space_explorations (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        type TEXT NOT NULL,
        spacecraftName TEXT,
        agency TEXT NOT NULL,
        launchDate TEXT NOT NULL,
        endDate TEXT,
        destination TEXT,
        achievements TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        crewMembers TEXT NOT NULL,
        status TEXT NOT NULL,
        historicalSignificance TEXT NOT NULL,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // User Progress table
    await db.execute('''
      CREATE TABLE user_progress (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        favoriteCelestialBodies TEXT NOT NULL,
        favoritePhenomena TEXT NOT NULL,
        favoriteExplorations TEXT NOT NULL,
        completedLearningCards TEXT NOT NULL,
        totalCardsViewed INTEGER NOT NULL DEFAULT 0,
        totalTimeSpentMinutes INTEGER NOT NULL DEFAULT 0,
        lastActiveAt TEXT,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // Create indexes for better query performance
    await db.execute(
        'CREATE INDEX idx_celestial_bodies_type ON celestial_bodies(type)');
    await db.execute(
        'CREATE INDEX idx_phenomena_type ON cosmic_phenomena(type)');
    await db.execute(
        'CREATE INDEX idx_explorations_status ON space_explorations(status)');
    await db.execute(
        'CREATE INDEX idx_user_progress_userId ON user_progress(userId)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
    if (oldVersion < newVersion) {
      // Add migration logic for future versions
    }
  }

  // CRUD operations for Planets
  Future<int> insertPlanet(Planet planet) async {
    final db = await database;
    final data = planet.toJson();
    data['facts'] = jsonEncode(data['facts']);
    data['episodes'] = jsonEncode(data['episodes']);
    data['moons'] = jsonEncode(data['moons']);
    data['hasRings'] = data['hasRings'] ? 1 : 0;

    return await db.insert('planets', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Planet>> getAllPlanets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('planets');

    return List.generate(maps.length, (i) {
      final map = Map<String, dynamic>.from(maps[i]);
      map['facts'] = jsonDecode(map['facts']);
      map['episodes'] = jsonDecode(map['episodes']);
      map['moons'] = jsonDecode(map['moons']);
      map['hasRings'] = map['hasRings'] == 1;
      return Planet.fromJson(map);
    });
  }

  Future<Planet?> getPlanetById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'planets',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    final map = Map<String, dynamic>.from(maps.first);
    map['facts'] = jsonDecode(map['facts']);
    map['episodes'] = jsonDecode(map['episodes']);
    map['moons'] = jsonDecode(map['moons']);
    map['hasRings'] = map['hasRings'] == 1;
    return Planet.fromJson(map);
  }

  Future<int> updatePlanet(Planet planet) async {
    final db = await database;
    final data = planet.toJson();
    data['facts'] = jsonEncode(data['facts']);
    data['episodes'] = jsonEncode(data['episodes']);
    data['moons'] = jsonEncode(data['moons']);
    data['hasRings'] = data['hasRings'] ? 1 : 0;

    return await db.update(
      'planets',
      data,
      where: 'id = ?',
      whereArgs: [planet.id],
    );
  }

  Future<int> deletePlanet(String id) async {
    final db = await database;
    return await db.delete(
      'planets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD operations for Cosmic Phenomena
  Future<int> insertPhenomenon(CosmicPhenomenon phenomenon) async {
    final db = await database;
    final data = phenomenon.toJson();
    data['facts'] = jsonEncode(data['facts']);
    data['relatedBodies'] = jsonEncode(data['relatedBodies']);

    return await db.insert('cosmic_phenomena', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CosmicPhenomenon>> getAllPhenomena() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('cosmic_phenomena');

    return List.generate(maps.length, (i) {
      final map = Map<String, dynamic>.from(maps[i]);
      map['facts'] = jsonDecode(map['facts']);
      map['relatedBodies'] = jsonDecode(map['relatedBodies']);
      return CosmicPhenomenon.fromJson(map);
    });
  }

  Future<CosmicPhenomenon?> getPhenomenonById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cosmic_phenomena',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    final map = Map<String, dynamic>.from(maps.first);
    map['facts'] = jsonDecode(map['facts']);
    map['relatedBodies'] = jsonDecode(map['relatedBodies']);
    return CosmicPhenomenon.fromJson(map);
  }

  // CRUD operations for Space Explorations
  Future<int> insertExploration(SpaceExploration exploration) async {
    final db = await database;
    final data = exploration.toJson();
    data['achievements'] = jsonEncode(data['achievements']);
    data['crewMembers'] = jsonEncode(data['crewMembers']);

    return await db.insert('space_explorations', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SpaceExploration>> getAllExplorations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('space_explorations');

    return List.generate(maps.length, (i) {
      final map = Map<String, dynamic>.from(maps[i]);
      map['achievements'] = jsonDecode(map['achievements']);
      map['crewMembers'] = jsonDecode(map['crewMembers']);
      return SpaceExploration.fromJson(map);
    });
  }

  // CRUD operations for User Progress
  Future<int> insertUserProgress(UserProgress progress) async {
    final db = await database;
    final data = progress.toJson();
    data['favoriteCelestialBodies'] =
        jsonEncode(data['favoriteCelestialBodies']);
    data['favoritePhenomena'] = jsonEncode(data['favoritePhenomena']);
    data['favoriteExplorations'] = jsonEncode(data['favoriteExplorations']);
    data['completedLearningCards'] =
        jsonEncode(data['completedLearningCards']);

    return await db.insert('user_progress', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserProgress?> getUserProgress(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user_progress',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (maps.isEmpty) return null;

    final map = Map<String, dynamic>.from(maps.first);
    map['favoriteCelestialBodies'] =
        jsonDecode(map['favoriteCelestialBodies']);
    map['favoritePhenomena'] = jsonDecode(map['favoritePhenomena']);
    map['favoriteExplorations'] = jsonDecode(map['favoriteExplorations']);
    map['completedLearningCards'] = jsonDecode(map['completedLearningCards']);
    return UserProgress.fromJson(map);
  }

  Future<int> updateUserProgress(UserProgress progress) async {
    final db = await database;
    final data = progress.toJson();
    data['favoriteCelestialBodies'] =
        jsonEncode(data['favoriteCelestialBodies']);
    data['favoritePhenomena'] = jsonEncode(data['favoritePhenomena']);
    data['favoriteExplorations'] = jsonEncode(data['favoriteExplorations']);
    data['completedLearningCards'] =
        jsonEncode(data['completedLearningCards']);

    return await db.update(
      'user_progress',
      data,
      where: 'userId = ?',
      whereArgs: [progress.userId],
    );
  }

  // Utility methods
  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  Future<void> deleteDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'universe101.db');
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}
