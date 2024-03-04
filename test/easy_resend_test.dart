import 'package:easy_resend/src/easy_resend_base.dart';
import 'package:test/test.dart';

void main() {
  group('A group of test', () {
    setUp(() {
      EasyResend.initialize('your_api_key_here');
    });

    test('Without Attachment', () async {
      EasyResend easyResend = EasyResend.getInstance();

      String id = await easyResend.sendEmail(
        from: 'onboarding@resend.dev',
        to: ['username@mail.com'],
        subject: 'Test Package',
        text: 'There you go!',
      );

      print(id);
    });
  });
}
