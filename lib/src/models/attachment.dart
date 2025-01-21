// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class Attachment {
  Attachment({
    required this.filename,
    required this.content,
  });

  final String filename;
  final Uint8List content;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filename': filename,
      'content': content,
    };
  }

  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
      filename: map['filename'] as String,
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachment.fromJson(String source) =>
      Attachment.fromMap(json.decode(source) as Map<String, dynamic>);
}
