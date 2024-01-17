import 'dart:io';

import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';

Future<void> main(List<String> arguments) async {
  final connection = HubConnectionBuilder()
      .withUrl(
        'https://cronytmstest.azurewebsites.net/connect?token=44e4e105-ff7c-4800-b0d4-a1da95272789',
        HttpConnectionOptions(
          client: IOClient(
            HttpClient()..badCertificateCallback = (x, y, z) => true,
          ),
          logging: (level, message) => print(message),
        ),
      )
      .build();

  await connection.start();

  connection.on('ReceiveMessage', (message) {
    print(message.toString());
  });

  await connection.invoke('SendMessage', args: ['Bob', 'Says hi!']);
}
