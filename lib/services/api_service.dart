import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // For local testing on Android Emulator, use 10.0.2.2 instead of 127.0.0.1
  // For real physical phones connected via Wi-Fi, use your PC's local IP (e.g., http://192.168.1.X:8000)
  static const String baseUrl = 'http://10.0.2.2:8000';

  static Future<Map<String, dynamic>> scanPrescription(String imagePath) async {
    try {
      var uri = Uri.parse('$baseUrl/scan-prescription');
      var request = http.MultipartRequest('POST', uri);

      // Attach the image captured by the camera
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Could not connect to backend server: $e'
      };
    }
  }
}