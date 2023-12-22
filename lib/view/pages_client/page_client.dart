import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicecontrolapp/view/pages_client/page_register_client.dart';

import '../../controller/Repository/repository_client.dart';
import '../../model/model_client.dart';
import '../../widgets/widget_detail_client.dart';

class PageClient extends StatelessWidget {
  const PageClient({super.key});

  @override
  Widget build(BuildContext context) {
    RepositoryClient().repositoryClientProvider(context).loadClients();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Cadastro Clientes'),
      ),
      body: Consumer<RepositoryClient>(builder: (context, value, child) {
        if (value.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<ClienteModel> clients = value.listClients;
          return value.listClients.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(child: Text('Nenhum cliente cadastrado', style: TextStyle(fontSize: 20),)),
                  ],
                )
              : ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: ListTile(
                              onTap: () async {
                                await WidgetDetailClient.showDetailClient(
                                  context,
                                  clients[index],
                                );
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade800,
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(clients[index].razaoSocial),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
        }
      }),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PageRegisterClient(),
            ),
          );
        },
      ),
    );
  }
}
