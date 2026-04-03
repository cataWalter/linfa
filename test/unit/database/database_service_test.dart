import 'package:flutter_test/flutter_test.dart';
import 'package:linfa/data/database/database.dart';
import 'package:isar/isar.dart';

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
  });
}

class _MockIsarCollection<T> {
  bool clearCalled = false;

  Future<void> clear() async {
    clearCalled = true;
  }
}

class _MockIsar implements Isar {
  @override
  bool get isOpen => isOpenValue;

  bool isOpenValue = true;
  bool closeCalled = false;

  late _MockIsarCollection plants;
  late _MockIsarCollection reminders;
  late _MockIsarCollection growthEntrys;

  @override
  Future<bool> close({bool deleteFromDisk = false}) async {
    closeCalled = true;
    return true;
  }

  @override
  Future<T> writeTxn<T>(Future<T> Function() callback,
      {bool silent = false}) async {
    return await callback();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
