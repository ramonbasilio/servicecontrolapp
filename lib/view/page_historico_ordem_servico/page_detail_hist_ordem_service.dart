// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:servicecontrolapp/controller/Repository/repository_client.dart';
import 'package:servicecontrolapp/controller/provider/provider.dart';
import 'package:servicecontrolapp/extensions/time.dart';
import 'package:servicecontrolapp/helper/helper_http.dart';
import 'package:servicecontrolapp/helper/helper_page_viwer_pdf.dart';
import 'package:servicecontrolapp/helper/helper_pdf.dart';
import 'package:servicecontrolapp/main.dart';
import 'package:servicecontrolapp/model/model_client.dart';
import 'package:servicecontrolapp/model/model_os.dart';
import 'package:servicecontrolapp/utils/save_data_local.dart';
import 'package:servicecontrolapp/view/page_historico_ordem_servico/widget_menu_type_service.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/components/widget_text_form_equip.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/page_search_client.dart';
import 'package:signature/signature.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class PageDetailHistOrdemService extends StatefulWidget {
  ClienteModel? clienteSelecionado;
  OrdemServicoModel ordemServico;
  PageDetailHistOrdemService({required this.ordemServico, super.key});

  @override
  State<PageDetailHistOrdemService> createState() =>
      _PageDetailHistOrdemService();
}

class _PageDetailHistOrdemService extends State<PageDetailHistOrdemService> {
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
  SignatureController controllerAssinatura = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );
  Uint8List? fileContent;
  final _formKey = GlobalKey<FormState>();
  bool controleCampoCliente = false;
  bool controleCampoAssinatura = false;
  String? tipoAtendimento;
  final DataLocal _dataLocal = DataLocal();
  final loading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    equipamentoNomeController.dispose();
    marcaNomeController.dispose();
    modeloNomeController.dispose();
    numerSerieController.dispose();
    resumoAtendimentoController.dispose();
    controllerAssinatura.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tipoAtendimento = widget.ordemServico.tipoAtendimento;
    equipamentoNomeController.text = widget.ordemServico.equipamento;
    marcaNomeController.text = widget.ordemServico.marca;
    modeloNomeController.text = widget.ordemServico.modelo;
    numerSerieController.text = widget.ordemServico.ns;
    resumoAtendimentoController.text = widget.ordemServico.resumoAtendimento;
    dataAtendimentoController.text = widget.ordemServico.dataAtendimento;
    horaInicioAtendimentoController.text =
        widget.ordemServico.horaInicioAtendimento;
    horaFinalAtendimentoController.text =
        widget.ordemServico.horaFinalAtendimento;
    emailController.text = widget.ordemServico.emailCliente;
    nomeController.text = widget.ordemServico.nomeCliente;
    widget.clienteSelecionado = widget.ordemServico.cliente;
    super.initState();
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
                WidgetMenuTypeService2(
                  widget.ordemServico.tipoAtendimento,
                  returnDropDownValue: (value) {
                    tipoAtendimento = value!;
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
                      child: Image.memory(
                        widget.ordemServico.assinatura,
                        height: 200,
                      )),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //         onPressed: () async {
                //           //USAR createPathFile DA CLASSE DataLocal
                //           //nome do arquivo assintura.pgn
                //           File path =
                //               await _dataLocal.createPathFile('assinatura.pgn');
                //           // File path = await File(await getFilePath()).create();
                //           Uint8List? bytes =
                //               await controllerAssinatura.toPngBytes();
                //           await path.writeAsBytes(bytes!);

                //           if (controllerAssinatura.isEmpty) {
                //             setState(() {
                //               controleCampoAssinatura = true;
                //             });
                //           } else {
                //             setState(() {
                //               controleCampoAssinatura = false;
                //             });
                //           }
                //           // File file = File(await getFilePath());
                //           fileContent = await path.readAsBytes();
                //           setState(() {}); //preciso arrumar isso
                //         },
                //         child: const Text('Confirmar')),
                //     ElevatedButton(
                //         onPressed: () {
                //           controllerAssinatura.clear();
                //         },
                //         child: const Text('Limpar')),
                //   ],
                // ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: AnimatedBuilder(
                  animation: loading,
                  builder: (context, child) {
                    return loading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : const Icon(Icons.email);
                  },
                ),
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
                  if (_formKey.currentState!.validate()) {
                    print('passou tudo ok');
                    OrdemServicoModel ordemServicoModel = OrdemServicoModel(
                      idOrdemServico: widget.ordemServico.idOrdemServico,
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
                      horaInicioAtendimento:
                          horaInicioAtendimentoController.text,
                      horaFinalAtendimento: horaFinalAtendimentoController.text,
                      assinatura: widget.ordemServico.assinatura,
                    );
                    GeneratePdf generatePdf = GeneratePdf(
                        assinatura: widget.ordemServico.assinatura,
                        ordemServico: ordemServicoModel);
                    generatePdf.generatePdf();
                    File filePDf1 = await _dataLocal.createPathFile(
                        'os-${widget.ordemServico.idOrdemServico}.pdf');
                    Uint8List pdfbytes = await filePDf1.readAsBytes();
                    String base64pdf = base64Encode(pdfbytes);
                    loading.value = true;
                    await Http().callCloudFunc(
                      base64pdf,
                      widget.ordemServico,
                    );
                    loading.value = false;
                    Navigator.pop(context);
                  }
                },
              ),
              ElevatedButton(
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
                  if (_formKey.currentState!.validate()) {
                    print('passou tudo ok');
                    OrdemServicoModel ordemServicoModel = OrdemServicoModel(
                      idOrdemServico: widget.ordemServico.idOrdemServico,
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
                      horaInicioAtendimento:
                          horaInicioAtendimentoController.text,
                      horaFinalAtendimento: horaFinalAtendimentoController.text,
                      assinatura: widget.ordemServico.assinatura,
                    );
                    GeneratePdf generatePdf = GeneratePdf(
                        assinatura: widget.ordemServico.assinatura,
                        ordemServico: ordemServicoModel);
                    generatePdf.generatePdf();
                    File file = await _dataLocal.createPathFile(
                        'os-${widget.ordemServico.idOrdemServico}.pdf');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViwerPdf(
                            path: file.path,
                          ),
                        ));

                    // Uint8List pdfbytes = await file.readAsBytes();
                    // String base64pdf = base64Encode(pdfbytes);
                    // await Http().callCloudFunc(
                    //   base64pdf,
                    //   widget.ordemServico.emailCliente,
                    // );
                  }
                },
                child: const Icon(Icons.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
