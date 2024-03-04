import 'dart:typed_data';

import 'package:easy_resend/easy_resend.dart';

void main() async {
  // Initialize EasyResend with your API key
  EasyResend.initialize('your_api_key_here');

  // Create an instance of EasyResend
  final easyResend = EasyResend.getInstance();

  // Prepare email data
  final from = 'sender@example.com';
  final to = ['recipient1@example.com', 'recipient2@example.com'];
  final subject = 'Test Email';
  final text = 'This is a test email sent using Easy Resend.';
  final attachments = [
    Attachment(filename: 'invoice.pdf', content: Uint8List.fromList([])),
    Attachment(filename: 'image.jpg', content: Uint8List.fromList([])),
  ];

  try {
    // Send the email
    final id = await easyResend.sendEmail(
      from: from,
      to: to,
      subject: subject,
      text: text,
      attachments: attachments,
    );

    print('Email sent successfully! ID: $id');
  } catch (e) {
    print('Failed to send email: $e');
  }
}
