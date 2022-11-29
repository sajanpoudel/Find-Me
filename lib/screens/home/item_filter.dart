/// True when [query] appears in the name, the description or the finder of an item, ignoring case.
bool itemMatches(Map<String, dynamic> item, String query) {
  final text = query.trim().toLowerCase();
  if (text.isEmpty) return true;
  return ['item_name', 'description', 'uploaded_by'].any(
    (key) => (item[key] as String? ?? '').toLowerCase().contains(text),
  );
}

/// The items that match [query], in their original order.
List<Map<String, dynamic>> filterItems(
    List<Map<String, dynamic>> items, String query) {
  return items.where((item) => itemMatches(item, query)).toList();
}
