import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  final GetStorage _storage = GetStorage();

  // Simpan token
  void saveToken(String token) {
    _storage.write('token', token);
  }

  // Mengambil token dari penyimpanan lokal
  String? getToken() {
    return _storage.read('token') as String?;
  }

  // Menghapus token dari penyimpanan lokal
  void removeToken() {
    _storage.remove('token');
  }
}
