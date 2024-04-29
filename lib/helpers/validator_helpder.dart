class TextLengthValidator {
  final String? emptyMessage;
  final int? minLength;
  final int? maxLength;
  final String? minMessage;
  final String? maxMessage;

  const TextLengthValidator({
    this.emptyMessage,
    this.minLength,
    this.maxLength,
    this.minMessage,
    this.maxMessage,
  });

  String? validate(String? text) {
    if (text?.isEmpty == true) return emptyMessage;
    if (minLength != null && text!.length < minLength!) return minMessage;
    if (maxLength != null && text!.length > maxLength!) return maxMessage;
    return null;
  }
}
