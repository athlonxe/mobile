class RequestLog {
  const RequestLog({
    required this.method,
    required this.endpoint,
    required this.statusCode,
    required this.timeLabel,
  });

  final String method;
  final String endpoint;
  final int statusCode;
  final String timeLabel;

  bool get isSuccess => statusCode < 400;
}
