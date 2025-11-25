import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:fintech_flutter_app/core/database/database_helper.dart';
import 'package:fintech_flutter_app/features/profiles/data/models/profile_model.dart';
import 'package:fintech_flutter_app/features/cards/data/models/card_model.dart';
import 'package:fintech_flutter_app/features/transactions/data/models/transaction_model.dart';
import 'package:fintech_flutter_app/features/categories/data/models/category_model.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('Database Tests', () {
    test('Database creation and table check', () async {
      final dbHelper = DatabaseHelper();
      final db = await dbHelper.database;

      final tables = await db.query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
      final tableNames = tables.map((row) => row['name'] as String).toList();

      expect(tableNames, contains('PROFILES'));
      expect(tableNames, contains('CARDS'));
      expect(tableNames, contains('TRANSACTIONS'));
      expect(tableNames, contains('CATEGORIES'));
    });

    test('ProfileModel serialization', () {
      final model = ProfileModel(
        id: '1',
        name: 'Test',
        balance: 100.0,
        createdAt: '2023-10-27T10:00:00Z',
        updatedAt: '2023-10-27T10:00:00Z',
      );
      final map = model.toMap();
      expect(map['id'], '1');
      expect(map['name'], 'Test');
      expect(map['balance'], 100.0);
      expect(map['createdAt'], '2023-10-27T10:00:00Z');

      final newModel = ProfileModel.fromMap(map);
      expect(newModel.id, model.id);
      expect(newModel.name, model.name);
      expect(newModel.balance, model.balance);
      expect(newModel.createdAt, model.createdAt);
    });

    test('CardModel serialization', () {
      final model = CardModel(
        id: '1',
        profileId: 'p1',
        name: 'Nubank',
        closingDay: 10,
        dueDay: 15,
        limitAmount: 1000.0,
        createdAt: '2023-10-27T10:00:00Z',
        updatedAt: '2023-10-27T10:00:00Z',
      );
      final map = model.toMap();
      expect(map['id'], '1');
      expect(map['limitAmount'], 1000.0);
      expect(map['createdAt'], '2023-10-27T10:00:00Z');

      final newModel = CardModel.fromMap(map);
      expect(newModel.id, model.id);
      expect(newModel.limitAmount, model.limitAmount);
      expect(newModel.createdAt, model.createdAt);
    });

    test('CategoryModel serialization', () {
      final model = CategoryModel(
        id: '1',
        name: 'Food',
        icon: 'fastfood',
        color: 'red',
        createdAt: '2023-10-27T10:00:00Z',
        updatedAt: '2023-10-27T10:00:00Z',
      );
      final map = model.toMap();
      expect(map['id'], '1');
      expect(map['name'], 'Food');

      final newModel = CategoryModel.fromMap(map);
      expect(newModel.id, model.id);
      expect(newModel.name, model.name);
    });

    test('TransactionModel serialization', () {
      final model = TransactionModel(
        id: '1',
        profileId: 'p1',
        amount: 50.0,
        description: 'Lunch',
        type: 'expense',
        date: '2023-10-27',
        categoryId: 'c1',
        isRecurring: true,
        recurrenceFrequency: 'monthly',
        installmentNumber: 1,
        totalInstallments: 12,
        status: 'pending',
        createdAt: '2023-10-27T10:00:00Z',
        updatedAt: '2023-10-27T10:00:00Z',
      );
      final map = model.toMap();
      expect(map['id'], '1');
      expect(map['isRecurring'], 1); // Stored as int
      expect(map['installmentNumber'], 1);
      expect(map['status'], 'pending');

      final newModel = TransactionModel.fromMap(map);
      expect(newModel.id, model.id);
      expect(newModel.isRecurring, true);
      expect(newModel.installmentNumber, 1);
      expect(newModel.status, 'pending');
    });
  });
}
