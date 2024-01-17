import '../html.dart';
import 'channel.dart';

SseChannel connect(Uri url) => HtmlSseChannel.connect(url);
