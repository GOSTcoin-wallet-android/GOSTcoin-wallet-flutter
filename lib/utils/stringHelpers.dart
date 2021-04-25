String removeUnicodes(String value) {
  return value.replaceAll(new RegExp(r"[^\s\w]"), '');
}
