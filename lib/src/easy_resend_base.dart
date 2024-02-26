import 'dart:convert';

import 'package:easy_resend/src/constants.dart';
import 'package:easy_resend/src/models/attachment.dart';
import 'package:easy_resend/src/models/errorResponse.dart';
import 'package:http/http.dart' as http;

class EasyResend {
  // Private constructor
  EasyResend._(this._apiKey);

  final String _apiKey;
  static EasyResend? _instance;

  static void initialize(apiKey) {
    if (_instance != null) {
      throw Exception('The instance can only be initialized once');
    } else {
      _instance = EasyResend._(apiKey);
    }
  }

  // Singleton instance retrieval method
  static EasyResend getInstance() {
    if (_instance != null) {
      return _instance!;
    }

    throw Exception('Instance not initialized');
  }

  Future<String> sendEmail({
    required String from,
    required List<String> to,
    required String subject,
    String text = '',
    List<Attachment> attachments = const [],
    List<String> bcc = const [],
    List<String> cc = const [],
    String? html,
  }) async {
    Map<String, dynamic> body = {
      'from': from,
      'to': to,
      'subject': subject,
      'text': text,
      if (attachments.isNotEmpty) 'attachments': attachments,
      if (bcc.isNotEmpty) 'bcc': bcc,
      if (cc.isNotEmpty) 'cc': cc,
      if (html != null) 'html': html,
    };

    final http.Response response = await http.post(
      Uri.parse(urlEmails),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      Map<String, String> body = response.body as Map<String, String>;
      return body['id']!;
    } else {
      final error = ErrorResponse.fromMap(jsonDecode(response.body));
      throw error.returnMessage();
    }
  }
}
