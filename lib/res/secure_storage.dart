import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  // Constructor
  SecureStorage() : _storage = const FlutterSecureStorage();

  /// Write a value to secure storage
  Future<void> writeValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a value from secure storage
  Future<String?> readValue(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a value from secure storage
  Future<void> deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  /// Check if a value exists in secure storage
  Future<bool> containsKey(String key) async {
    final keys = await _storage.readAll();
    return keys.containsKey(key);
  }

  /// Write a boolean value
  Future<void> writeBool(String key, bool value) async {
    await writeValue(key, value.toString());
  }

  /// Read a boolean value
  Future<bool> readBool(String key) async {
    final value = await readValue(key);
    return value?.toLowerCase() == 'true';
  }

  /// Write an integer value
  Future<void> writeInt(String key, int value) async {
    await writeValue(key, value.toString());
  }

  /// Read an integer value
  Future<int?> readInt(String key) async {
    final value = await readValue(key);
    return value != null ? int.tryParse(value) : null;
  }

  /// Write a double value
  Future<void> writeDouble(String key, double value) async {
    await writeValue(key, value.toString());
  }

  /// Read a double value
  Future<double?> readDouble(String key) async {
    final value = await readValue(key);
    return value != null ? double.tryParse(value) : null;
  }

  /// Write a list of strings
  Future<void> writeStringList(String key, List<String> values) async {
    await writeValue(key, values.join(','));
  }

  /// Read a list of strings
  Future<List<String>?> readStringList(String key) async {
    final value = await readValue(key);
    return value?.split(',');
  }

  /// Clear all stored values
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}