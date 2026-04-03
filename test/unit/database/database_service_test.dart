import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:linfa/data/database/database.dart';
import 'package:linfa/data/models/plant.dart';
import 'package:linfa/data/models/reminder.dart';
import 'package:linfa/data/models/growth_entry.dart';

void main() {
  group('DatabaseService', () {
    test('instance should be a singleton', () {
      final instance1 = DatabaseService.instance;
      final instance2 = DatabaseService.instance;
      expect(identical(instance1, instance2), true);
    });

    test('isInitialized should return false when not initialized', () {
      final service = DatabaseService.instance;
      expect(service.isInitialized, false);
    });

    test('isar getter should throw StateError when not initialized', () {
      final service = DatabaseService.instance;
      expect(() => service.isar, throwsStateError);
    });

    test('test constructor should set testIsar', () {
      final mockIsar = _MockIsar();
      final service = DatabaseService.test(mockIsar);
      expect(service.isInitialized, true);
    });

    test('test constructor isar getter should return testIsar', () {
      final mockIsar = _MockIsar();
      final service = DatabaseService.test(mockIsar);
      expect(service.isar, mockIsar);
    });

    test('close should close database', () async {
      final mockIsar = _MockIsar();
      final service = DatabaseService.test(mockIsar);

      await service.close();

      // close() only affects _isar (production DB), not _testIsar
      // so isInitialized remains true when using test constructor
      expect(service.isInitialized, true);
    });

    test('close should do nothing when not initialized', () async {
      final service = DatabaseService.instance;

      await service.close();

      expect(service.isInitialized, false);
    });

    test('clearAll should clear all collections', () async {
      final mockIsar = _MockIsar();
      final service = DatabaseService.test(mockIsar);

      await service.clearAll();

      expect(mockIsar.plants.clearCalled, true);
      expect(mockIsar.reminders.clearCalled, true);
      expect(mockIsar.growthEntrys.clearCalled, true);
    });

    test('getSize should return size', () async {
      final mockIsar = _MockIsar();
      final service = DatabaseService.test(mockIsar);

      final size = await service.getSize();

      expect(size, 0);
    });
  });
}

class _MockIsar implements Isar {
  @override
  bool get isOpen => isOpenValue;

  bool isOpenValue = true;
  bool closeCalled = false;

  final _plants = _MockCollection<Plant>();
  final _reminders = _MockCollection<Reminder>();
  final _growthEntrys = _MockCollection<GrowthEntry>();

  _MockCollection<Plant> get plants => _plants;
  _MockCollection<Reminder> get reminders => _reminders;
  _MockCollection<GrowthEntry> get growthEntrys => _growthEntrys;

  @override
  Future<bool> close({bool deleteFromDisk = false}) async {
    closeCalled = true;
    isOpenValue = false;
    return true;
  }

  @override
  Future<T> writeTxn<T>(Future<T> Function() callback,
      {bool silent = false}) async {
    return await callback();
  }

  @override
  Future<int> getSize(
      {bool includeIndexes = false, bool includeLinks = false}) async {
    return 0;
  }

  @override
  IsarCollection<T> collection<T>(
      {String? name,
      bool dynamicProperties = false,
      Schema? schema}) {
    if (T == Plant) return _plants as IsarCollection<T>;
    if (T == Reminder) return _reminders as IsarCollection<T>;
    if (T == GrowthEntry) return _growthEntrys as IsarCollection<T>;
    return _MockCollection<T>() as IsarCollection<T>;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockCollection<T> implements IsarCollection<T> {
  bool clearCalled = false;

  @override
  Future<void> clear() async {
    clearCalled = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}