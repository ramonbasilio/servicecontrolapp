import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicecontrolapp/controller/Firebase/firebase_service.dart';
import 'package:servicecontrolapp/helper/helper_http.dart';
import 'package:servicecontrolapp/view/page_historico_ordem_servico/page_historico_ordem_servico.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/page_ordem_servico.dart';
import 'package:servicecontrolapp/view/pages_client/page_client.dart';
import '../controller/Repository/repository_client.dart';
import '../widgets/widget_card_page_inicial.dart';

class PageInicial extends StatelessWidget {
  const PageInicial({super.key});

  @override
  Widget build(BuildContext context) {
    Repository().repositoryClientProvider(context).loadFirebase();

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Full Medcare App'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 500,
                  child: GridView.count(crossAxisCount: 2, children: [
                    WidgetCardPageInicial(
                      nome: 'Clientes',
                      rota: const PageClient(),
                    ),
                    WidgetCardPageInicial(
                      nome: 'Ordem de Serviço',
                      rota: PageOrdemDeServico(),
                    ),
                    WidgetCardPageInicial(
                      nome: 'Historico',
                      rota: const PageHistoricoOrdemServico(),
                    ),
                    WidgetCardPageInicial(
                      nome: 'Inventário',
                    ),
                  ])),
            ],
          ),
        ));
  }
}
