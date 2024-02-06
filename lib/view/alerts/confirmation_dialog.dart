import 'package:flutter/material.dart';
import 'package:servicecontrolapp/view/page_inicial.dart';
import 'package:servicecontrolapp/view/pages_client/page_client.dart';

import '../../controller/Repository/repository_client.dart';

class ConfirmationDialog {
  static Future<void> dialogiBuilder({
    required BuildContext context,
    required String id,
    required String titulo,
    required String conteudo,
    required String colecao,
  }) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(conteudo),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCELAR'),
              ),
              TextButton(
                onPressed: () {
                  Repository().deleteData(colecao, id).then((value) {
                    Repository()
                        .repositoryClientProvider(context)
                        .loadFirebase();
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
