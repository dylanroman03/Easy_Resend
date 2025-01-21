import 'package:easy_resend/src/models/attachment.dart';
import 'package:easy_resend/src/models/email.dart';
import 'package:easy_resend/src/models/email_to_batch.dart';
import 'package:easy_resend/src/service/easy_resend_email.dart';

/// A class for sending emails by Resend.
class EasyResend {
  /// Private constructor for creating an instance of EasyResend.
  EasyResend._(this._apiKey);
  final String _apiKey;
  static EasyResend? _instance;

  /// Initializes the EasyResend singleton instance with the provided API key.
  ///
  /// Throws an exception if the instance has already been initialized.
  static void initialize(apiKey) {
    if (_instance != null) {
      throw Exception('The instance can only be initialized once');
    } else {
      _instance = EasyResend._(apiKey);
    }
  }

  /// Retrieves the singleton instance of EasyResend.
  ///
  /// Throws an exception if the instance has not been initialized.
  static EasyResend getInstance() {
    if (_instance != null) {
      return _instance!;
    }

    throw Exception('Instance not initialized');
  }

  /// Sends an email using the Easy Resend API.
  ///
  /// Required parameters:
  /// - [from]: The email address of the sender.
  /// - [to]: List of email addresses of the recipients.
  /// - [subject]: Subject of the email.
  ///
  /// Optional parameters:
  /// - [text]: Plain text content of the email.
  /// - [attachments]: List of attachments to include in the email.
  /// - [bcc]: List of email addresses to send a blind carbon copy (BCC).
  /// - [cc]: List of email addresses to send a carbon copy (CC).
  /// - [html]: HTML content of the email (if provided, it will be used instead of [text]).
  ///
  /// Returns the ID of the sent email if successful.
  ///
  /// Throws an exception if an error occurs during the email sending process.
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
    Email email = Email.fromMap({
      'from': from,
      'to': to,
      'subject': subject,
      'text': text,
      if (attachments.isNotEmpty) 'attachments': attachments,
      if (bcc.isNotEmpty) 'bcc': bcc,
      if (cc.isNotEmpty) 'cc': cc,
      if (html != null) 'html': html,
    });

    return await EasyResendEmail(apiKey: _apiKey).sendEmail(email);
  }

  Future<Email> retriveEmail(String id) async {
    return await EasyResendEmail(apiKey: _apiKey).retriveEmail(id);
  }

  Future<List<String>> sendBatch(List<EmailToBach> emails) async {
    return await EasyResendEmail(apiKey: _apiKey).sendBatch(emails);
  }
}
