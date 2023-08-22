class EntityNotFoundException implements Exception {
  final String message;
  EntityNotFoundException(this.message);
  @override
  String toString() => message;
}
