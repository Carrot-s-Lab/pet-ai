//
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// import 'keys.dart';
//
// class AppSecureStorage {
//   AppSecureStorage() {
//     AndroidOptions getAndroidOptions() => const AndroidOptions(
//       encryptedSharedPreferences: true,
//     );
//     _storage = FlutterSecureStorage(aOptions: getAndroidOptions());
//   }
//
//   late FlutterSecureStorage _storage;
//
//   Future<void> saveToken(String? token) async {
//     await _storage.write(key: SecureStorageKeys.token, value: token);
//   }
//
//   Future<String?> getToken() async {
//     return await _storage.read(key: SecureStorageKeys.token);
//   }
//
//   Future<void> removeToken() async {
//     return await _storage.delete(key: SecureStorageKeys.token);
//   }
//
//   Future<void> saveTokenExpires(int? expires) async {
//     await _storage.write(key: SecureStorageKeys.tokenExpiresAt, value: expires.toString());
//   }
//
//   Future<int?> getTokenExpires() async {
//     try {
//       return int.parse(await _storage.read(key: SecureStorageKeys.tokenExpiresAt) ?? '');
//     } catch (e) {
//       return null;
//     }
//   }
//
//   Future<void> removeTokenExpires() async {
//     return await _storage.delete(key: SecureStorageKeys.tokenExpiresAt);
//   }
//
//   Future<void> saveRefreshToken(String? refreshToken) async {
//     await _storage.write(key: SecureStorageKeys.refreshToken, value: refreshToken);
//   }
//
//   Future<String?> getRefreshToken() async {
//     return await _storage.read(key: SecureStorageKeys.refreshToken);
//   }
//
//   Future<void> removeRefreshToken() async {
//     return await _storage.delete(key: SecureStorageKeys.refreshToken);
//   }
//
//   Future<void> saveRefreshTokenExpires(int? expires) async {
//     await _storage.write(key: SecureStorageKeys.refreshTokenExpiresAt, value: expires.toString());
//   }
//
//   Future<int?> getRefreshTokenExpires() async {
//     try {
//       return int.parse(await _storage.read(key: SecureStorageKeys.refreshTokenExpiresAt) ?? '');
//     } catch (e) {
//       return null;
//     }
//   }
//
//   Future<void> removeRefreshTokenExpires() async {
//     return await _storage.delete(key: SecureStorageKeys.refreshTokenExpiresAt);
//   }
//
//   // Future<void> saveUserInformation(UserModel? userModel) async {
//   //   await _storage.write(key: SecureStorageKeys.userInformation, value: json.encode(userModel?.toJson()));
//   // }
//   //
//   // Future<UserModel?> getUserInformation() async {
//   //   final jsonData = await _storage.read(key: SecureStorageKeys.userInformation);
//   //   if (jsonData != null) {
//   //     final data = json.decode(jsonData);
//   //     return UserModel.fromJson(data);
//   //   }
//   //   return null;
//   // }
//   //
//   // Future<void> removeUserInformation() async {
//   //   return await _storage.delete(key: SecureStorageKeys.userInformation);
//   // }
// }