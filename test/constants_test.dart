import 'package:flutter_test/flutter_test.dart';

import 'package:mobileapp/constants.dart';

void main() {
  group('emailValidatorRegExp', () {
    test('accepts common addresses', () {
      expect(emailValidatorRegExp.hasMatch('finder@example.com'), isTrue);
      expect(emailValidatorRegExp.hasMatch('first.last@mail.org'), isTrue);
    });

    test('rejects text without an at sign or a domain', () {
      expect(emailValidatorRegExp.hasMatch('finder.example.com'), isFalse);
      expect(emailValidatorRegExp.hasMatch('finder@example'), isFalse);
      expect(emailValidatorRegExp.hasMatch(''), isFalse);
    });
  });

  test('form error messages are not empty', () {
    for (final message in [
      kEmailNullError,
      kInvalidEmailError,
      kPassNullError,
      kShortPassError,
      kMatchPassError,
      kNameNullError,
      kPhoneNumberNullError,
      kAddressNullError,
    ]) {
      expect(message, isNotEmpty);
    }
  });
}
