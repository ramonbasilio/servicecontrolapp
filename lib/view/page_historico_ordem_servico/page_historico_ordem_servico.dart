import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:servicecontrolapp/controller/Repository/repository_client.dart';
import 'package:servicecontrolapp/model/model_os.dart';
import 'package:servicecontrolapp/view/alerts/confirmation_dialog.dart';
import 'package:servicecontrolapp/view/page_historico_ordem_servico/page_detail_hist_ordem_service.dart';

class PageHistoricoOrdemServico extends StatelessWidget {
  const PageHistoricoOrdemServico({super.key});

  @override
  Widget build(BuildContext context) {
    Repository().repositoryClientProvider(context).loadFirebase();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('Histórico de Ordens de serviço'),
      ),
      body: Consumer<Repository>(builder: (context, value, child) {
        if (value.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<OrdemServicoModel> ordemServico = value.listOrdemService;
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
                  itemCount: ordemServico.length,
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
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      ConfirmationDialog.dialogiBuilder(
                                          context: context,
                                          id: ordemServico[index]
                                              .idOrdemServico,
                                          titulo: 'Deletar Ordem de Serviço',
                                          conteudo:
                                              'Você deseja remover essa ordem de serviço?',
                                          colecao: 'Ordem_de_servico');
                                      Repository()
                                          .repositoryClientProvider(context)
                                          .loadFirebase();
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Apagar',
                                  ),
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PageDetailHistOrdemService(
                                                ordemServico:
                                                    ordemServico[index]),
                                      ));
                                },
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'OS: ${ordemServico[index].idOrdemServico}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(ordemServico[index].dataAtendimento),
                                  ],
                                ),
                                title: Text(
                                  ordemServico[index].resumoAtendimento,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  ordemServico[index].cliente.razaoSocial,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
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
