// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_resend/src/models/attachment.dart';

class Email {
  Email({
    required this.from,
    required this.to,
    required this.subject,
    this.text = '',
    this.attachments = const [],
    this.bcc = const [],
    this.cc = const [],
    this.html,
  });
  final String from;
  final List<String> to;
  final String subject;
  final String text;
  final List<Attachment> attachments;
  final List<String> bcc;
  final List<String> cc;
  final String? html;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'subject': subject,
      'text': text,
      'attachments': attachments.map((x) => x.toMap()).toList(),
      'bcc': bcc,
      'cc': cc,
      'html': html,
    };
  }

  factory Email.fromMap(Map<String, dynamic> map) {
    return Email(
      from: map['from'] as String,
      to: [...map['to']],
      subject: map['subject'] as String,
      text: map['text'] as String,
      attachments: List<Attachment>.from(
        (map['attachments'] ?? []).map<Attachment>(
          (x) => Attachment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      bcc: List<String>.from(map['bcc'] ?? []),
      cc: List<String>.from(map['cc'] ?? []),
      html: map['html'] != null ? map['html'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Email.fromJson(String source) =>
      Email.fromMap(json.decode(source) as Map<String, dynamic>);
}
