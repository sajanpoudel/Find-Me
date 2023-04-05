import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/screens/upload/upload_form.dart';

void main() {
  test('every empty field is reported in form order', () {
    expect(missingUploadFields(), ['Item Name', 'Found By', 'Contact Info', 'Item Description']);
  });

  test('blank text counts as missing', () {
    expect(
      missingUploadFields(title: 'Wallet', uploader: '  ', contact: '555', description: ''),
      ['Found By', 'Item Description'],
    );
  });

  test('a complete form has nothing missing', () {
    expect(
      missingUploadFields(title: 'Wallet', uploader: 'Sam', contact: '555', description: 'Brown leather'),
      isEmpty,
    );
  });
}
