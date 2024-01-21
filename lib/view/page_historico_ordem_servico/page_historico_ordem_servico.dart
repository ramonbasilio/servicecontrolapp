import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicecontrolapp/controller/Repository/repository_client.dart';
import 'package:servicecontrolapp/model/model_os.dart';

class PageHistoricoOrdemServico extends StatelessWidget {
  const PageHistoricoOrdemServico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<Repository>(builder: (context, value, child) {
        if (value.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<OrdemServicoModel> clients = value.listOrdemService;
          return value.listClients.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      'Nenhuma ordem de serviço cadastrado',
                      style: TextStyle(fontSize: 20),
                    )),
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
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade800,
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(clients[index].resumoAtendimento),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
        }
      }),
    );
  }
}
