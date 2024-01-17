import '../io.dart';
import 'channel.dart';

SseChannel connect(Uri url) => IOSseChannel.connect(url);
