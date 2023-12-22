import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/page_search_client.dart';

import '../../model/model_client.dart';

class PageOrdemDeServico extends StatefulWidget {
  const PageOrdemDeServico({super.key});

  @override
  State<PageOrdemDeServico> createState() => _PageOrdemDeServicoState();
}

class _PageOrdemDeServicoState extends State<PageOrdemDeServico> {
  late ClienteModel cliente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
               ClienteModel cliente = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageSearchClient()
                  )
                );
                if (!mounted) return;
                setState(() {
                  
                });
                print(cliente.razaoSocial);
              },
              child: const Text('Cliente'),

            ),
          ],
        ),
      ),
    );
  }
}
