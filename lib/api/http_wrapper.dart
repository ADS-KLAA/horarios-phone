import "package:http/http.dart" as http;
import "api.dart";

class HttpWrapper {
  static Future<http.Response> post(
      String url, Map<String, String> body) async {
    return http.post(Uri.parse("$apiUrl$url"), body: body);
  }

  static Future<http.Response> get(String url) async {
    return http.get(Uri.parse("$apiUrl$url"));
  }
}
