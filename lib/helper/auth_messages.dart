/// A message for the user that matches a FirebaseAuthException code.
String authErrorMessage(String code) {
  switch (code) {
    case 'invalid-email':
      return 'That email address does not look right.';
    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
      return 'The email or the password is wrong.';
    case 'user-disabled':
      return 'This account has been disabled.';
    case 'email-already-in-use':
      return 'An account with this email already exists.';
    case 'weak-password':
      return 'Choose a stronger password.';
    case 'network-request-failed':
      return 'No connection. Check your internet and try again.';
    case 'too-many-requests':
      return 'Too many attempts. Try again in a few minutes.';
    default:
      return 'Something went wrong. Please try again.';
  }
}
