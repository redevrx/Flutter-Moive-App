class MoiveException implements Exception {
  final String message;
  MoiveException({required this.message});

  @override
  String toString() => message;
}
