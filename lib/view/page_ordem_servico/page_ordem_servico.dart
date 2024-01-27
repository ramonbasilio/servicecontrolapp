// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:servicecontrolapp/controller/Firebase/firebase_service.dart';
import 'package:servicecontrolapp/controller/Repository/repository_client.dart';
import 'package:servicecontrolapp/extensions/time.dart';
import 'package:servicecontrolapp/helper/helper_page_viwer_pdf.dart';
import 'package:servicecontrolapp/controller/provider/provider.dart';
import 'package:servicecontrolapp/utils/save_data_local.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/components/widget_text_form_equip.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/page_search_client.dart';
import 'package:servicecontrolapp/widgets/widget_menu_type_service.dart';
import 'package:signature/signature.dart';
import 'package:uuid/uuid.dart';
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
  TextEditingController dataAtendimentoController = TextEditingController();
  TextEditingController horaInicioAtendimentoController =
      TextEditingController();
  TextEditingController horaFinalAtendimentoController =
      TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController nomeController = TextEditingController();

  SignatureController controller =
      SignatureController(penStrokeWidth: 2, penColor: Colors.black);
  Uint8List? fileContent;
  final _formKey = GlobalKey<FormState>();
  bool controleCampoCliente = false;
  bool controleCampoAssinatura = false;
  String? tipoAtendimento;
  final DataLocal _dataLocal = DataLocal();

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

  // Future<String> localPath() async {
  //   final directory = await getApplicationSupportDirectory();
  //   return directory.path;
  // }

  // Future<File> localFile() async {
  //   final path = await localPath();
  //   return File('$path/exemploOrdemDeServico.pdf');
  // }

  // Future<String> getFilePath() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String filePath = '${directory.path}/assintura.pgn';
  //   return filePath;
  // }

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
                WidgetTextFormEquip(
                    equipamentoNomeController: nomeController,
                    hintText: 'Nome do cliente',
                    label: 'Nome do cliente',
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Digite o nome do cliente';
                      }
                      return null;
                    }),
                WidgetTextFormEquip(
                    equipamentoNomeController: emailController,
                    hintText: 'Email do cliente',
                    label: 'Email do cliente',
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Digite o email do cliente';
                      }
                      return null;
                    }),
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
                    equipamentoNomeController: numerSerieController,
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
                //--------------------------------------------------------------------------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Selecione a data do atendimento';
                      }
                      return null;
                    },
                    readOnly: true,
                    controller: dataAtendimentoController,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        label: const Text('Data do atendimento'),
                        hintText: 'Data do atendimento'),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                        setState(() {
                          dataAtendimentoController.text = formattedDate;
                        });
                      }
                    },
                  ),
                ),
                //--------------------------------------------------------------------------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Selecione a hora de inicio do atendimento';
                      }
                      return null;
                    },
                    readOnly: true,
                    controller: horaInicioAtendimentoController,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        label: const Text('Hora início do atendimento'),
                        hintText: 'Hora início do atendimento'),
                    onTap: () async {
                      final TimeOfDay? horaAtual = await showTimePicker(
                        builder: (context, child) {
                          return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? Container());
                        },
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (horaAtual != null) {
                        setState(
                          () {
                            horaInicioAtendimentoController.text =
                                horaAtual.to24hours();
                          },
                        );
                      }
                    },
                  ),
                ),
                //--------------------------------------------------------------------------------------//
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Selecione a hora final do atendimento';
                      }
                      return null;
                    },
                    readOnly: true,
                    controller: horaFinalAtendimentoController,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        label: const Text('Hora final do atendimento'),
                        hintText: 'Hora final do atendimento'),
                    onTap: () async {
                      final TimeOfDay? horaAtual = await showTimePicker(
                        builder: (context, child) {
                          return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? Container());
                        },
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (horaAtual != null) {
                        setState(
                          () {
                            horaFinalAtendimentoController.text =
                                horaAtual.to24hours();
                          },
                        );
                      }
                    },
                  ),
                ),
                //--------------------------------------------------------------------------------------//
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
                          //USAR createPathFile DA CLASSE DataLocal
                          //nome do arquivo assintura.pgn
                          File path =
                              await _dataLocal.createPathFile('assintura.pgn');
                          // File path = await File(await getFilePath()).create();
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
                          // File file = File(await getFilePath());
                          fileContent = await path.readAsBytes();
                          setState(() {}); //preciso arrumar isso
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
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
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
                String numOS = await FirebaseService()
                    .getLastSequence(DateTime.now().year.toString());
                OrdemServicoModel ordemServicoModel = OrdemServicoModel(
                  idOrdemServico: numOS,
                  cliente: widget.clienteSelecionado!,
                  nomeCliente: nomeController.text,
                  emailCliente: emailController.text,
                  equipamento: equipamentoNomeController.text,
                  marca: marcaNomeController.text,
                  modelo: modeloNomeController.text,
                  ns: numerSerieController.text,
                  tipoAtendimento: tipoAtendimento!,
                  resumoAtendimento: resumoAtendimentoController.text,
                  dataAtendimento: dataAtendimentoController.text,
                  horaInicioAtendimento: horaInicioAtendimentoController.text,
                  horaFinalAtendimento: horaFinalAtendimentoController.text,
                  assinatura: fileContent!,
                );
                Provider.of<ProviderPdf>(context, listen: false)
                    .setEmail(emailController.text);
                GeneratePdf generatePdf = GeneratePdf(
                    assinatura: fileContent!, ordemServico: ordemServicoModel);
                generatePdf.generatePdf();

                Repository().registerOrdemService(
                    context: context, ordemServicoModel: ordemServicoModel);
              }
            },
            child: const Text('Salvar'),
          ),
        ),
      ),
    );
  }
}
