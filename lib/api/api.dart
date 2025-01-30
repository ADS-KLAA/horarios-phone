import 'dart:async';
import 'dart:convert';
import 'package:horarios_phone/api/http_wrapper.dart';
import 'package:horarios_phone/models/models.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

const String apiUrl = "http://localhost:8080";
const retryLimit = 3;

class Api {
  final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  int attempts = 0;

  Future<Map<String, dynamic>> apiPost(url, requestBody, errorMessage) async {
    Response response = await HttpWrapper.post(url, requestBody);
    _logger.i("Response string from $url: ${response.body}");
    Map<String, dynamic>? responseBody = json.decode(response.body);
    if (response.statusCode == 200 && responseBody != null) {
      attempts = 0;
      return responseBody;
    } else if (attempts > retryLimit) {
      _logger.e(
          "$errorMessage; body: ${response.body}, trying again, attempt number $attempts");
      attempts++;
      return apiPost(url, requestBody, errorMessage);
    } else {
      return {"Error": errorMessage};
    }
  }

  // API MEHTODS

  Future<Map<String, dynamic>> registerAluno(
      String username, String email, String password, String turma) async {
    Map<String, String> requestBody = {
      "username": username,
      "email": email,
      "password": password,
      "turma": turma,
    };
    Map<String, dynamic> response = await apiPost(
        "$apiUrl/auth/register/aluno", requestBody, "Failed to register aluno");
    if (!response.containsKey("Error")) {
      _logger.i("Assigned authentication token: ${response["token"]}");
      _logger.i("Successfully registered aluno");
      authenticationToken = response["token"]!;
    } else {
      _logger.e("Failed to register aluno");
    }
    return response;
  }

  Future<Map<String, dynamic>> loginAluno(String email, String password) async {
    Map<String, String> requestBody = {
      "email": email,
      "password": password,
    };
    Map<String, dynamic> response = await apiPost(
        "$apiUrl/auth/login/aluno", requestBody, "Failed to register aluno");
    if (!response.containsKey("Error")) {
      _logger.i("Assigned authentication token: ${response["token"]}");
      _logger.i("Successfully logged in aluno");
      authenticationToken = response["token"]!;
    } else {
      _logger.e("Failed to log in aluno");
    }
    return response;
  }

  Future<List<Aula>> getAulas() async {
    if (authenticationToken == null) {
      _logger.e("Failed to get aulas; no authentication token");
      return [];
    }
    Response response = await HttpWrapper.get("$apiUrl/aluno/aulas");
    Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode == 200 && responseBody.containsKey("aulas")) {
      List<dynamic> responseAulas = responseBody["aulas"];
      List<Aula> aulas = responseAulas
          .map((aulaMap) => Aula.fromJson(aulaMap))
          .toList();
      _logger.i("Successfully got aulas");
      return aulas;
    } else {
      _logger.e("Failed to get aulas; body: ${response.body}");
      return [];
    }
  }

  Future<Map<String, String>> getNameAndEmail() async {
    if (authenticationToken == null) {
      _logger.e("Failed to get name and email; no authentication token");
      return {"Error": "Failed to get name and email; no authentication token"};
    }
    Response response = await HttpWrapper.get("$apiUrl/aluno/session/info");
    Map<String, String> responseBody = json.decode(response.body);
    if (response.statusCode == 200 &&
        responseBody.containsKey("name") &&
        responseBody.containsKey("email")) {
      _logger.i("Successfully got name and email: $responseBody");
      return responseBody;
    } else {
      _logger.e("Failed to get name and email; body: ${response.body}");
      return {"Error": "Failed to get name and email"};
    }
  }

  Future<bool> confirmPresence(String aulaId) async {
    if (authenticationToken == null) {
      _logger.e("Failed to confirm presence; no authentication token");
      return false;
    }
    Response response =
        await HttpWrapper.get("$apiUrl/aluno/confirmar/$aulaId");
    if (response.statusCode == 200) {
      _logger.i("Successfully confirmed presence");
      return true;
    } else {
      _logger.e("Failed to confirm presence; body: ${response.body}");
      return false;
    }
  }
}
