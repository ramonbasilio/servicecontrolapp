// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:servicecontrolapp/page_viwer_pdf.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/components/widget_text_form_equip.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/page_search_client.dart';
import 'package:servicecontrolapp/widgets/widget_menu_type_service.dart';
import 'package:signature/signature.dart';

import '../../helper/helper_pdf.dart';
import '../../model/model_client.dart';
import '../../model/model_os.dart';

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
      SignatureController(penStrokeWidth: 2, penColor: Colors.black);
  Uint8List? fileContent;
  final _formKey = GlobalKey<FormState>();
  bool controleCampoCliente = false;
  bool controleCampoAssinatura = false;
  String? tipoAtendimento;

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

  Future<String> localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> localFile() async {
    final path = await localPath();
    return File('$path/exemplo.pdf');
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
      body: Form(
        key: _formKey,
        child: Padding(
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
                            controleCampoCliente = false;
                            widget.clienteSelecionado = clienteSelecionado;
                          });
                        }
                      },
                      child: const Text('Cliente'),
                    ),
                    const Center(
                      child: Text(
                        'DADOS DO CLIENTE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: controleCampoCliente
                                ? Colors.red
                                : Colors.black),
                        color: Colors.grey.shade200),
                    child: widget.clienteSelecionado == null
                        ? const Text('Nenhum cliente selecionado')
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.clienteSelecionado!.razaoSocial,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
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
                WidgetTextFormEquip(
                    equipamentoNomeController: equipamentoNomeController,
                    hintText: 'Nome do Equipamento',
                    label: 'Nome do equipamento',
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Digite o nome do equipamento';
                      }
                      return null;
                    }),
                WidgetTextFormEquip(
                    equipamentoNomeController: marcaNomeController,
                    hintText: 'Marca do Equipamento',
                    label: 'Marca do equipamento',
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Digite a marca do equipamento';
                      }
                      return null;
                    }),
                WidgetTextFormEquip(
                    equipamentoNomeController: modeloNomeController,
                    hintText: 'Modelo do Equipamento',
                    label: 'Modelo do equipamento',
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Digite a modelo do equipamento';
                      }
                      return null;
                    }),
                WidgetTextFormEquip(
                    equipamentoNomeController: modeloNomeController,
                    hintText: 'Número de série do equipamento',
                    label: 'Número de série do equipamento',
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Digite o número de série do equipamento';
                      }
                      return null;
                    }),
                WidgetMenuTypeService(
                  returnDropDownValue: (value) {
                    tipoAtendimento = value;
                    print("tipo de atendimento: $tipoAtendimento");
                  },
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Selecione o tipo de atendimento';
                    }
                    return null;
                  },
                ),
                const Divider(),
                const Center(
                  child: Text(
                    'RESUMO ATENDIMENTO',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                WidgetTextFormEquip(
                    isMaxLine: true,
                    equipamentoNomeController: resumoAtendimentoController,
                    hintText: 'Resumo do atendimento',
                    label: 'Resumo do atendimento',
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Digite a descrição do atendimento';
                      }
                      return null;
                    }),
                const Divider(),
                const Center(
                  child: Text(
                    'ASSINATURA CLIENTE',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controleCampoAssinatura
                                ? Colors.red
                                : Colors.black)),
                    child: Signature(
                      backgroundColor: Colors.white70,
                      controller: controller,
                      height: 200,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          File path = await File(await getFilePath()).create();
                          Uint8List? bytes = await controller.toPngBytes();
                          await path.writeAsBytes(bytes!);
                          if (controller.isEmpty) {
                            setState(() {
                              controleCampoAssinatura = true;
                            });
                          } else {
                            setState(() {
                              controleCampoAssinatura = false;
                            });
                          }
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () async {
            if (widget.clienteSelecionado == null) {
              setState(() {
                controleCampoCliente = true;
              });
            } else {
              setState(() {
                controleCampoCliente = false;
              });
            }
            if (controller.isEmpty) {
              setState(() {
                controleCampoAssinatura = true;
              });
            } else {
              setState(() {
                controleCampoAssinatura = false;
              });
            }
            if (_formKey.currentState!.validate() &&
                controleCampoAssinatura == false &&
                controleCampoCliente == false &&
                controller.isNotEmpty) {
              print('passou tudo ok');
              OrdemServicoModel ordemServicoModel = OrdemServicoModel(
                cliente: widget.clienteSelecionado!,
                descricao: resumoAtendimentoController.text,
                equipamento: equipamentoNomeController.text,
                marca: marcaNomeController.text,
                modelo: modeloNomeController.text,
                ns: numerSerieController.text,
                assinatura: fileContent!,
              );

              GeneratePdf generatePdf = GeneratePdf(
                  assinatura: fileContent!, ordemServico: ordemServicoModel);
              generatePdf.generatePdf();
              File file = await localFile();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViwerPdf(
                      path: file.path,
                    ),
                  ));
            }

            // ---------------------- TESTE ----------------------
            // OrdemServicoModel ordemServicoModel = OrdemServicoModel(
            //   cliente: widget.clienteSelecionado!,
            //   descricao:
            //       'Atendimento referente a troca de módulo. Testado e liberado para uso',
            //   equipamento: 'Monitor Multiparametro',
            //   marca: 'Medrad',
            //   modelo: 'Veris 8600',
            //   ns: '08452',
            //   assinatura: fileContent!,
            // );

            // GeneratePdf generatePdf = GeneratePdf(
            //     assinatura: fileContent!, ordemServico: ordemServicoModel);
            // generatePdf.generatePdf();
            // File file = await localFile();
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ViwerPdf(
            //         path: file.path,
            //       ),
            //     ));
            // ---------------------- TESTE ----------------------
          },
          child: const Text('Gerar pdf'),
        ),
      ),
    );
  }
}
