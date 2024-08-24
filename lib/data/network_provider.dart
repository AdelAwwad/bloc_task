import 'package:http/http.dart' as https;
class NetworkProvider {
  static Future<https.Response> getRequest(String url, [Map<String, String>? headers]) async {
    try {
      final response = await https.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return response;
      } else {
        print('Error: ${response.statusCode}'); // Add error logging
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e'); // Add error logging
      rethrow;
    }
  }
}