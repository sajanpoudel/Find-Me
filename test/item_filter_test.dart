import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/screens/home/item_filter.dart';

final items = [
  {
    'item_name': 'Black Wallet',
    'description': 'Leather, found near the library',
    'uploaded_by': 'Sam'
  },
  {
    'item_name': 'Keys',
    'description': 'Three keys on a red ring',
    'uploaded_by': 'Priya'
  },
  {
    'item_name': 'Umbrella',
    'description': 'Blue umbrella',
    'uploaded_by': 'Sam'
  },
];

void main() {
  test('an empty search keeps every item', () {
    expect(filterItems(items, ''), hasLength(3));
    expect(filterItems(items, '   '), hasLength(3));
  });

  test('the name is searched without caring about case', () {
    expect(filterItems(items, 'wallet').map((i) => i['item_name']),
        ['Black Wallet']);
  });

  test('the description and the finder are searched too', () {
    expect(filterItems(items, 'library'), hasLength(1));
    expect(filterItems(items, 'sam').map((i) => i['item_name']),
        ['Black Wallet', 'Umbrella']);
  });

  test('items without a value for a field do not break the search', () {
    expect(
        filterItems([
          {'item_name': 'Cap'}
        ], 'cap'),
        hasLength(1));
    expect(
        filterItems([
          {'item_name': 'Cap'}
        ], 'red'),
        isEmpty);
  });
}
