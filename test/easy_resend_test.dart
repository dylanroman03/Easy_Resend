import 'dart:developer';

import 'package:easy_resend/src/easy_resend_base.dart';
import 'package:test/test.dart';

void main() {
  group('A group of test', () {
    setUp(() {
      EasyResend.initialize('re_9CT38ccy_NFfrVemifkCHUNLpMFWjqzHM');
    });

    test('Without Attachment', () async {
      EasyResend easyResend = EasyResend.getInstance();

      String id = await easyResend.sendEmail(
        from: 'Info <info@enviarmasivo.com>',
        to: ['romand.buitrago@gmail.com'],
        subject: 'Test Package',
        text: 'There you go!',
      );

      log(id);
    });
  });
}
