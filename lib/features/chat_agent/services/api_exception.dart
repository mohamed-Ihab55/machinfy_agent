enum OpenAIErrorType {
  invalidApiKey,
  rateLimitExceeded,
  insufficientQuota,
  badRequest,
  serverError,
  timeout,
  networkError,
  emptyResponse,
  unknown,
}

class OpenAIException implements Exception {
  final String message;
  final OpenAIErrorType type;
  final int? statusCode;

  OpenAIException({
    required this.message,
    required this.type,
    this.statusCode,
  });

  @override
  String toString() => message;

  String get userMessage {
    switch (type) {
      case OpenAIErrorType.invalidApiKey:
        return 'Invalid API key. Please check your configuration.';
      case OpenAIErrorType.rateLimitExceeded:
        return 'Too many requests. Please wait a moment and try again.';
      case OpenAIErrorType.insufficientQuota:
        return 'API quota exceeded. Please contact support.';
      case OpenAIErrorType.timeout:
        return 'Request timed out. Please check your connection and try again.';
      case OpenAIErrorType.networkError:
        return 'Network error. Please check your internet connection.';
      case OpenAIErrorType.serverError:
        return 'Service temporarily unavailable. Please try again later.';
      default:
        return message;
    }
  }

  // Check if error is retryable
  bool get isRetryable {
    return type == OpenAIErrorType.timeout ||
        type == OpenAIErrorType.networkError ||
        type == OpenAIErrorType.serverError;
  }
}



