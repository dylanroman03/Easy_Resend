// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:easy_resend/src/models/email.dart';
import 'package:easy_resend/src/models/email_to_batch.dart';
import 'package:easy_resend/src/models/error_response.dart';
import 'package:http/http.dart' as http;

class EasyResendEmail {
  final String apiKey;
  final String url = 'https://api.resend.com/emails';

  EasyResendEmail({
    required this.apiKey,
  });

  Future<String> sendEmail(Email email) async {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(email.toMap()),
    );

    if (response.statusCode == 200) {
      String body = response.body;

      Map<String, dynamic> bodyMap = jsonDecode(body);
      return bodyMap['id']!;
    } else {
      final error = ErrorResponse.fromMap(jsonDecode(response.body));
      throw error.returnMessage();
    }
  }

  Future<Email> retriveEmail(String id) async {
    final http.Response response = await http.get(
      Uri.parse(url + '/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      return Email.fromJson(response.body);
    } else {
      final error = ErrorResponse.fromMap(jsonDecode(response.body));
      throw error.returnMessage();
    }
  }

  Future<List<String>> sendBatch(List<EmailToBach> emails) async {
    log(json.encode(emails.map((e) => e.toMap()).toList()));

    final http.Response response = await http.post(
      Uri.parse(url + '/batch'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(emails.map((e) => e.toMap()).toList()),
    );

    if (response.statusCode == 200) {
      List<String> idList = [];
      String body = response.body;
      Map<String, dynamic> bodyMap = jsonDecode(body);

      for (var element in bodyMap['data']) {
        idList.add(element['id']);
      }

      return idList;
    } else {
      final error = ErrorResponse.fromMap(jsonDecode(response.body));
      throw error.returnMessage();
    }
  }
}
