import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrefUtils {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String> getString(String key) async {
    return await _secureStorage.read(key: key) ?? "";
  }

  Future<void> setString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<int> getInt(String key) async {
    String? value = await _secureStorage.read(key: key);
    return value != null ? int.tryParse(value) ?? 0 : 0;
  }

  Future<void> setInt(String key, int value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<bool> getBool(String key) async {
    String? value = await _secureStorage.read(key: key);
    return value != null ? value.toLowerCase() == 'true' : false;
  }

  Future<void> setBool(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  // Example usage of keys
  static const String authToken = "authToken";
  static const String refreshToken = "refreshToken";
  static const String userLoggedIn = "userLoggedIn";
  static const String deviceUUID = "deviceUUID";
  static const String userId = "userId";

  // Storing Key Values
  Future<String> getAuthToken() => getString(authToken);
  Future<void> saveAuthToken(String? token) => setString(authToken, token!);

  Future<String> getRefreshToken() => getString(refreshToken);
  Future<void> saveRefreshToken(String? token) =>
      setString(refreshToken, token!);

  Future<bool> getUserLoggedIn() => getBool(userLoggedIn);
  Future<void> saveUserLoggedIn(bool value) => setBool(userLoggedIn, value);

  Future<String> getDeviceUUID() async {
    return await getString(deviceUUID);
  }

  Future<void> saveDeviceUUID(String uuid) async {
    await setString(deviceUUID, uuid);
  }

  Future<void> saveUserId(String id) => setString(id, userId);
  Future<String> getUserId() => getString(userId);
}
