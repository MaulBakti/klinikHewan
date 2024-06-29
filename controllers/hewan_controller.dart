import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HewanController extends GetxController {
  final count = 0.obs;
  var listData = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> addHewan(Map<String, dynamic> hewanData) async {
    const String apiUrl =
        'http://localhost:3000/api/hewan'; // Ganti dengan URL API Anda
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer your_jwt_token' // Ganti dengan token JWT yang valid
      },
      body: json.encode({'action': 'create', 'data': hewanData}),
    );

    if (response.statusCode == 200) {
      // Berhasil menambahkan data
      final responseData = json.decode(response.body);
      listData.add(responseData['data']);
      print('Hewan berhasil ditambahkan: ${responseData['data']}');
    } else {
      // Gagal menambahkan data
      final errorData = json.decode(response.body);
      throw Exception('Failed to add hewan: ${errorData['message']}');
    }
  }
}
