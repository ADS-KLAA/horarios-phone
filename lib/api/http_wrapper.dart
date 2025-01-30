import "dart:convert";

import "package:http/http.dart" as http;

String? authenticationToken;
Map<String, String> _defaultHeaders = {
  "Content-Type": "application/json",
  "Accept": "application/json",
};

class HttpWrapper {
  static Future<http.Response> post(
      String url, Map<String, String> body) async {
    return http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": authenticationToken != null ? "Bearer $authenticationToken" : "",
      },
      body: json.encode(body),
    );
  }

  static Future<http.Response> get(String url) async {
    Map<String, String> authorizationHeaders = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    return http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": authenticationToken != null ? "Bearer $authenticationToken" : "",
    });
  }
}
