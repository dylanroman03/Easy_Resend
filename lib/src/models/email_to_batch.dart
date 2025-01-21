import 'dart:convert';

class EmailToBach {
  factory EmailToBach.fromMap(Map<String, dynamic> map) {
    return EmailToBach(
      from: map['from'] as String,
      to: [...map['to']],
      subject: map['subject'] as String,
      text: map['text'] as String,
      bcc: List<String>.from(map['bcc'] ?? []),
      cc: List<String>.from(map['cc'] ?? []),
      html: map['html'] != null ? map['html'] as String : null,
    );
  }

  factory EmailToBach.fromJson(String source) => EmailToBach.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  EmailToBach({
    required this.from,
    required this.to,
    required this.subject,
    this.text = '',
    this.bcc = const [],
    this.cc = const [],
    this.html,
  });
  final String from;
  final List<String> to;
  final String subject;
  final String text;
  final List<String> bcc;
  final List<String> cc;
  final String? html;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'subject': subject,
      'text': text,
      'bcc': bcc,
      'cc': cc,
      'html': html,
    };
  }

  String toJson() => json.encode(toMap());
}
