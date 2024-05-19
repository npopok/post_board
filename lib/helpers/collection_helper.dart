extension ListExtension<T> on List<T> {
  List<T> exclude(T value) {
    var list = toList();
    list.removeWhere((e) => e == value);
    return list;
  }
}
