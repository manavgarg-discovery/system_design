/*
Builder Pattern Implementation in Dart
Example: HTTP Request Builder

Problem without builder: a constructor with many optional parameters becomes
unreadable and error-prone — positional args in the wrong order are silent bugs.

  HttpRequest('GET', 'https://api.example.com', null, null, {'Auth': 'Bearer ...'}, true, 30)

Builder makes construction readable, stepwise, and validates only at build time.

NOTE: Builder pattern is not very popular in Dart due to named parameters and default values, which already solve many of the issues builders address in languages like Java. However, it can still be useful for complex objects with many optional parameters or when you want to enforce a specific construction process.
*/

class HttpRequest {
  final String method;
  final String url;
  final Map<String, String> headers;
  final Map<String, String> queryParams;
  final Object? body;
  final int timeoutSeconds;
  final bool followRedirects;

  HttpRequest._({
    required this.method,
    required this.url,
    required this.headers,
    required this.queryParams,
    this.body,
    required this.timeoutSeconds,
    required this.followRedirects,
  });

  @override
  String toString() =>
      '''
HttpRequest {
  method: $method
  url: $url${queryParams.isNotEmpty ? '?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}' : ''}
  headers: $headers
  body: $body
  timeout: ${timeoutSeconds}s
  followRedirects: $followRedirects
}''';
}

class HttpRequestBuilder {
  String? _method;
  String? _url;
  final Map<String, String> _headers = {};
  final Map<String, String> _queryParams = {};
  Object? _body;
  int _timeoutSeconds = 30;
  bool _followRedirects = true;

  HttpRequestBuilder method(String method) {
    _method = method;
    return this;
  }

  HttpRequestBuilder url(String url) {
    _url = url;
    return this;
  }

  HttpRequestBuilder header(String key, String value) {
    _headers[key] = value;
    return this;
  }

  HttpRequestBuilder queryParam(String key, String value) {
    _queryParams[key] = value;
    return this;
  }

  HttpRequestBuilder body(Object body) {
    _body = body;
    return this;
  }

  HttpRequestBuilder timeout(int seconds) {
    _timeoutSeconds = seconds;
    return this;
  }

  HttpRequestBuilder noRedirects() {
    _followRedirects = false;
    return this;
  }

  HttpRequest build() {
    if (_method == null) throw StateError('method is required');
    if (_url == null) throw StateError('url is required');

    return HttpRequest._(
      method: _method!,
      url: _url!,
      headers: Map.unmodifiable(_headers),
      queryParams: Map.unmodifiable(_queryParams),
      body: _body,
      timeoutSeconds: _timeoutSeconds,
      followRedirects: _followRedirects,
    );
  }
}

void main() {
  final getRequest = HttpRequestBuilder()
      .method('GET')
      .url('https://api.example.com/users')
      .header('Authorization', 'Bearer token123')
      .queryParam('page', '1')
      .queryParam('limit', '20')
      .timeout(10)
      .build();

  print(getRequest);

  final postRequest = HttpRequestBuilder()
      .method('POST')
      .url('https://api.example.com/users')
      .header('Authorization', 'Bearer token123')
      .header('Content-Type', 'application/json')
      .body({'name': 'Alice', 'email': 'alice@example.com'})
      .noRedirects()
      .build();

  print(postRequest);
}
