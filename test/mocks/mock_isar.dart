import 'package:isar/isar.dart';

class MockIsarCollection<T> {
  final List<T> _items = [];
  final Map<int, T> _byId = {};
  int _nextId = 1;

  List<T> get items => List.unmodifiable(_items);

  Future<List<T>> findAll() async => List.unmodifiable(_items);

  Future<T?> get(int id) async => _byId[id];

  Future<int> put(T item) async {
    final idField = _getId(item);
    final newId = idField ?? _nextId++;
    _setId(item, newId);
    _byId[newId] = item;
    if (!_items.contains(item)) {
      _items.add(item);
    }
    return newId;
  }

  Future<bool> delete(int id) async {
    _byId.remove(id);
    _items.removeWhere((item) => _getId(item) == id);
    return true;
  }

  Future<int> clear() async {
    _items.clear();
    _byId.clear();
    _nextId = 1;
    return 0;
  }

  Future<int> count() async => _items.length;

  int? _getId(T item) {
    if (item is dynamic && item.id != null) {
      return item.id as int?;
    }
    return null;
  }

  void _setId(T item, int id) {
    if (item is dynamic) {
      item.id = id;
    }
  }

  MockQuery<T> where() => MockQuery<T>(this);
  MockQuery<T> sortByCreatedAtDesc() => MockQuery<T>(this).._sortDesc = true;
  MockQuery<T> sortByNextScheduled() => MockQuery<T>(this);
  MockQuery<T> sortByDateDesc() => MockQuery<T>(this);
}

class MockQuery<T> {
  final MockIsarCollection<T> _collection;
  bool _sortDesc = false;

  MockQuery(this._collection);

  MockQuery<T> where() => this;
  MockQuery<T> sortByCreatedAtDesc() {
    _sortDesc = true;
    return this;
  }

  MockQuery<T> sortByNextScheduled() => this;
  MockQuery<T> sortByDateDesc() {
    _sortDesc = true;
    return this;
  }

  Future<List<T>> findAll() async {
    final items = _collection.items.toList();
    if (_sortDesc) {
      items.reversed.toList();
    }
    return items;
  }

  Future<T?> get(int id) async => _collection.get(id);
}
