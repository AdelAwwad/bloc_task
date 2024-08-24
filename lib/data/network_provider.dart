import 'package:http/http.dart' as https;

class NetworkProvider {
  static Future<https.Response> getRequest(String url , [Map? headers]) async {
    try {
      https.Response response = await https.get(Uri.parse(url), headers: {});




      return response;
    }catch (e){
      rethrow;
    }
  }
}