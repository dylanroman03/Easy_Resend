import 'dart:typed_data';

class Attachment {
  Attachment({
    required this.filename,
    required this.content,
  });

  final String filename;
  final Uint8List content;

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'content': content,
    };
  }
}
