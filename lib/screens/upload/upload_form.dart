/// The names of the upload fields that are still empty, in the order of the form.
List<String> missingUploadFields({
  String? title,
  String? uploader,
  String? contact,
  String? description,
}) {
  final fields = {
    'Item Name': title,
    'Found By': uploader,
    'Contact Info': contact,
    'Item Description': description,
  };
  return [
    for (final entry in fields.entries)
      if ((entry.value ?? '').trim().isEmpty) entry.key,
  ];
}
