import 'package:flutter/material.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/page_ordem_servico.dart';
import 'package:servicecontrolapp/view/pages_client/page_client.dart';
import '../widgets/widget_card_page_inicial.dart';

class PageInicial extends StatelessWidget {
  const PageInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Service Control 1.0'),
          ),
        ),
        body: GridView.count(crossAxisCount: 2, children: [
          WidgetCardPageInicial(
            nome: 'Clientes',
            rota: const PageClient(),
          ),
          WidgetCardPageInicial(
            nome: 'Ordem de Serviço',
            rota: const PageOrdemDeServico(),
          ),
          WidgetCardPageInicial(
            nome: 'Inventário',
          ),
          WidgetCardPageInicial(
            nome: 'Historico',
          )
        ]));
  }
}
