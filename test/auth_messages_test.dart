import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/helper/auth_messages.dart';

void main() {
  test('wrong credentials share one message', () {
    final message = authErrorMessage('wrong-password');
    expect(authErrorMessage('user-not-found'), message);
    expect(authErrorMessage('invalid-credential'), message);
  });

  test('known codes have their own message', () {
    expect(authErrorMessage('email-already-in-use'), contains('already exists'));
    expect(authErrorMessage('weak-password'), contains('stronger'));
  });

  test('unknown codes fall back to a general message', () {
    expect(authErrorMessage('something-new'), startsWith('Something went wrong'));
  });
}
