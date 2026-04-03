class MockHiveBox {
  final Map<String, dynamic> _data = {};

  Future<T?> get<T>(String key, {T? defaultValue}) async {
    return _data[key] as T? ?? defaultValue;
  }

  Future<void> put(String key, dynamic value) async {
    _data[key] = value;
  }

  Future<void> delete(String key) async {
    _data.remove(key);
  }

  Future<void> clear() async {
    _data.clear();
  }

  int get length => _data.length;
  bool containsKey(String key) => _data.containsKey(key);
}
