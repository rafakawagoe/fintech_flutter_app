import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fintech_app.db');
    return await openDatabase(
      path,
      version: 2, 
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS TRANSACTIONS');
    await db.execute('DROP TABLE IF EXISTS CARDS');
    await db.execute('DROP TABLE IF EXISTS PROFILES');
    await db.execute('DROP TABLE IF EXISTS CATEGORIES');
    await _onCreate(db, newVersion);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE PROFILES (
        id TEXT PRIMARY KEY,
        name TEXT,
        balance REAL,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE CARDS (
        id TEXT PRIMARY KEY,
        profileId TEXT,
        name TEXT,
        closingDay INTEGER,
        dueDay INTEGER,
        limitAmount REAL,
        createdAt TEXT,
        updatedAt TEXT,
        FOREIGN KEY (profileId) REFERENCES PROFILES (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE CATEGORIES (
        id TEXT PRIMARY KEY,
        name TEXT,
        icon TEXT,
        color TEXT,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE TRANSACTIONS (
        id TEXT PRIMARY KEY,
        profileId TEXT,
        cardId TEXT,
        categoryId TEXT,
        amount REAL,
        description TEXT,
        type TEXT,
        date TEXT,
        isRecurring INTEGER,
        recurrenceFrequency TEXT,
        installmentNumber INTEGER,
        totalInstallments INTEGER,
        status TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        FOREIGN KEY (profileId) REFERENCES PROFILES (id) ON DELETE CASCADE,
        FOREIGN KEY (cardId) REFERENCES CARDS (id) ON DELETE SET NULL,
        FOREIGN KEY (categoryId) REFERENCES CATEGORIES (id) ON DELETE SET NULL
      )
    ''');
  }
}
