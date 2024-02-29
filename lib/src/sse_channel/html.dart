import 'dart:async';
import 'dart:html';

import 'src/channel.dart';

class HtmlSseChannel extends SseChannel {
  final Uri uri;
  final bool withCredentials;
  late EventSource eventSource;

  late StreamController<String?> _messageController;

  @override
  Stream<String?> get stream => _messageController.stream;

  final _errorController = StreamController<void>.broadcast();

  final _openController = StreamController<void>.broadcast();

  HtmlSseChannel.connect({
    required this.uri,
    this.withCredentials = false,
  }) {
    eventSource = EventSource(uri.toString(), withCredentials: withCredentials);

    _messageController = StreamController<String?>.broadcast(
      onCancel: close,
    );

    eventSource
      ..addEventListener('message', (Event message) {
        _messageController.add((message as MessageEvent).data as String?);
      })
      ..addEventListener('error', _errorController.add)
      ..addEventListener('open', _openController.add);
  }

  void close() {
    eventSource.close();
    _messageController.close();
    _errorController.close();
    _openController.close();
  }

  @override
  StreamSink get sink => _messageController.sink;
}
