import 'dart:convert';
import 'dart:developer';
import 'dart:io';



import 'package:http/http.dart' as http;


class ApiService {
  static Future<List<String>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("https://api.openai.com/v1/models"),
        headers: {'Authorization': 'Bearer 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'},
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }

      List<String> modelIds = [];

      for (var value in jsonResponse["data"]) {
        modelIds.add(value["id"]);
      }

      return modelIds;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  static Future<String> sendMessage(
      {required String message, String modelId = 'text-davinci-003'}) async {
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/completions"),
        headers: {
          'Authorization': 'Bearer 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',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 300,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }

      if (jsonResponse["choices"].isNotEmpty) {
        return jsonResponse["choices"][0]["text"];
      } else {
        return "No response from the model.";
      }
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}