import 'package:flutter/material.dart';
import 'package:servicecontrolapp/view/page_inicial.dart';
import 'package:servicecontrolapp/view/pages_client/page_client.dart';

import '../../controller/Repository/repository_client.dart';

class ConfirmationDialog {
  static Future<void> dialogiBuilder(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Deletar cliente'),
            content: const Text('Você realmente deseja remover esse cliente'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCELAR'),
              ),
              TextButton(
                onPressed: () {
                  RepositoryClient().deleteClient(id).then((value) {
                    RepositoryClient()
                        .repositoryClientProvider(context)
                        .loadClients();
                  }).then((_) {
                    Navigator.of(context, rootNavigator: true).pop();
                  });
                },
                child: const Text('SIM'),
              ),
            ],
          );
        });
  }
}
