// lib/services/local_storage_service.dart
import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  final GetStorage _storage = GetStorage();

  void saveToken(String token) {
    _storage.write('token', token);
  }

  String? getToken() {
    return _storage.read('token');
  }

  // Menghapus token
  void removeToken() {
    _storage.remove('token');
  }
}
