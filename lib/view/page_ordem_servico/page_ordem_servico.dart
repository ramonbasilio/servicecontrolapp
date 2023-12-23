import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/page_search_client.dart';

import '../../model/model_client.dart';

// ignore: must_be_immutable
class PageOrdemDeServico extends StatefulWidget {
  ClienteModel? clienteSelecionado;

  PageOrdemDeServico({super.key, this.clienteSelecionado});

  @override
  State<PageOrdemDeServico> createState() => _PageOrdemDeServicoState();
}

class _PageOrdemDeServicoState extends State<PageOrdemDeServico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar ordem de serviço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    widget.clienteSelecionado = null;
                    final ClienteModel? clienteSelecionado =
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PageSearchClient()));

                    if (clienteSelecionado != null) {
                      setState(() {
                        widget.clienteSelecionado = clienteSelecionado;
                      });
                    }
                  },
                  child: const Text('Cliente'),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        widget.clienteSelecionado = null;
                      });
                    },
                    child: const Text('Limpar'))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                    border: Border.all(), color: Colors.grey.shade200),
                child: widget.clienteSelecionado == null
                    ? const Text('Nenhum cliente selecionado')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.clienteSelecionado!.razaoSocial,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            '${widget.clienteSelecionado!.endereco}, nº ${widget.clienteSelecionado!.numero} \nBairro: ${widget.clienteSelecionado!.bairro} \nCidade: ${widget.clienteSelecionado!.cidade} \nEstado: ${widget.clienteSelecionado!.estado} \nCEP: ${widget.clienteSelecionado!.cep}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
