import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../controller/Repository/repository_client.dart';
import '../model/model_client.dart';
import '../view/alerts/confirmation_dialog.dart';

class WidgetDetailClient {
  static Future<void> showDetailClient(
    BuildContext context,
    ClienteModel client,
  ) async {
    showModalBottomSheet(

        context: context,
        builder: (BuildContext _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: SizedBox(
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'DADOS DOS CLIENTE',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'HOSPITAL / CLIENTE',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Text(
                        client.razaoSocial,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Divider(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'ENDEREÇO',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Text(
                        '${client.endereco}, nº ${client.numero} \nBairro: ${client.bairro}, \nCidade: ${client.cidade} \nEstado: ${client.estado} \nCEP: ${client.cep}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Divider(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'CONTATO',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Text(
                        'Nome: ${client.responsavel['Nome']} \nTelefone: ${client.responsavel['Telefone']} \nE-mail: ${client.responsavel['E-mail']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Divider(),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700),
                          onPressed: () async {
                            Navigator.pop(context);
                            ConfirmationDialog.dialogiBuilder(
                                context, client.id);
                            //Navigator.pop(context);

                            // RepositoryClient()
                            //     .deleteClient(client.id)
                            //     .then((value) {
                            //   RepositoryClient()
                            //       .repositoryClientProvider(context)
                            //       .loadClients();
                            // }).then((value) => Navigator.pop(context));
                          },
                          child: const Text('Apagar contato'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Editar contato'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
