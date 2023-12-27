import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicecontrolapp/controller/Repository/repository_client.dart';
import '../../model/model_client.dart';

class PageSearchClient extends StatelessWidget {
  const PageSearchClient({super.key});

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RepositoryClient>(context, listen: false);
    TextEditingController pesquisaController = TextEditingController();
    RepositoryClient().repositoryClientProvider(context).loadClients();
    List<ClienteModel> clients = _provider.listClients;
    List<ClienteModel> retorno = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar cliente'),
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: pesquisaController,
                onChanged: (value) {
                  retorno =
                      _provider.fitraClient(value, clients);
                  retorno.forEach((element) {
                    print('Retorno: ${element.razaoSocial}');
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Cliente",
                  hintText: "Cliente",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
              const Divider(),
              Consumer<RepositoryClient>(builder: (context, _, child) {
                if (_provider.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  // clients = value.listClients;
                  return _provider.listClients.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Center(
                              child: Text(
                                'Nenhum cliente cadastrado',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: _provider.listClients.length,
                            itemBuilder: (context, index) {
                              // 'tamanho da pesquisa: ${_provider.listClients.length}');
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
                                        onTap: () {
                                          clients.forEach(
                                            (element) {
                                              print(element);
                                            },
                                          );
                                          RepositoryClient()
                                              .repositoryClientProvider(context)
                                              .loadClients();
                                          print('index: $index');

                                          Navigator.pop(
                                              context,
                                              pesquisaController.text.isEmpty
                                                  ? clients[index]
                                                  : retorno[index]);
                                        },
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.grey.shade800,
                                          child: Text(
                                            '${index + 1}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        title: Text(_provider
                                            .listClients[index].razaoSocial),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
