import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/page_search_client.dart';
import 'package:signature/signature.dart';

import '../../model/model_client.dart';

// ignore: must_be_immutable
class PageOrdemDeServico extends StatefulWidget {
  ClienteModel? clienteSelecionado;

  PageOrdemDeServico({super.key, this.clienteSelecionado});

  @override
  State<PageOrdemDeServico> createState() => _PageOrdemDeServicoState();
}

class _PageOrdemDeServicoState extends State<PageOrdemDeServico> {
  TextEditingController equipamentoNomeController = TextEditingController();
  TextEditingController marcaNomeController = TextEditingController();
  TextEditingController modeloNomeController = TextEditingController();
  TextEditingController numerSerieController = TextEditingController();
  TextEditingController resumoAtendimentoController = TextEditingController();
  SignatureController controller =
      SignatureController(penStrokeWidth: 2, penColor: Colors.white);
  Uint8List? fileContent;

  @override
  void dispose() {
    equipamentoNomeController.dispose();
    marcaNomeController.dispose();
    modeloNomeController.dispose();
    numerSerieController.dispose();
    resumoAtendimentoController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<String> getFilePath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/assintura.pgn';
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar ordem de serviço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
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
                  const Center(
                    child: Text(
                      'DADOS DO CLIENTE',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
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
                  // height: double.infini,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(),
                      color: Colors.grey.shade200),
                  child: widget.clienteSelecionado == null
                      ? const Text('Nenhum cliente selecionado')
                      : Column(
                        mainAxisSize: MainAxisSize.min,
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
              const Center(
                child: Text(
                  'DADOS DO EQUIPAMENTO',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: equipamentoNomeController,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: const Text('Nome do Equipamento'),
                      hintText: 'Nome do Equipamento'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: marcaNomeController,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: const Text('Marca do Equipamento'),
                      hintText: 'Marca do Equipamento'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: modeloNomeController,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: const Text('Modelo do Equipamento'),
                      hintText: 'Modelo do Equipamento'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: numerSerieController,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: const Text('Número de série do Equipamento'),
                      hintText: 'Número de série do Equipamento'),
                ),
              ),
              const Divider(),
              const Center(
                child: Text(
                  'RESUMO ATENDIMENTO',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  maxLines: 15,
                  controller: resumoAtendimentoController,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: const Text('Resumo do atendimento'),
                      hintText: 'Resumo do atendimento'),
                ),
              ),
              const Divider(),
              const Center(
                child: Text(
                  'ASSINATURA CLIENTE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Signature(
                  controller: controller,
                  height: 200,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final path = await File(await getFilePath()).create();
                        Uint8List? bytes = await controller.toPngBytes();
                        await path.writeAsBytes(bytes!);
                        File file = File(await getFilePath());
                        fileContent = await file.readAsBytes();
                        setState(() {});
                      },
                      child: const Text('Confirmar')),
                  ElevatedButton(
                      onPressed: () {
                        controller.clear();
                      },
                      child: const Text('Limpar')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  color: Colors.grey,
                  width: double.infinity,
                  height: 200,
                  child: fileContent == null
                      ? const Center(child: Text('Sem assinatura salva'))
                      : Image.memory(fileContent!),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
